Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUCXHRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCXHRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:17:13 -0500
Received: from pop.gmx.net ([213.165.64.20]:14051 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263041AbUCXHRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:17:07 -0500
X-Authenticated: #20450766
Date: Wed, 24 Mar 2004 08:15:48 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Richard Browning <richard@redline.org.uk>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       <linux-kernel@vger.kernel.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel
 2.4.x 2.6.x / Crash/Freeze
In-Reply-To: <200403240401.42322.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.44.0403240740480.2318-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004, Richard Browning wrote:

> On Monday 22 March 2004 07:25, Guennadi Liakhovetski wrote:
> > Aha! A single thread? A specific asm insn? Is gcc --version enough to kill
> > the machine? Or on smth like
> > int main(void)
> > {return 0;}
> > gcc -E; gcc -S; gcc -c; ld? Step-by-step with gdb (hopefully, gdb doesn't
> > have this insn...). NMI watchdog?
>
> gcc -version is fine. A compile will cause the problem.
>
> It should be noted that whilst a ./configure cycle is *guaranteed* to initiate
> the MCE, the MCE can occur on other (seemingly random) occasions.

Sorry, I should have been more explicit. I had 0 time (writing before
going to work, like now). So, what I really wanted to ask is the
following:

1) does gcc (compile) always cause an MCE?
2) If yes, can you try to narrow it down by
	a) running separately different gcc stages on a trivial C-program,
	like the one above (preprocessor with gcc -E, produce assembly
	output with gcc -S, compile without linking with gcc -c, link with
	ld)
	b) once you've figured out which stage causes it, try to further
	narrow it down by running this stage under gdb. Since you
	re-compiled gcc yourself, you should have the sources at hand, and
	should be able set up a couple of break-points to narrow it down
	gradually, eventually coming to a single assembly instruction - if
	my suspicion is right.

> This of course smacks of hardware failure, but not only are the components new
> I have also swapped them all (excluding graphics card.) And, don't forget,
> simple dual 'SMP' mode works fine too.

I know. You can compile with the Java compiler, but not with gcc. Can you
explain, why? I cannot.

Thanks
Guennadi
---
Guennadi Liakhovetski


