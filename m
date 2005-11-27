Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVK0XjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVK0XjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 18:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVK0XjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 18:39:19 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:40164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751175AbVK0XjT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 18:39:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sLfDv+crr7N5i4B4i3dgJjvT6mgYs1rnOSIu2zvnKLqYpMHbC7Hrkk+Z8Gl0RjpDoeexkJzL346vmJUVaCrJXBBI3Tn3QCrU08PSx5XnLaPHAS5NBkPOUrWHCdJJ3RtOwNCnBQNzVynEzWBMtJEB+N9IPkkUWBH4Zo63+Fl4mWc=
Message-ID: <ff1cadb20511271539n13ba2da1o@mail.gmail.com>
Date: Mon, 28 Nov 2005 00:39:18 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
To: mingo@elte.hu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.14-rt20, fixed compiled bug
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, compiled against 2.6.14-rt20, fixes a couple of compile
bugs involving files include/i386/io_apic.h and
include/x86_64/io_apic.h



--- ./patch-2.6.14-rt20.orig	2005-11-27 16:57:10.000000000 +0100
+++ ./patch-2.6.14-rt20		2005-11-27 23:43:35.000000000 +0100
@@ -26416,6 +26416,14 @@ Index: linux/include/asm-i386/io_apic.h
 ===================================================================
 --- linux.orig/include/asm-i386/io_apic.h
 +++ linux/include/asm-i386/io_apic.h
+@@ -4,6 +4,7 @@
+ #include <linux/config.h>
+ #include <asm/types.h>
+ #include <asm/mpspec.h>
++#include <asm/apicdef.h>
+
+ /*
+  * Intel IO-APIC support for SMP and UP systems.
 @@ -16,7 +16,6 @@
  #ifdef CONFIG_PCI_MSI
  static inline int use_pci_vector(void)	{return 1;}
@@ -28956,6 +28964,14 @@ Index: linux/include/asm-x86_64/io_apic.
 ===================================================================
 --- linux.orig/include/asm-x86_64/io_apic.h
 +++ linux/include/asm-x86_64/io_apic.h
+@@ -4,6 +4,7 @@
+ #include <linux/config.h>
+ #include <asm/types.h>
+ #include <asm/mpspec.h>
++#include <asm/apicdef.h>
+
+ /*
+  * Intel IO-APIC support for SMP and UP systems.
 @@ -16,11 +16,10 @@
  #ifdef CONFIG_PCI_MSI
  static inline int use_pci_vector(void)	{return 1;}




Regards,
--
Luca
