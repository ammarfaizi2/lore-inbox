Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261153AbSI3T1K>; Mon, 30 Sep 2002 15:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSI3T1K>; Mon, 30 Sep 2002 15:27:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261153AbSI3T1J>;
	Mon, 30 Sep 2002 15:27:09 -0400
Date: Mon, 30 Sep 2002 20:32:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] Remove QDIO_BH
Message-ID: <20020930203234.R18377@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


QDIO_BH was never actually used anyway, and won't do much good now BHs
are gone.

===== include/asm-s390/qdio.h 1.1 vs edited =====
--- 1.1/include/asm-s390/qdio.h	Sat Jun  8 18:01:47 2002
+++ edited/include/asm-s390/qdio.h	Sun Jul 21 20:08:38 2002
@@ -82,8 +82,6 @@
 #define QDIO_CLEANUP_CLEAR_TIMEOUT 20000
 #define QDIO_CLEANUP_HALT_TIMEOUT 10000
 
-#define QDIO_BH AURORA_BH
-
 #define QDIO_IRQ_BUCKETS 256 /* heavy..., but does only use a few bytes, but
 			      be rather faster in cases of collisions
 			      (if there really is a collision, it is
===== include/asm-s390x/qdio.h 1.1 vs edited =====
--- 1.1/include/asm-s390x/qdio.h	Sat Jun  8 18:01:47 2002
+++ edited/include/asm-s390x/qdio.h	Sun Jul 21 20:08:45 2002
@@ -83,8 +83,6 @@
 #define QDIO_CLEANUP_CLEAR_TIMEOUT 20000
 #define QDIO_CLEANUP_HALT_TIMEOUT 10000
 
-#define QDIO_BH AURORA_BH
-
 #define QDIO_IRQ_BUCKETS 256 /* heavy..., but does only use a few bytes, but
 			      be rather faster in cases of collisions
 			      (if there really is a collision, it is

-- 
Revolutions do not require corporate support.
