Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWAMQPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWAMQPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWAMQPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:15:22 -0500
Received: from mail.gmx.de ([213.165.64.21]:55247 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964856AbWAMQPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:15:21 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060113165958.00beb8e0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 13 Jan 2006 17:15:10 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200601140134.46457.kernel@kolivas.org>
References: <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
 <20060113114607.54c83fc8@localhost>
 <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:34 AM 1/14/2006 +1100, Con Kolivas wrote:
>On Saturday 14 January 2006 00:01, Mike Galbraith wrote:
> > At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
> > >See my followup patches that I have posted following "[PATCH 0/5] sched -
> > >interactivity updates". The first 3 patches are what you tested. These
> > >patches are being put up for testing hopefully in -mm.
> >
> > Then the (buggy) version of my simple throttling patch will need to come
> > out.  (which is OK, I have a debugged potent++ version)
>
>Your code need not be mutually exclusive with mine. I've simply damped the
>current behaviour. Your sanity throttling is a good idea.

I didn't mean to imply that they're mutually exclusive, and after doing 
some testing, I concluded that it (or something like it) is definitely 
still needed.  The version that's in mm2 _is_ buggy however, so ripping it 
back out wouldn't hurt my delicate little feelings one bit.  In fact, it 
would give me some more time to instrument and test integration with your 
changes.  (Which I think are good btw because they remove what I considered 
to be warts; the pipe and uninterruptible sleep barriers.  Um... try irman2 
now... pure evilness)

         -Mike 

