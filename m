Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTDHAFQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTDHADW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:03:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26241
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263852AbTDGX0b (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:26:31 -0400
Date: Tue, 8 Apr 2003 01:45:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080045.h380jQtV009372@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: use mach io_ports definitions in io_apic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allows for the non standard cascade

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/kernel/io_apic.c linux-2.5.67-ac1/arch/i386/kernel/io_apic.c
--- linux-2.5.67/arch/i386/kernel/io_apic.c	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/i386/kernel/io_apic.c	2003-04-08 00:40:21.000000000 +0100
@@ -38,6 +38,8 @@
 
 #include <mach_apic.h>
 
+#include "io_ports.h"
+
 #undef APIC_LOCKUP_DEBUG
 
 #define APIC_LOCKUP_DEBUG
@@ -2135,7 +2137,7 @@
  * Additionally, something is definitely wrong with irq9
  * on PIIX4 boards.
  */
-#define PIC_IRQS	(1<<2)
+#define PIC_IRQS	(1 << PIC_CASCADE_IR)
 
 void __init setup_IO_APIC(void)
 {
