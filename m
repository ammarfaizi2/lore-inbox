Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTCGXhE>; Fri, 7 Mar 2003 18:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbTCGXfx>; Fri, 7 Mar 2003 18:35:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:55750 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261911AbTCGXfL>; Fri, 7 Mar 2003 18:35:11 -0500
Date: Fri, 07 Mar 2003 15:36:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4/6 Fix the type of get_zholes_size for NUMA-Q
Message-ID: <52340000.1047080174@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andy Whitcroft

Fix the type of get_zholes_size for NUMA-Q

diff -urpN -X /home/fletch/.diff.exclude 014-physnode_map_u8/include/asm-i386/numaq.h 015-numaq_zholes_warning/include/asm-i386/numaq.h
--- 014-physnode_map_u8/include/asm-i386/numaq.h	Wed Mar  5 07:41:55 2003
+++ 015-numaq_zholes_warning/include/asm-i386/numaq.h	Wed Mar  5 07:43:31 2003
@@ -157,7 +157,7 @@ struct sys_cfg_data {
         struct	eachquadmem eq[MAX_NUMNODES];	/* indexed by quad id */
 };
 
-static inline unsigned long get_zholes_size(int nid)
+static inline unsigned long *get_zholes_size(int nid)
 {
 	return 0;
 }

