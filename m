Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbTHaGEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 02:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTHaGEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 02:04:39 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:59009
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261737AbTHaGEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 02:04:37 -0400
Date: Sun, 31 Aug 2003 02:04:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6-mm] Remove extra .data.idt section definition
Message-ID: <Pine.LNX.4.53.0308302353570.16584@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 vmlinux.lds.S
--- linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S	30 Aug 2003 23:30:57 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm4/arch/i386/kernel/vmlinux.lds.S	31 Aug 2003 03:28:58 -0000
@@ -55,9 +55,6 @@ SECTIONS
   . = ALIGN(PAGE_SIZE_asm);
   __nosave_end = .;
 
-  . = ALIGN(PAGE_SIZE_asm);
-  .data.page_aligned : { *(.data.idt) }
-
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
