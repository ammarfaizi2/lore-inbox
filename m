Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVHYNsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVHYNsB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHYNsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:48:01 -0400
Received: from peabody.ximian.com ([130.57.169.10]:13751 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964987AbVHYNsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:48:00 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124977253.5039.13.camel@vertex>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 09:47:52 -0400
Message-Id: <1124977672.32272.10.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:40 -0400, John McCutchan wrote:

> I get that message a lot. I know I have said this before (and was wrong)
> but I think the idr layer is busted.

This time I think I agree with you.  ;-)

Let's just pass zero for the "above" parameter in idr_get_new_above(),
which is I believe the behavior of the other interface, and see if the
1024-multiple problem goes away.  We definitely did not have that
before.

If it does, and we don't have another solution, let's run with that for
2.6.13.  I don't want this bug released.

	Robert Love


