Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUBZHrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUBZHrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:47:20 -0500
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:20408 "EHLO
	mail.jg555.com") by vger.kernel.org with ESMTP id S262720AbUBZHrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:47:18 -0500
Message-ID: <05f501c3fc3c$c0993810$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <0da201c3f2d8$78c9e1a0$d300a8c0@W2RZ8L4S02> <20040215131123.GR1308@fs.tum.de>
Subject: Re: [PATCH 2.6] -- Fixes KCONFIG for initrd
Date: Wed, 25 Feb 2004 23:47:14 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_05F2_01C3FBF9.B1F3F6D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_05F2_01C3FBF9.B1F3F6D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Resend of the patch, due to wrap around.
------=_NextPart_000_05F2_01C3FBF9.B1F3F6D0
Content-Type: application/octet-stream;
	name="linux-initrd-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-initrd-1.patch"

Description: Prevents initrd from being built if ram device is built as =
a module. =0A=
=0A=
--- linux/drivers/block/Kconfig.orig	2004-02-14 08:47:03.911807371 +0000=0A=
+++ linux/drivers/block/Kconfig	2004-02-14 08:49:37.739118285 +0000=0A=
@@ -313,6 +313,7 @@=0A=
 =0A=
 config BLK_DEV_INITRD=0A=
 	bool "Initial RAM disk (initrd) support"=0A=
+	depends on BLK_DEV_RAM && BLK_DEV_RAM!=3Dm=0A=
 	help=0A=
 	  The initial RAM disk is a RAM disk that is loaded by the boot loader=0A=
 	  (loadlin or lilo) and that is mounted as root before the normal boot=0A=

------=_NextPart_000_05F2_01C3FBF9.B1F3F6D0--

