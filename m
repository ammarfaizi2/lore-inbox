Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVHYOjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVHYOjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVHYOjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:39:47 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:32078 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750739AbVHYOjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:39:46 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Robert Love <rml@novell.com>, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1124979193.19546.1.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
	 <1124978614.6301.44.camel@localhost>  <1124978783.5039.29.camel@vertex>
	 <1124979193.19546.1.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 10:39:56 -0400
Message-Id: <1124980797.6464.9.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:13 +0200, Johannes Berg wrote:
> On Thu, 2005-08-25 at 10:06 -0400, John McCutchan wrote:
> > > it fails on 2.6.13-rc6 as soon as the device is full and doesn't hold
> > > any more directories.
> 
> Obviously this wasn't true, I was hitting the 8192 watches limit and
> misinterpreted the error message. I just tested up to 100000 watches
> with this program.

Thanks. The program runs fine, it climbs up until 8192. This confirmed a
hunch I had. The problem only manifests itself when the lower idr
numbers aren't actually being used. The thread
http://www.redhat.com/archives/dm-devel/2004-July/msg00003.html seems
somewhat related to this problem, but it suggests that this was fixed in
2.6.7.

-- 
John McCutchan <ttb@tentacle.dhs.org>
