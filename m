Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUBOTYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUBOTYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:24:45 -0500
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:14727 "EHLO
	mail.jg555.com") by vger.kernel.org with ESMTP id S265171AbUBOTYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:24:43 -0500
Message-ID: <00c101c3f3f9$49e77e20$db00a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <0da201c3f2d8$78c9e1a0$d300a8c0@W2RZ8L4S02> <20040215131123.GR1308@fs.tum.de>
Subject: Re: [PATCH 2.6] -- Fixes KCONFIG for initrd
Date: Sun, 15 Feb 2004 11:24:10 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00BE_01C3F3B6.3B4D1250"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00BE_01C3F3B6.3B4D1250
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I resent the patch to rusty's trival area.

------=_NextPart_000_00BE_01C3F3B6.3B4D1250
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

------=_NextPart_000_00BE_01C3F3B6.3B4D1250--

