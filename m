Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263858AbTCVRfn>; Sat, 22 Mar 2003 12:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbTCVRfP>; Sat, 22 Mar 2003 12:35:15 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:20241
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S263799AbTCVRdx>; Sat, 22 Mar 2003 12:33:53 -0500
Subject: Re: [PATCH] to drivers/parport/ieee1284_ops.c to fix timing
	dependent hang
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Tim Josling <tej@melbpc.org.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Philip.Blundell@pobox.com, linux-parport@torque.net
In-Reply-To: <3E7C2BA0.4040100@melbpc.org.au>
References: <3E782567.3020008@melbpc.org.au>
	 <1048278154.6017.2.camel@ixodes.goop.org>  <3E7C2BA0.4040100@melbpc.org.au>
Content-Type: text/plain
Organization: 
Message-Id: <1048355094.8537.11.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Mar 2003 09:44:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 01:23, Tim Josling wrote:
> According to my reading of the code, it should only happen in polled 
> mode, but I have only one week of experience looking at kernel source.

I'm wondering if a better fix might be to have something like:

	if (wait * 2 > wait)
		wait *= 2;

at the bottom of the loop, so that the wrap-around doesn't happen.

> So it should be a work-around, assuming interrupts work on the parallel 
> port on your system :-). It is an very vexing problem, as I'm sure you know.
> 
> By the way, LJ1100s tend to get page feeding problems about the time the 
> warranty runs out, but HP has a free kit you can order to fix the problem.

Yes, I just installed it.  It suddenly made the printer useful again, so
I've printing more, and seeing the hangs.  I enabled interrupts, which
seems to work OK.

	J

