Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbRFCMJ0>; Sun, 3 Jun 2001 08:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbRFCME0>; Sun, 3 Jun 2001 08:04:26 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:9705 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262868AbRFCMEW>;
	Sun, 3 Jun 2001 08:04:22 -0400
Date: Sun, 3 Jun 2001 14:04:16 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106031204.OAA29677@harpo.it.uu.se>
To: laughing@shared-source.org
Subject: Re: Linux 2.4.5-ac7
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jun 2001 00:23:10 +0100, Alan Cox wrote:

>2.4.5-ac6
>...
>o	Resync with Eric's master Configure.help	(Eric Raymond)

ac5->ac6 accidentally(?) dropped the help text for CONFIG_X86_UP_APIC.
Patch below (vs -ac7) adds it back. Please apply.

/Mikael

--- linux-2.4.5-ac7/Documentation/Configure.help.~1~	Sun Jun  3 12:59:52 2001
+++ linux-2.4.5-ac7/Documentation/Configure.help	Sun Jun  3 13:06:50 2001
@@ -243,6 +243,18 @@
   chip, if it's not found then Linux falls back to PC-style interrupt
   handling.
 
+APIC Support on Uniprocessors
+CONFIG_X86_UP_APIC
+  APIC (Advanced Programmable Interrupt Controller) is a scheme for
+  delivering hardware interrupt requests to the CPU. It is commonly
+  used on systems with several CPUs. If you have a single-CPU system
+  which has a processor that has an integrated APIC, you can say Y
+  here to enable and use it. If you say Y here even though your
+  machine doesn't have an APIC, then the kernel will still run with no
+  slowdown at all. The advantage of APIC support is the possibility
+  to use performance counters, and the APIC based NMI watchdog which
+  detects hard lockups.
+
 Kernel math emulation
 CONFIG_MATH_EMULATION
   Linux can emulate a math coprocessor (used for floating point
