Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUHGTdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUHGTdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUHGTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:33:15 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:43182 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S264286AbUHGTdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:33:09 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel bug report (includes fix)
Date: Sat, 7 Aug 2004 21:32:58 +0200
User-Agent: KMail/1.6.2
References: <200408071251.i77CpZqE007029@burner.fokus.fraunhofer.de> <yw1xhdrf2i5f.fsf@kth.se>
In-Reply-To: <yw1xhdrf2i5f.fsf@kth.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x5SFBL5rrCPj4gq"
Message-Id: <200408072133.06373.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_x5SFBL5rrCPj4gq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 07 August 2004 15:26, M=E5ns Rullg=E5rd wrote:
> Joerg Schilling <schilling@fokus.fraunhofer.de> writes:
> > You now again have the bug report _and_ the fix in a single short mail.
>
> I could see no patch contained in your mail.

I guess thats what Joerg wants to have.

Cheers,
	Bernd

--Boundary-00=_x5SFBL5rrCPj4gq
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="scsi_head_patch.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scsi_head_patch.out"

diff -ru linux-2.6.8-rc2-mm2.bak/include/scsi/scsi.h linux-2.6.8-rc2-mm2/include/scsi/scsi.h
--- linux-2.6.8-rc2-mm2.bak/include/scsi/scsi.h	2004-06-16 07:20:25.000000000 +0200
+++ linux-2.6.8-rc2-mm2/include/scsi/scsi.h	2004-08-07 20:51:27.000000000 +0200
@@ -214,25 +214,25 @@
  */
 
 struct ccs_modesel_head {
-	u8 _r1;			/* reserved */
-	u8 medium;		/* device-specific medium type */
-	u8 _r2;			/* reserved */
-	u8 block_desc_length;	/* block descriptor length */
-	u8 density;		/* device-specific density code */
-	u8 number_blocks_hi;	/* number of blocks in this block desc */
-	u8 number_blocks_med;
-	u8 number_blocks_lo;
-	u8 _r3;
-	u8 block_length_hi;	/* block length for blocks in this desc */
-	u8 block_length_med;
-	u8 block_length_lo;
+	uint8_t _r1;			/* reserved */
+	uint8_t medium;		/* device-specific medium type */
+	uint8_t _r2;			/* reserved */
+	uint8_t block_desc_length;	/* block descriptor length */
+	uint8_t density;		/* device-specific density code */
+	uint8_t number_blocks_hi;	/* number of blocks in this block desc */
+	uint8_t number_blocks_med;
+	uint8_t number_blocks_lo;
+	uint8_t _r3;
+	uint8_t block_length_hi;	/* block length for blocks in this desc */
+	uint8_t block_length_med;
+	uint8_t block_length_lo;
 };
 
 /*
  * ScsiLun: 8 byte LUN.
  */
 struct scsi_lun {
-	u8 scsi_lun[8];
+	uint8_t scsi_lun[8];
 };
 
 /*
diff -ru linux-2.6.8-rc2-mm2.bak/include/scsi/sg.h linux-2.6.8-rc2-mm2/include/scsi/sg.h
--- linux-2.6.8-rc2-mm2.bak/include/scsi/sg.h	2004-08-03 13:22:50.000000000 +0200
+++ linux-2.6.8-rc2-mm2/include/scsi/sg.h	2004-08-07 20:53:41.000000000 +0200
@@ -89,6 +89,8 @@
 
 /* New interface introduced in the 3.x SG drivers follows */
 
+#include <linux/compiler.h>
+
 typedef struct sg_iovec /* same structure as used by readv() Linux system */
 {                       /* call. It defines one scatter-gather element. */
     void __user *iov_base;      /* Starting address  */

--Boundary-00=_x5SFBL5rrCPj4gq--
