Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263745AbTCUTRr>; Fri, 21 Mar 2003 14:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTCUTRE>; Fri, 21 Mar 2003 14:17:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44164
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262726AbTCUTP7>; Fri, 21 Mar 2003 14:15:59 -0500
Date: Fri, 21 Mar 2003 20:31:15 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212031.h2LKVF3s026371@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: PC9800 system common area definition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/pc9800_sca.h linux-2.5.65-ac2/include/asm-i386/pc9800_sca.h
--- linux-2.5.65/include/asm-i386/pc9800_sca.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/include/asm-i386/pc9800_sca.h	2003-02-14 23:29:24.000000000 +0000
@@ -0,0 +1,25 @@
+/*
+ *  System-common area definitions for NEC PC-9800 series
+ *
+ *  Copyright (C) 1999	TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>,
+ *			Kyoto University Microcomputer Club.
+ */
+
+#ifndef _ASM_I386_PC9800SCA_H_
+#define _ASM_I386_PC9800SCA_H_
+
+#define PC9800SCA_EXPMMSZ		(0x0401)	/* B */
+#define PC9800SCA_SCSI_PARAMS		(0x0460)	/* 8 * 4B */
+#define PC9800SCA_DISK_EQUIPS		(0x0482)	/* B */
+#define PC9800SCA_XROM_ID		(0x04C0)	/* 52B */
+#define PC9800SCA_BIOS_FLAG		(0x0501)	/* B */
+#define PC9800SCA_MMSZ16M		(0x0594)	/* W */
+
+/* PC-9821 have additional system common area in their BIOS-ROM segment. */
+
+#define PC9821SCA__BASE			(0xF8E8 << 4)
+#define PC9821SCA_ROM_ID		(PC9821SCA__BASE + 0x00)
+#define PC9821SCA_ROM_FLAG4		(PC9821SCA__BASE + 0x05)
+#define PC9821SCA_RSFLAGS		(PC9821SCA__BASE + 0x11)	/* B */
+
+#endif /* !_ASM_I386_PC9800SCA_H_ */
