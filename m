Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUD0Mx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUD0Mx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUD0Mx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:53:57 -0400
Received: from FE-mail04.albacom.net ([213.217.149.84]:30866 "EHLO
	FE-mail04.sfg.albacom.net") by vger.kernel.org with ESMTP
	id S264058AbUD0Mxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:53:52 -0400
Message-ID: <001f01c42c56$c09c87f0$0200a8c0@arrakis>
Reply-To: "Marco Cavallini" <linux@koansoftware.com>
From: "Marco Cavallini" <linux@koansoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH]arm/boot/compressed/headxxx errors
Date: Tue, 27 Apr 2004 14:54:16 +0200
Organization: Koan s.a.s.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001C_01C42C67.83091280"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C42C67.83091280
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,
building linux-2.6.6-rc2-bk5 with arm-linux-gcc ver. 2.95.3
default configuration cerfcube_defconfig
there are two little errors solved in the attached patch.
HTH

Regards
Marco Cavallini
==============================================
Koan s.a.s. - Software Engineering  (x86 and ARM)
Linux solutions for Embedded and Real-Time Software
Via Pascoli, 3  - 24121 Bergamo - ITALIA
Tel./Fax (++39) +35 - 255.235 - www.koansoftware.com
==============================================
------=_NextPart_000_001C_01C42C67.83091280
Content-Type: application/octet-stream;
	name="patch-2.6.6-rc2-bk5-mck1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-2.6.6-rc2-bk5-mck1"

diff -urNp linux-2.6.6-rc2-bk5/arch/arm/boot/compressed/head.S =
linux-2.6.6-rc2-bk5-mck1/arch/arm/boot/compressed/head.S=0A=
--- linux-2.6.6-rc2-bk5/arch/arm/boot/compressed/head.S	2004-04-20 =
23:30:01.000000000 +0200=0A=
+++ linux-2.6.6-rc2-bk5-mck1/arch/arm/boot/compressed/head.S	2004-04-27 =
14:35:15.000000000 +0200=0A=
@@ -169,7 +169,7 @@ not_angel:=0A=
 		ldmia	r0, {r1, r2, r3, r4, r5, r6, ip, sp}=0A=
 		subs	r0, r0, r1		@ calculate the delta offset=0A=
 =0A=
-						@ if delta is zero, we're=0A=
+						@ if delta is zero, we are=0A=
 		beq	not_relocated		@ running at the address we=0A=
 						@ were linked at.=0A=
 =0A=
diff -urNp linux-2.6.6-rc2-bk5/arch/arm/boot/compressed/head-sa1100.S =
linux-2.6.6-rc2-bk5-mck1/arch/arm/boot/compressed/head-sa1100.S=0A=
--- linux-2.6.6-rc2-bk5/arch/arm/boot/compressed/head-sa1100.S	=
2004-04-20 23:28:26.000000000 +0200=0A=
+++ linux-2.6.6-rc2-bk5-mck1/arch/arm/boot/compressed/head-sa1100.S	=
2004-04-27 14:35:42.000000000 +0200=0A=
@@ -35,7 +35,7 @@ __SA1100_start:=0A=
 		mov	r7, #MACH_TYPE_PFS168=0A=
 #endif=0A=
 #ifdef CONFIG_SA1100_SIMPAD=0A=
-		@ UNTIL we've something like an open bootldr=0A=
+		@ UNTIL we have something like an open bootldr=0A=
 		mov	r7, #MACH_TYPE_SIMPAD @should be 87=0A=
 #endif=0A=
=0A=

------=_NextPart_000_001C_01C42C67.83091280--

