Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTBXS05>; Mon, 24 Feb 2003 13:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTBXSVr>; Mon, 24 Feb 2003 13:21:47 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:58081 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267359AbTBXSMR>; Mon, 24 Feb 2003 13:12:17 -0500
Date: Mon, 24 Feb 2003 19:22:28 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] extern in sleep.c
Message-ID: <Pine.LNX.4.51.0302241919050.27815@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a following warning in 2.5.62-bk7:

arch/i386/kernel/acpi/sleep.c: In function `acpi_restore_state_mem':
arch/i386/kernel/acpi/sleep.c:62: warning: implicit declaration of
function `zap_low_mappings'

Here's an extern to cover it:

--- linux-2.5.60/arch/i386/kernel/acpi/sleep.c~	2003-02-18 17:48:18.000000000 +0100
+++ linux-2.5.60/arch/i386/kernel/acpi/sleep.c	2003-02-24 19:13:20.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/bootmem.h>
 #include <asm/smp.h>

+extern void zap_low_mappings (void);

 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
