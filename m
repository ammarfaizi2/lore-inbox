Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTCERR3>; Wed, 5 Mar 2003 12:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTCERRD>; Wed, 5 Mar 2003 12:17:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10398 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267481AbTCERPJ>; Wed, 5 Mar 2003 12:15:09 -0500
Date: Wed, 05 Mar 2003 09:25:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4/6 Fix the type of get_zholes_size for NUMA-Q
Message-ID: <159190000.1046885136@[10.10.2.4]>
In-Reply-To: <158830000.1046885093@[10.10.2.4]>
References: <157940000.1046884990@[10.10.2.4]> <158450000.1046885053@[10.10.2.4]> <158830000.1046885093@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
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

