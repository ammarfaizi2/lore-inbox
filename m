Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUCHG4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCHG4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:56:39 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:52887 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262400AbUCHG4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:56:36 -0500
Date: Mon, 8 Mar 2004 17:56:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] small iSeries cleanup
Message-Id: <20040308175632.4585baca.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__8_Mar_2004_17_56_32_+1100_0ZXBEggg=d9RWC6y"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__8_Mar_2004_17_56_32_+1100_0ZXBEggg=d9RWC6y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus, Andrew,

This got missed in my cleanup if iSeries_vio_dev.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.4-rc2-bk3/drivers/block/viodasd.c 2.6.4-rc2-bk3.mf1/drivers/block/viodasd.c
--- 2.6.4-rc2-bk3/drivers/block/viodasd.c	2004-03-04 18:24:49.000000000 +1100
+++ 2.6.4-rc2-bk3.mf1/drivers/block/viodasd.c	2004-03-08 17:47:43.000000000 +1100
@@ -38,7 +38,6 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 
@@ -77,8 +76,6 @@
 
 #define DEVICE_NO(cell)	((struct viodasd_device *)(cell) - &viodasd_devices[0])
 
-extern struct device *iSeries_vio_dev;
-
 struct open_data {
 	u64	disk_size;
 	u16	max_disk;

--Signature=_Mon__8_Mar_2004_17_56_32_+1100_0ZXBEggg=d9RWC6y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATBkgFG47PeJeR58RAn/JAKDF1vqO8e6Es+idRWrE0FrMhthgewCfVmUU
zOUtA3MU2+1cETifb975QRk=
=gVwg
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Mar_2004_17_56_32_+1100_0ZXBEggg=d9RWC6y--
