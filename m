Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbTGNLPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267261AbTGNLPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:15:49 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:15485 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S266018AbTGNLPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:15:41 -0400
Date: Mon, 14 Jul 2003 13:30:18 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: [trivial] Re: Linux v2.6.0-test1
Message-ID: <20030714113018.GA13333@spaans.vs19.net>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 08:59:07PM -0700, Linus Torvalds wrote:
> The point of the test versions is to make more people realize that they
> need testing and get some straggling developers realizing that it's too
> late to worry about the next big feature. I'm hoping that Linux vendors
> will start offering the test kernels as installation alternatives, and
> do things like make upgrade internal machines, so that when the real
> 2.6.0 does happen, we're all set.

Just tried to build this for powerpc, needs at least the following trivial
patch to compile:

--- linux-2.5-ppc/arch/ppc/kernel/time.c~	2003-07-14 13:15:17.000000000 +0200
+++ linux-2.5-ppc/arch/ppc/kernel/time.c	2003-07-14 13:18:02.000000000 +0200
@@ -244,7 +244,7 @@
 	time_t wtm_sec, new_sec = tv->tv_sec;
 	long wtm_nsec, new_nsec = tv->tv_nsec;
 	unsigned long flags;
-	int tb_delta, new_nsec, new_sec;
+	int tb_delta;
 
 	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;


Regards,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/

<==  The only intuitive interface ever created was a   ==>
<==                      nipple.                       ==>
