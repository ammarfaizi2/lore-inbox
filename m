Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318959AbSHMGDC>; Tue, 13 Aug 2002 02:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSHMGDC>; Tue, 13 Aug 2002 02:03:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56334 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318959AbSHMGDC>;
	Tue, 13 Aug 2002 02:03:02 -0400
Message-ID: <3D58A45F.A7F5BDD@zip.com.au>
Date: Mon, 12 Aug 2002 23:17:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] __func__ -> __FUNCTION__
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is a requirement of the SPARC port that Linux be compilable
by egcs-1.1.2, aka gcc-2.91.66.

That compiler does not support __func__.

--- linux-2.5.31/include/linux/kernel.h	Wed Jul 24 14:31:31 2002
+++ 25/include/linux/kernel.h	Mon Aug 12 23:09:31 2002
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
+#define __func__ __FUNCTION__	/* For old gcc's */
+
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")
