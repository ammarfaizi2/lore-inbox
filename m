Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCXORC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCXORC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVCXORC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:17:02 -0500
Received: from koto.vergenet.net ([210.128.90.7]:12756 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261191AbVCXORA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:17:00 -0500
Date: Thu, 24 Mar 2005 17:22:58 +0900
From: Horms <horms@verge.net.au>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] earlyquirk.o is needed for CONFIG_ACPI_BOOT
Message-ID: <20050324082258.GA2314@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that this patch to the Makefile is needed
to ensure earlyquirk.c is compiled if CONFIG_ACPI_BOOT is enabled.

Signed-off-by: Horms <horms@verge.net.au>

--- a/arch/i386/kernel/Makefile	2005-03-24 15:47:08.391718540 +0900
+++ b/arch/i386/kernel/Makefile.noedit	2005-03-24 15:46:56.433281792 +0900
@@ -36,11 +36,11 @@
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_APM)		+= apm.o
-obj-$(CONFIG_ACPI_BOOT)		+= acpi.o earlyquirk.o
+obj-$(CONFIG_ACPI_BOOT)		+= acpi.o
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
-obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o earlyquirk.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 obj-$(CONFIG_CPU_EMU486)	+= emu.o
 obj-$(CONFIG_EDD)             	+= edd.o

