Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWHKJV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWHKJV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWHKJV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:21:26 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:37254 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751019AbWHKJVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:21:25 -0400
Date: Fri, 11 Aug 2006 02:21:24 -0700
Message-Id: <200608110921.k7B9LO7Z023366@zach-dev.vmware.com>
Subject: [PATCH 8/9] 00mmd pae compile fix
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:21:24.0432 (UTC) FILETIME=[841A2D00:01C6BD27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During tracking down a PAE compile failure, I found that config.h was
being included in a bunch of places in i386 code.  It is no longer
necessary, so drop it.

Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -10,8 +10,6 @@
  *	For further information, look at Documentation/svga.txt.
  *
  */
-
-#include <linux/config.h> /* for CONFIG_VIDEO_* */
 
 /* Enable autodetection of SVGA adapters and modes. */
 #undef CONFIG_VIDEO_SVGA
===================================================================
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -13,7 +13,6 @@
  *  Mikael Pettersson	: PM converted to driver model. Disable/enable API.
  */
 
-#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
===================================================================
--- a/arch/i386/lib/delay.c
+++ b/arch/i386/lib/delay.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 
===================================================================
--- a/include/asm-i386/dwarf2.h
+++ b/include/asm-i386/dwarf2.h
@@ -1,7 +1,5 @@
 #ifndef _DWARF2_H
 #define _DWARF2_H
-
-#include <linux/config.h>
 
 #ifndef __ASSEMBLY__
 #warning "asm/dwarf2.h should be only included in pure assembly files"
===================================================================
--- a/include/asm-i386/tsc.h
+++ b/include/asm-i386/tsc.h
@@ -6,7 +6,6 @@
 #ifndef _ASM_i386_TSC_H
 #define _ASM_i386_TSC_H
 
-#include <linux/config.h>
 #include <asm/processor.h>
 
 /*
===================================================================
--- a/include/linux/unwind.h
+++ b/include/linux/unwind.h
@@ -11,8 +11,6 @@
  * full-blown stack unwinding with all the bells and whistles, so there
  * is not much point in implementing the full Dwarf2 unwind API.
  */
-
-#include <linux/config.h>
 
 struct module;
 
===================================================================
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -3,7 +3,6 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
-#include <linux/config.h>
 #include <linux/mmzone.h>
 #include <asm/atomic.h>
 
