Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUHVTsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUHVTsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268081AbUHVTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:48:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1680 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267720AbUHVTs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:48:29 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>
	 <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
	 <1093174557.24319.55.camel@localhost.localdomain>
	 <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1093200364.24866.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 19:46:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 19:27, Tomasz Kłoczko wrote:
> Using yor thing path: KProbe/Dtrace is for development and yes it must 
> depend on DEBUG_KERNEL.
> ptrace() is also for tracing and ver offen used by developers but it is 
> enabled by default and it is not only for developers. So .. ptrace() must 
> also depend on DEBUG_KERNEL.

ptrace is for debugging user space, as for example is oprofile. kprobes
is for debugging including kernel internal goings on

> compilation stage). In Solaris kernel exist few thousands avalaible probes 
> and IIRC only very small subset is "near zero effect" (uses nop 
> instructions).

Sounds like a kprobes clone 8). 

> > OProfile doesn't require this.
> 
> As same as KProbe/DTrace. Can you use OProfile for something other tnan 
> profiling ? Probably yes and this answer opens: probably it will be good 
> prepare some common code for KProbe and Oprofile.

Oprofile lets you work on stuff like cache affinity, tuning array walks
and prefetches. Short of running the app under cachegrind its one of the
most detailed ways of getting all the profile register data from the x86
processors.

> So it will be good stop disscuss about "yes or no ?" and start about
> "how and when in Linux ?" ..

When you send patches ?

> > We have crash dumps - at least all the enterprise vendors do. Linus
> > doesn't seem to like that stuff so much.
> It need some more advanced additional tools for analize and report data
> from CD.

Standard debugging tools. The system dumps across the network to a
server and then you can analyse it offline

> OProfile it will be good integrate ASAP also things like KProbes and CD.
> It is not only extenging entropy kernel tree. IMO KProbe can bring some
> functionalities wich can be common also for OProfile and probably in 
> future IMO OProfile can be droped.

You clearly haven't understood what Oprofile does. Its a parallel
technology that is more in common with say Intel's vtune.

