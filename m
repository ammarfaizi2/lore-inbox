Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUAQCWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUAQCWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:22:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34283 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266009AbUAQCW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:22:27 -0500
Date: Sat, 17 Jan 2004 03:22:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040117022222.GI12027@fs.tum.de>
References: <20040115225948.6b994a48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:59:48PM -0800, Andrew Morton wrote:
>...
> - There's a patch here which changes the ia32 CPU type selection.  Make
>   sure you go in there and select the right CPU type(s), else the kernel
>   won't compile.   We might need to set a default here.
>...

Hi Andrew,

thanks for including my patch to give it further testing, and also 
thanks for this suggestion.

The patch below lets all cpu options default to "y".

cu
Adrian


--- linux-2.6.1-mm4/arch/i386/Kconfig.old	2004-01-17 02:13:22.000000000 +0100
+++ linux-2.6.1-mm4/arch/i386/Kconfig	2004-01-17 02:14:51.000000000 +0100
@@ -147,11 +147,13 @@
 
 config CPU_386
 	bool "386"
+	default y
 	help
 	  Select this for a 386 series processor.
 
 config CPU_486
 	bool "486"
+	default y
 	help
 	  Select this for a 486 series processor, either Intel or one of the
 	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
@@ -160,6 +162,7 @@
 
 config CPU_586
 	bool "586/K5/5x86/6x86/6x86MX"
+	default y
 	help
 	  Select this for a non-Intel 586 or 686 series processor such as
 	  the AMD K5 or the Cyrix 6x86MX.
@@ -173,41 +176,48 @@
 
 config CPU_586TSC
 	bool "Pentium-Classic"
+	default y
 	help
 	  Select this for a Pentium Classic processor with the RDTSC (Read
 	  Time Stamp Counter) instruction.
 
 config CPU_586MMX
 	bool "Pentium-MMX"
+	default y
 	help
 	  Select this for a Pentium with the MMX graphics/multimedia
 	  extended instructions.
 
 config CPU_686
 	bool "Pentium-Pro"
+	default y
 	help
 	  Select this for Intel Pentium Pro chips.
 
 config CPU_PENTIUMII
 	bool "Pentium-II/Celeron(pre-Coppermine)"
+	default y
 	help
 	  Select this for Intel chips based on the Pentium-II and
 	  pre-Coppermine Celeron core.
 
 config CPU_PENTIUMIII
 	bool "Pentium-III/Celeron(Coppermine)/Pentium-III Xeon"
+	default y
 	help
 	  Select this for Intel chips based on the Pentium-III and
 	  Celeron-Coppermine core.
 
 config CPU_PENTIUMM
 	bool "Pentium M"
+	default y
 	help
 	  Select this for Intel Pentium M (not Pentium-4 M)
 	  notebook chips.
 
 config CPU_PENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
+	default y
 	help
 	  Select this for Intel Pentium 4 chips.  This includes
 	  the Pentium 4, P4-based Celeron and Xeon, and
@@ -215,42 +225,50 @@
 
 config CPU_K6
 	bool "K6/K6-II/K6-III"
+	default y
 	help
 	  Select this for an AMD K6, K6-II or K6-III (aka K6-3D).
 
 config CPU_K7
 	bool "Athlon/Duron/K7"
+	default y
 	help
 	  Select this for an AMD Athlon K7-family processor.
 
 config CPU_K8
 	bool "Opteron/Athlon64/Hammer/K8"
+	default y
 	help
 	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.
 
 config CPU_CRUSOE
 	bool "Crusoe"
+	default y
 	help
 	  Select this for a Transmeta Crusoe processor.
 
 config CPU_WINCHIPC6
 	bool "Winchip-C6"
+	default y
 	help
 	  Select this for an IDT Winchip C6 chip.
 
 config CPU_WINCHIP2
 	bool "Winchip-2"
+	default y
 	help
 	  Select this for an IDT Winchip-2.
 
 config CPU_WINCHIP3D
 	bool "Winchip-2A/Winchip-3"
+	default y
 	help
 	  Select this for an IDT Winchip-2A or 3 with 3dNow!
 	  capabilities.
 
 config CPU_CYRIXIII
 	bool "Cyrix III/VIA C3"
+	default y
 	help
 	  Select this for a Cyrix III or VIA C3 chip.
 
@@ -259,6 +277,7 @@
 
 config CPU_VIAC3_2
 	bool "VIA C3-2 (Nehemiah)"
+	default y
 	help
 	  Select this for a VIA C3 "Nehemiah" (model 9 and above).
 
