Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTB0T22>; Thu, 27 Feb 2003 14:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTB0T22>; Thu, 27 Feb 2003 14:28:28 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30083 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266527AbTB0T2Z>; Thu, 27 Feb 2003 14:28:25 -0500
Message-Id: <200302271938.h1RJceJT010232@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 - more if/ifdef janitor work - include/asm-i386/*
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1349377952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 14:38:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1349377952P
Content-Type: text/plain; charset=us-ascii

Cleaning up include/asm-i386...

--- include/asm-i386/kmap_types.h.dist	2003-02-24 14:05:38.000000000 -0500
+++ include/asm-i386/kmap_types.h	2003-02-27 01:46:11.438439344 -0500
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
--- include/asm-i386/io.h.dist	2003-02-24 14:06:02.000000000 -0500
+++ include/asm-i386/io.h	2003-02-27 01:47:22.532851712 -0500
@@ -49,7 +49,7 @@
  * Temporary debugging check to catch old code using
  * unmapped ISA addresses. Will be removed in 2.4.
  */
-#if CONFIG_DEBUG_IOVIRT
+#ifdef CONFIG_DEBUG_IOVIRT
   extern void *__io_virt_debug(unsigned long x, const char *file, int line);
   #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
 #else
--- include/asm-i386/hardirq.h.dist	2003-02-24 14:05:39.000000000 -0500
+++ include/asm-i386/hardirq.h	2003-02-27 01:48:35.479353476 -0500
@@ -79,7 +79,7 @@
 #define nmi_enter()		(irq_enter())
 #define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#if CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else



--==_Exmh_1349377952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+XmlAcC3lWbTT17ARAmOnAJwIqhHH02IcmSK4phOyQLBfUFcwPQCeIVPS
THZImI1aUbieEEKko53ywxM=
=05K6
-----END PGP SIGNATURE-----

--==_Exmh_1349377952P--
