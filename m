Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSJPQpq>; Wed, 16 Oct 2002 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbSJPQpp>; Wed, 16 Oct 2002 12:45:45 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:49051 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265140AbSJPQpo> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (5/6): cpu_online_map.
Date: Wed, 16 Oct 2002 18:48:37 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161848.37876.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add volatile to extern declaration of cpu_possible_map.

diff -urN linux-2.5.43/include/asm-s390/smp.h linux-2.5.43-s390/include/asm-s390/smp.h
--- linux-2.5.43/include/asm-s390/smp.h	Wed Oct 16 05:28:22 2002
+++ linux-2.5.43-s390/include/asm-s390/smp.h	Wed Oct 16 17:54:22 2002
@@ -29,7 +29,7 @@
 } sigp_info;
 
 extern volatile unsigned long cpu_online_map;
-extern unsigned long cpu_possible_map;
+extern volatile unsigned long cpu_possible_map;
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 

