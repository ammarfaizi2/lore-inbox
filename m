Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263381AbRFAFs3>; Fri, 1 Jun 2001 01:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbRFAFsS>; Fri, 1 Jun 2001 01:48:18 -0400
Received: from WARSL401PIP1.highway.telekom.at ([195.3.96.69]:2139 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S263381AbRFAFsM>;
	Fri, 1 Jun 2001 01:48:12 -0400
From: "Michael Guntsche" <m.guntsche@epitel.at>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] CSLIP compiled as module in 2.4.[345]
Date: Fri, 1 Jun 2001 07:31:50 +0200
Message-ID: <NDBBJOKGIPCDBEEFHNFPOEKNCAAA.m.guntsche@epitel.at>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C0EA6C.EBDDE7D0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C0EA6C.EBDDE7D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello List,

The attached patch should fix the missing symbols in SLIP with CSLIP
support, if compiled as module. It applies cleanly against 2.4.3 but should
work with 2.4.5 too.


Regards,
Michael Guntsche


------=_NextPart_000_0000_01C0EA6C.EBDDE7D0
Content-Type: application/octet-stream;
	name="slip.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="slip.patch"

--- linux-2.4.3/drivers/net/Makefile.orig	Thu May 31 19:15:42 2001=0A=
+++ linux-2.4.3/drivers/net/Makefile	Thu May 31 19:18:11 2001=0A=
@@ -133,12 +133,8 @@=0A=
 obj-$(CONFIG_PPPOE) +=3D pppox.o pppoe.o=0A=
 =0A=
 obj-$(CONFIG_SLIP) +=3D slip.o=0A=
-ifeq ($(CONFIG_SLIP),y)=0A=
-  obj-$(CONFIG_SLIP_COMPRESSED) +=3D slhc.o=0A=
-else=0A=
-  ifeq ($(CONFIG_SLIP),m)=0A=
-    obj-$(CONFIG_SLIP_COMPRESSED) +=3D slhc.o=0A=
-  endif=0A=
+ifeq ($(CONFIG_SLIP_COMPRESSED),y)=0A=
+  obj-$(CONFIG_SLIP) +=3D slhc.o=0A=
 endif=0A=
 =0A=
 obj-$(CONFIG_STRIP) +=3D strip.o=0A=

------=_NextPart_000_0000_01C0EA6C.EBDDE7D0--

