Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbTCMT6F>; Thu, 13 Mar 2003 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbTCMT6F>; Thu, 13 Mar 2003 14:58:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9632 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262513AbTCMT6E>; Thu, 13 Mar 2003 14:58:04 -0500
Date: Thu, 13 Mar 2003 17:08:04 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow to compile IDE as module
Message-ID: <20030313200804.GE23024@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marcelo, the following patch fixes drivers/ide/Makefile
to allow to use CONFIG_BLK_DEV_IDE=3Dm.

--=20
Eduardo


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1014  -> 1.1015=20
#	drivers/ide/Makefile	1.10    -> 1.11  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	ehabkost@duckman.distro.conectiva	1.1015
# Makefile:
#   Fix ide Makefile to allow CONFIG_BLK_DEV_IDE as module
# --------------------------------------------
#
diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Thu Mar 13 17:01:12 2003
+++ b/drivers/ide/Makefile	Thu Mar 13 17:01:12 2003
@@ -35,9 +35,13 @@
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+=3D ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+=3D ide-floppy.o
=20
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+=3D setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+=3D ide-dma.o
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+=3D ide-pnp.o
+# These options are boolean, but the files must be
+# on obj-m if CONFIG_BLK_DEV is m:
+ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+=3D setup-pci.o
+ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+=3D ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+=3D ide-pnp.o
+
+obj-$(CONFIG_BLK_DEV)			+=3D ide-obj-y
=20
=20
 ifeq ($(CONFIG_BLK_DEV_IDE),y)

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+cOUkcaRJ66w1lWgRAsLLAJ9DxhnbeS2dT4Jna0kN0kC+K7xqowCffxfd
yFQ28lac2Fd04zLKgY+CgLI=
=odsI
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
