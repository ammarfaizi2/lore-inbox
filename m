Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbTLQVJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTLQVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:09:39 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:19190 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264558AbTLQVJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:09:37 -0500
Subject: [PATCH] fs/udf/ecma_167.h hex offsets
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1071695350.10723.0.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Dec 2003 14:09:10 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Dec 2003 21:09:35.0484 (UTC) FILETIME=[12E02BC0:01C3C4E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see ecma-167.pdf publishes only the useless decimal offsets, not the
plain hex I see in bus traces, core dumps, disc images, etc.

fs/udf/ecma_167.h as yet has neither kind of offset.  Courtesy `dc -e
'216 212 208 200 168 152 136 132 128 116 104 92 80 72 64 56 52 51 50 48
44 40 36 16 0 16dio f' | less` we could choose to comment.

Pat LaVarre

--- linux-2.6.0-test11/fs/udf/ecma_167.h	2003-11-26 13:43:39.000000000
-0700
+++ linux/fs/udf/ecma_167.h	2003-12-17 14:05:12.217784376 -0700
@@ -791,32 +791,32 @@ struct pathComponent
 /* File Entry (ECMA 167r3 4/14.17) */
 struct extendedFileEntry
 {
-	tag		descTag;
-	icbtag		icbTag;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	permissions;
-	uint16_t	fileLinkCount;
-	uint8_t		recordFormat;
-	uint8_t		recordDisplayAttr;
-	uint32_t	recordLength;
-	uint64_t	informationLength;
-	uint64_t	objectSize;
-	uint64_t	logicalBlocksRecorded;
-	timestamp	accessTime;
-	timestamp	modificationTime;
-	timestamp	createTime;
-	timestamp	attrTime;
-	uint32_t	checkpoint;
-	uint32_t	reserved;
-	long_ad		extendedAttrICB;
-	long_ad		streamDirectoryICB;
-	regid		impIdent;
-	uint64_t	uniqueID;
-	uint32_t	lengthExtendedAttr;
-	uint32_t	lengthAllocDescs;
-	uint8_t		extendedAttr[0];
-	uint8_t		allocDescs[0];
+	tag		descTag;		/* 0 */
+	icbtag		icbTag;			/* 16=x10 */
+	uint32_t	uid;			/* 36=x24 */
+	uint32_t	gid;			/* 40=x28 */
+	uint32_t	permissions;		/* 44=x2C */
+	uint16_t	fileLinkCount;		/* 48=x30 */
+	uint8_t		recordFormat;		/* 50=x32 */
+	uint8_t		recordDisplayAttr;	/* 51=x33 */
+	uint32_t	recordLength;		/* 52=x34 */
+	uint64_t	informationLength;	/* 56=x38 */
+	uint64_t	objectSize;		/* 64=x40 */
+	uint64_t	logicalBlocksRecorded;	/* 72=x48 */
+	timestamp	accessTime;		/* 80=x50 */
+	timestamp	modificationTime;	/* 92=x5C */
+	timestamp	createTime;		/* 104=x68 */
+	timestamp	attrTime;		/* 116=x74 */
+	uint32_t	checkpoint;		/* 128=x80 */
+	uint32_t	reserved;		/* 132=x84 */
+	long_ad		extendedAttrICB;	/* 136=x88 */
+	long_ad		streamDirectoryICB;	/* 152=x98 */
+	regid		impIdent;		/* 168=xA8 */
+	uint64_t	uniqueID;		/* 200=xC8 */
+	uint32_t	lengthExtendedAttr;	/* 208=xD0 */
+	uint32_t	lengthAllocDescs;	/* 212=xD4 */
+	uint8_t		extendedAttr[0];	/* 216=xD8 + L_EA */
+	uint8_t		allocDescs[0];		/* 216=xD8 + L_EA */
 } __attribute__ ((packed));
 
 #endif /* _ECMA_167_H */


