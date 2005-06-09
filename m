Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVFIXtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVFIXtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFIXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:48:06 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:38946 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262497AbVFIXrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:47:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] [2.4.31] Increase MAX_MP_BUSSES for i386 kernel
Date: Thu, 9 Jun 2005 16:47:36 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D15AE@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.4.31] Increase MAX_MP_BUSSES for i386 kernel
thread-index: AcVtTZ1Bu0De0jB3SPWYyl8hCKxLoA==
From: "Andy Currid" <ACurrid@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jun 2005 23:47:37.0199 (UTC) FILETIME=[9D7C0FF0:01C56D4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Increase the size of MAX_MP_BUSSES to allow 2.4 i386 SMP kernel to boot
on machines that have PCI bus numbers above 31.

Signed-off-by: Andy Currid <acurrid@nvidia.com>

---

diff -pur linux-2.4.31/include/asm-i386/mpspec.h
patch-2.4.31/include/asm-i386
--- linux-2.4.31/include/asm-i386/mpspec.h	2004-11-17
03:54:22.000000000 -0800
+++ patch-2.4.31/include/asm-i386/mpspec.h	2005-06-09
18:08:52.385352384 -0700
@@ -191,7 +191,7 @@ struct mpc_config_translation
 #define MAX_IRQ_SOURCES 256
 #endif /* CONFIG_MULTIQUAD */
 
-#define MAX_MP_BUSSES 32
+#define MAX_MP_BUSSES 256
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,

