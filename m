Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130043AbRCDGD2>; Sun, 4 Mar 2001 01:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130045AbRCDGDT>; Sun, 4 Mar 2001 01:03:19 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:4177
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130043AbRCDGDF>; Sun, 4 Mar 2001 01:03:05 -0500
Message-Id: <200103040601.AAA01319@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1 line fix to smc-mca in 2.4.2-ac8
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-8869281040"
Date: Sun, 04 Mar 2001 00:01:17 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-8869281040
Content-Type: text/plain; charset=us-ascii

This, along with the previous ac fixes finally get the smc-mca driver working 
for me on my quirky MCA box.

James Bottomley


--==_Exmh_-8869281040
Content-Type: text/plain ; name="smc-mca-2.4.2-ac.diff"; charset=us-ascii
Content-Description: smc-mca-2.4.2-ac.diff
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="smc-mca-2.4.2-ac.diff"

Index: smc-mca.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/jejb/CVSROOT/linux/2.4/drivers/net/smc-mca.c,v
retrieving revision 1.1.1.3.10.1
diff -u -r1.1.1.3.10.1 smc-mca.c
--- smc-mca.c	2001/03/04 02:33:56	1.1.1.3.10.1
+++ smc-mca.c	2001/03/04 03:20:30
@@ -213,7 +213,7 @@
 	dev->mem_start =3D 0;
 	num_pages      =3D 40;
 =

-	switch (j) {	/* 'j' =3D card-# in const array above [hs] */
+	switch (adapter) {	/* card-# in const array above [hs] */
 		case _61c8_SMC_Ethercard_PLUS_Elite_A_BNC_AUI_WD8013EP_A:
 		case _61c9_SMC_Ethercard_PLUS_Elite_A_UTP_AUI_WD8013EP_A:
 		{

--==_Exmh_-8869281040--


