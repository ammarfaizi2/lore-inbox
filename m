Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTCGHD3>; Fri, 7 Mar 2003 02:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbTCGHD3>; Fri, 7 Mar 2003 02:03:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10904 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261382AbTCGHD2>; Fri, 7 Mar 2003 02:03:28 -0500
Date: Thu, 06 Mar 2003 23:13:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH] revert pfn_to_nid change.
Message-ID: <316700000.1047021237@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change was wrong. pfn_to_nid is a macro.
Please apply the following patch to revert it.

diff -urpN -X /home/fletch/.diff.exclude pfn_to_nid_backwards/arch/i386/kernel/i386_ksyms.c virgin/arch/i386/kernel/i386_ksyms.c
--- pfn_to_nid_backwards/arch/i386/kernel/i386_ksyms.c	Thu Mar  6 23:12:10 2003
+++ virgin/arch/i386/kernel/i386_ksyms.c	Wed Mar  5 07:36:57 2003
@@ -68,9 +68,6 @@ EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
-#ifdef CONFIG_X86_NUMAQ
-EXPORT_SYMBOL(pfn_to_nid);
-#endif
 #endif
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);

