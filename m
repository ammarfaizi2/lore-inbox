Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbTBDQ6d>; Tue, 4 Feb 2003 11:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTBDQ6d>; Tue, 4 Feb 2003 11:58:33 -0500
Received: from relay-3v.club-internet.fr ([194.158.96.114]:49879 "HELO
	relay-3v.club-internet.fr") by vger.kernel.org with SMTP
	id <S266682AbTBDQ6c>; Tue, 4 Feb 2003 11:58:32 -0500
Date: Tue, 4 Feb 2003 18:07:47 +0100
From: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: MegaRaid-Devel <linux-megaraid-devel@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Megaraid compile problem for 2.5.59-mm8 ( latest BK as well)
Message-Id: <20030204180747.51e5c0c2.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.9claws37 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__4_Feb_2003_18:07:47_+0100_08737e58"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__4_Feb_2003_18:07:47_+0100_08737e58
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


 Hi,

After i upgraded from 2.5.59-mm7 to 2.5.59-mm8, i couldn't compile the mega=
raid module
anymore.

This patch fixes the problem.

I should apply to the latest BK as well.

Thanks,

Philippe

--

Philippe Gramoull=E9
philippe.gramoulle@mmania.com
Lycos Europe - NOC France


--Multipart_Tue__4_Feb_2003_18:07:47_+0100_08737e58
Content-Type: text/plain;
 name="megaraid.c.diff"
Content-Disposition: attachment;
 filename="megaraid.c.diff"
Content-Transfer-Encoding: 7bit

--- drivers/scsi/megaraid.c.orig	2003-02-04 18:01:13.000000000 +0100
+++ drivers/scsi/megaraid.c	2003-02-04 18:02:02.000000000 +0100
@@ -4515,7 +4515,7 @@
 		if(scsicmd == NULL) return -ENOMEM;
 
 		memset(scsicmd, 0, sizeof(Scsi_Cmnd));
-		scsicmd->host = shpnt;
+		scsicmd->device->host = shpnt;
 
 		if( outlen || inlen ) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
@@ -4652,7 +4652,7 @@
 		if(scsicmd == NULL) return -ENOMEM;
 
 		memset(scsicmd, 0, sizeof(Scsi_Cmnd));
-		scsicmd->host = shpnt;
+		scsicmd->device->host = shpnt;
 
 		if (outlen || inlen) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)

--Multipart_Tue__4_Feb_2003_18:07:47_+0100_08737e58--
