Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVEQWRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVEQWRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVEQWQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:16:32 -0400
Received: from [85.8.12.41] ([85.8.12.41]:12714 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262028AbVEQWOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:14:54 -0400
Message-ID: <428A6CDB.7060600@drzeus.cx>
Date: Wed, 18 May 2005 00:14:51 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-5846-1116368093-0001-2"
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 1/2] Proper MMC command classes support
References: <428A6C3A.40505@drzeus.cx>
In-Reply-To: <428A6C3A.40505@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-5846-1116368093-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Defines for the different command classes as defined in the MMC and SD
specifications.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>


--=_hermes.drzeus.cx-5846-1116368093-0001-2
Content-Type: text/x-patch; name="mmc-ccc.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-ccc.patch"

Index: linux-wbsd/include/linux/mmc/protocol.h
===================================================================
--- linux-wbsd/include/linux/mmc/protocol.h	(revision 134)
+++ linux-wbsd/include/linux/mmc/protocol.h	(working copy)
@@ -209,6 +209,33 @@
 #define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
 #define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
 
+/*
+ * Card Command Classes (CCC)
+ */
+#define CCC_BASIC		(1<<0)	/* (0) Basic protocol functions */
+					/* (CMD0,1,2,3,4,7,9,10,12,13,15) */
+#define CCC_STREAM_READ		(1<<1)	/* (1) Stream read commands */
+					/* (CMD11) */
+#define CCC_BLOCK_READ		(1<<2)	/* (2) Block read commands */
+					/* (CMD16,17,18) */
+#define CCC_STREAM_WRITE	(1<<3)	/* (3) Stream write commands */
+					/* (CMD20) */
+#define CCC_BLOCK_WRITE		(1<<4)	/* (4) Block write commands */
+					/* (CMD16,24,25,26,27) */
+#define CCC_ERASE		(1<<5)	/* (5) Ability to erase blocks */
+					/* (CMD32,33,34,35,36,37,38,39) */
+#define CCC_WRITE_PROT		(1<<6)	/* (6) Able to write protect blocks */
+					/* (CMD28,29,30) */
+#define CCC_LOCK_CARD		(1<<7)	/* (7) Able to lock down card */
+					/* (CMD16,CMD42) */
+#define CCC_APP_SPEC		(1<<8)	/* (8) Application specific */
+					/* (CMD55,56,57,ACMD*) */
+#define CCC_IO_MODE		(1<<9)	/* (9) I/O mode */
+					/* (CMD5,39,40,52,53) */
+#define CCC_SWITCH		(1<<10)	/* (10) High speed switch */
+					/* (CMD6,34,35,36,37,50) */
+					/* (11) Reserved */
+					/* (CMD?) */
 
 /*
  * SD bus widths

--=_hermes.drzeus.cx-5846-1116368093-0001-2--
