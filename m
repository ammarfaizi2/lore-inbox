Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbTCVMYH>; Sat, 22 Mar 2003 07:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbTCVMYH>; Sat, 22 Mar 2003 07:24:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51728 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262741AbTCVMYE>; Sat, 22 Mar 2003 07:24:04 -0500
Date: Sat, 22 Mar 2003 07:30:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.65] Broken gcc test
In-Reply-To: <20030321202034.GA3101@ip68-101-124-193.oc.oc.cox.net>
Message-ID: <Pine.LNX.3.96.1030322072248.16653B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Barry K. Nathan wrote:

> On Fri, Mar 21, 2003 at 02:14:16PM -0500, Bill Davidsen wrote:
> > It seems that a test for the frame pointer gcc bug was incorrectly added 
> > to the build process, rejecting all 2.96 compilers (which generate better 
> > code than 3.2) instead of just the broken ones.
> [snip]
> 
> AFAICT Linus did this intentionally:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/1031.html
> 
> "Yeah, it will get some fixed compilers too, but that's just not worth
> worrying about - people will just have to turn off CONFIG_FRAME_POINTER
> and be happy."
> 
> -Barry K. Nathan <barryn@pobox.com>

So the choice is to use the 3.x compiler which has issues as well as
generating slow code, or to not be able to generate a decent error report
if something doesn't work right, rip the half-assed check out, or just use
2.4 kernels.

The problem is that it gets ALL fixed compilers in the 2.96 family, only a
few are broken, and it seems safe to assume that people who are building
test kernels probably have upgraded their compiler.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

