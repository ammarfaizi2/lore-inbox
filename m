Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbTGJQyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbTGJQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:54:33 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:15624 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S269379AbTGJQy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:54:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1057856944622@movementarian.org>
Subject: [PATCH 1/3] OProfile: __exit fixes
In-Reply-To: 
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 10 Jul 2003 18:09:04 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19aeun-000AiV-J7*HNAT4HOD.BI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
oprofile_arch_exit() can be called from an __init routine now. Remove the remaining
incorrect __exit markers.

diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/init.c linux-fixes/arch/i386/oprofile/init.c
--- linux-cvs/arch/i386/oprofile/init.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/init.c	2003-06-20 00:19:14.000000000 +0100
@@ -34,7 +34,7 @@
 }
 
 
-void __exit oprofile_arch_exit(void)
+void oprofile_arch_exit(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
 	nmi_exit();
diff -Naur -X dontdiff linux-cvs/arch/parisc/oprofile/init.c linux-fixes/arch/parisc/oprofile/init.c
--- linux-cvs/arch/parisc/oprofile/init.c	2003-06-17 15:58:45.000000000 +0100
+++ linux-fixes/arch/parisc/oprofile/init.c	2003-06-20 00:19:24.000000000 +0100
@@ -20,6 +20,6 @@
 }
 
 
-void __exit oprofile_arch_exit()
+void oprofile_arch_exit()
 {
 }
diff -Naur -X dontdiff linux-cvs/arch/ppc64/oprofile/init.c linux-fixes/arch/ppc64/oprofile/init.c
--- linux-cvs/arch/ppc64/oprofile/init.c	2003-05-04 02:42:02.000000000 +0100
+++ linux-fixes/arch/ppc64/oprofile/init.c	2003-06-20 00:19:32.000000000 +0100
@@ -19,6 +19,6 @@
 }
 
 
-void __exit oprofile_arch_exit(void)
+void oprofile_arch_exit(void)
 {
 }
diff -Naur -X dontdiff linux-cvs/arch/sparc64/oprofile/init.c linux-fixes/arch/sparc64/oprofile/init.c
--- linux-cvs/arch/sparc64/oprofile/init.c	2003-05-04 19:01:46.000000000 +0100
+++ linux-fixes/arch/sparc64/oprofile/init.c	2003-06-20 00:19:40.000000000 +0100
@@ -20,6 +20,6 @@
 }
 
 
-void __exit oprofile_arch_exit(void)
+void oprofile_arch_exit(void)
 {
 }

