Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUCARNB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUCARNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:13:01 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:54061 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261369AbUCARM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:12:58 -0500
Date: Mon, 1 Mar 2004 18:12:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Boehm Olaf <olaf.boehm@lanner.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile
Message-ID: <20040301171239.GA1988@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Boehm Olaf <olaf.boehm@lanner.de>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EXTRA_CFLAGS assignments in the following files are a left-over
from the early 2.5 days where the source was not compiled from the
root of the source tree.
Removing these wrong assignments fixes
http://bugme.osdl.org/show_bug.cgi?id=2210

A script named 'kernel' in the .. directory no longer halt compilation.

	Sam

kbuild-fix-cflags-assign-in-mach.patch:

===== arch/i386/mach-default/Makefile 1.8 vs edited =====
--- 1.8/arch/i386/mach-default/Makefile	Sun Dec 22 13:08:42 2002
+++ edited/arch/i386/mach-default/Makefile	Mon Mar  1 18:03:03 2004
@@ -2,6 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_CFLAGS	+= -I../kernel
-
 obj-y				:= setup.o topology.o
===== arch/i386/mach-es7000/Makefile 1.1 vs edited =====
--- 1.1/arch/i386/mach-es7000/Makefile	Sun Jun 15 01:15:56 2003
+++ edited/arch/i386/mach-es7000/Makefile	Mon Mar  1 18:04:11 2004
@@ -2,6 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_CFLAGS	+= -I../kernel
-
 obj-y		:= setup.o topology.o es7000.o
===== arch/i386/mach-pc9800/Makefile 1.1 vs edited =====
--- 1.1/arch/i386/mach-pc9800/Makefile	Thu Feb 20 17:28:14 2003
+++ edited/arch/i386/mach-pc9800/Makefile	Mon Mar  1 18:04:15 2004
@@ -2,6 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_CFLAGS	+= -I../kernel
-
 obj-y				:= setup.o topology.o
===== arch/i386/mach-visws/Makefile 1.6 vs edited =====
--- 1.6/arch/i386/mach-visws/Makefile	Wed Feb 19 03:58:56 2003
+++ edited/arch/i386/mach-visws/Makefile	Mon Mar  1 18:04:21 2004
@@ -2,8 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-EXTRA_CFLAGS	+= -I../kernel
-
 obj-y				:= setup.o traps.o reboot.o
 
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
