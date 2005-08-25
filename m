Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVHYOGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVHYOGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHYOGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:06:18 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:40078 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965005AbVHYOGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:06:17 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Robert Love <rml@novell.com>, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1124978614.6301.44.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
	 <1124978614.6301.44.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 10:06:22 -0400
Message-Id: <1124978783.5039.29.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:03 +0200, Johannes Berg wrote:
> On Thu, 2005-08-25 at 09:47 -0400, Robert Love wrote:
> 
> > Let's just pass zero for the "above" parameter in idr_get_new_above(),
> > which is I believe the behavior of the other interface, and see if the
> > 1024-multiple problem goes away.  We definitely did not have that
> > before.
> 
> Will we then need to test if it fails for more than 1024 watches?
> 
> If I adjust the program to
> 
> 1) create /tmp/test/%d
> 2) watch /tmp/test/%d
> 3) repeat
> 
> it fails on 2.6.13-rc6 as soon as the device is full and doesn't hold
> any more directories.

Could you send me the new test program?

-- 
John McCutchan <ttb@tentacle.dhs.org>
