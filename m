Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSL3Luy>; Mon, 30 Dec 2002 06:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSL3Luy>; Mon, 30 Dec 2002 06:50:54 -0500
Received: from verein.lst.de ([212.34.181.86]:31758 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S266955AbSL3Lux>;
	Mon, 30 Dec 2002 06:50:53 -0500
Date: Mon, 30 Dec 2002 12:59:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: sfr@canb.auug.org.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] apm.c redclares savesegment
Message-ID: <20021230125907.A16745@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, sfr@canb.auug.org.au,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.. but it could just use the generic version


--- 1.40/arch/i386/kernel/apm.c	Sun Nov 17 15:18:07 2002
+++ edited/arch/i386/kernel/apm.c	Mon Dec 30 02:10:53 2002
@@ -331,12 +331,6 @@
 #define DEFAULT_BOUNCE_INTERVAL		(3 * HZ)
 
 /*
- * Save a segment register away
- */
-#define savesegment(seg, where) \
-		__asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
-
-/*
  * Maximum number of events stored
  */
 #define APM_MAX_EVENTS		20
