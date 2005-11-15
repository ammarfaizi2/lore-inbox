Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVKOO2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVKOO2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKOO2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:28:50 -0500
Received: from petasus.ims.intel.com ([62.118.80.130]:57053 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1751426AbVKOO2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:28:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] assembler debug info
Date: Tue, 15 Nov 2005 17:28:31 +0300
Message-ID: <E124AAE027DA384D8B919F93E4D8C708AB275E@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] assembler debug info
Thread-Index: AcXp8NpqDAmJ52ewThWbSJ8yILkj0w==
From: "Fedotov, Anton" <anton.fedotov@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <trivial@rustcorp.com.au>, <torvalds@osdl.org>
X-OriginalArrivalTime: 15 Nov 2005 14:28:32.0514 (UTC) FILETIME=[DAF99620:01C5E9F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch compensates lack of debug information from assembler
files.
It helps nm or objdump (with option -l)  to find a filename and line
number for 
each symbol defined in *.S files using debugging information.
        Signed-off-by: Anton Fedotov <anton.fedotov@intel.com>

diff -urN linux-2.6.14/Makefile linux/Makefile
--- linux-2.6.14/Makefile	2005-10-28 04:02:08.000000000 +0400
+++ linux/Makefile	2005-11-10 15:49:54.000000000 +0300
@@ -525,6 +525,7 @@
 
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
+AFLAGS		+= -g
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
