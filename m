Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTDJPtl (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTDJPtl (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:49:41 -0400
Received: from gateway.dadaboom.com ([198.144.206.17]:17681 "HELO
	spider.dadaboom.com") by vger.kernel.org with SMTP id S264077AbTDJPtj (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 11:49:39 -0400
From: "William King" <wrking3@dadaboom.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: [PATCH] minor scsi cleanup in 2.4.x
Date: Thu, 10 Apr 2003 09:01:19 -0700
Message-ID: <JAEGLIPFMODKGALKJJGNEEJNCAAA.wrking3@dadaboom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C2FF3F.C05A96A0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C2FF3F.C05A96A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a patch (based off of 2.4.19) which removes 2 unnecessary
externs and adds a new scsi device type string. The externs are unnecessary
since the array is declared extern in scsi.h. The string change is
consistent with the SCSI-3 standard.

To whom it may concern, please apply. :-)

Thanks,
Bill

------=_NextPart_000_0000_01C2FF3F.C05A96A0
Content-Type: text/plain;
	name="scsi_patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="scsi_patch.txt"

--- g_NCR5380.c	2003/04/10 15:43:13	1.1=0A=
+++ g_NCR5380.c	2003/04/10 15:43:27=0A=
@@ -781,7 +781,6 @@=0A=
 	struct NCR5380_hostdata *hostdata;=0A=
 #ifdef NCR5380_STATS=0A=
 	Scsi_Device *dev;=0A=
-	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];=0A=
 #endif=0A=
 	save_flags(flags);=0A=
 	cli();=0A=
--- scsi_proc.c	2003/04/10 15:42:04	1.1=0A=
+++ scsi_proc.c	2003/04/10 15:42:31=0A=
@@ -260,7 +260,6 @@=0A=
 {=0A=
 =0A=
 	int x, y =3D *size;=0A=
-	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];=0A=
 =0A=
 	y =3D sprintf(buffer + len,=0A=
 	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",=0A=
--- scsi.c	2003/04/10 15:29:17	1.1=0A=
+++ scsi.c	2003/04/10 15:31:11=0A=
@@ -140,7 +140,7 @@=0A=
 	"Communications   ",=0A=
 	"Unknown          ",=0A=
 	"Unknown          ",=0A=
-	"Unknown          ",=0A=
+	"Storage Array    ",=0A=
 	"Enclosure        ",=0A=
 };=0A=
 =0A=

------=_NextPart_000_0000_01C2FF3F.C05A96A0--

