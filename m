Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUGHNQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUGHNQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGHNQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:16:40 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:29964 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264658AbUGHNPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:15:47 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] warning `comparison is always false due to limited range of data type'
Date: Thu, 8 Jul 2004 15:15:43 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/jU7AeQgpWeR5Y/"
Message-Id: <200407081515.43055.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/jU7AeQgpWeR5Y/
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_/jU7AeQgpWeR5Y/
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="gcc-ad1889.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gcc-ad1889.patch"


=A0 CC [M] =A0sound/oss/ad1889.o
=A0 =A0 =A0 =A0 =A0 sound/oss/ad1889.c: In function `ad1889_ac97_init':
=A0 =A0 =A0 =A0 =A0 sound/oss/ad1889.c:854: warning: comparison is always f=
alse
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 due to =
limited range of data type

=2D-- linux-2.6.7/sound/oss/ad1889.c.orig	2004-06-16 07:19:12.000000000 +02=
00
+++ linux-2.6.7/sound/oss/ad1889.c	2004-07-08 14:36:04.048339480 +0200
@@ -851,7 +851,7 @@
 	}
=20
 	eid =3D ad1889_codec_read(ac97, AC97_EXTENDED_ID);
=2D	if (eid =3D=3D 0xffffff) {
+	if (eid =3D=3D 0xffff) {
 		printk(KERN_WARNING DEVNAME ": no codec attached?\n");
 		goto out_free;
 	}

--Boundary-00=_/jU7AeQgpWeR5Y/--
