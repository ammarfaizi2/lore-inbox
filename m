Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274874AbTGaVZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274876AbTGaVZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:25:28 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:45218 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S274874AbTGaVZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:25:13 -0400
Date: Thu, 31 Jul 2003 23:25:09 +0200 (MEST)
Message-Id: <200307312125.h6VLP9G6022368@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: vherva@niksula.hut.fi
Subject: Re: [PATCH] NMI watchdog documentation
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 08:44:48 +0300, Ville Herva wrote:
>Uuh, sorry. Is the one below ok by you for submission to Linus and Marcelo?
>
>
>-- v --
>
>v@iki.fi
>
>--- linux/Documentation/nmi_watchdog.txt	Sun Jul 27 19:58:26 2003
>+++ linux~/Documentation/nmi_watchdog.txt	Tue Jul 29 21:08:01 2003
>@@ -1,9 +1,11 @@
> 
>-Is your ix86 system locking up unpredictably? No keyboard activity, just
>+[NMI watchdog is available for x86 and x86-64 architectures]
>+
>+Is your system locking up unpredictably? No keyboard activity, just
> a frustrating complete hard lockup? Do you want to help us debugging
> such lockups? If all yes then this document is definitely for you.
> 
>-On Intel and similar ix86 type hardware there is a feature that enables
>+On many x86/x86-64 type hardware there is a feature that enables
> us to generate 'watchdog NMI interrupts'.  (NMI: Non Maskable Interrupt
> which get executed even if the system is otherwise locked up hard).
> This can be used to debug hard kernel lockups.  By executing periodic
>@@ -20,6 +22,15 @@
> kernel debugging options, such as Kernel Stack Meter or Kernel Tracer,
> may implicitly disable the NMI watchdog.]
> 
>+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
>+always enabled with I/O-APIC mode (nmi_watchdog=1). Currently, local APIC
>+mode (nmi_watchdog=2) does not work on x86-64.
>+
>+Using local APIC (nmi_watchdog=2) needs the first performance register, so
>+you can't use it for other purposes (such as high precision performance
>+profiling.) However, at least oprofile and the perfctr driver disable the
>+local APIC NMI watchdog automatically.
>+
> To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
> parameter.  Eg. the relevant lilo.conf entry:

Looks Ok to me.

/Mikael
