Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbUDGX5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUDGX4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:56:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49638 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261298AbUDGXyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:54:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] obsolete asm/hdreg.h [2/5]
Date: Thu, 8 Apr 2004 00:22:30 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404080022.30618.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] add asm-generic/hdreg.h

Use it on all archs which define ide_ioreg_t to unsigned long.

 linux-2.6.5-root/include/asm-alpha/hdreg.h   |   13 +------------
 linux-2.6.5-root/include/asm-arm/hdreg.h     |   14 +-------------
 linux-2.6.5-root/include/asm-arm26/hdreg.h   |   16 +---------------
 linux-2.6.5-root/include/asm-generic/hdreg.h |    6 ++++++
 linux-2.6.5-root/include/asm-mips/hdreg.h    |   17 +----------------
 linux-2.6.5-root/include/asm-parisc/hdreg.h  |    7 +------
 linux-2.6.5-root/include/asm-ppc/hdreg.h     |   18 +-----------------
 linux-2.6.5-root/include/asm-ppc64/hdreg.h   |   23 +----------------------
 linux-2.6.5-root/include/asm-sh/hdreg.h      |   13 +------------
 linux-2.6.5-root/include/asm-sparc/hdreg.h   |   14 +-------------
 linux-2.6.5-root/include/asm-sparc64/hdreg.h |   14 +-------------
 11 files changed, 16 insertions(+), 139 deletions(-)

diff -puN include/asm-alpha/hdreg.h~generic_asm_hdreg include/asm-alpha/hdreg.h
--- linux-2.6.5/include/asm-alpha/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.870153960 +0200
+++ linux-2.6.5-root/include/asm-alpha/hdreg.h	2004-04-07 23:56:05.925145600 +0200
@@ -1,12 +1 @@
-/*
- *  linux/include/asm-alpha/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMalpha_HDREG_H
-#define __ASMalpha_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMalpha_HDREG_H */
+#include <asm-generic/hdreg.h>
diff -puN include/asm-arm26/hdreg.h~generic_asm_hdreg include/asm-arm26/hdreg.h
--- linux-2.6.5/include/asm-arm26/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.881152288 +0200
+++ linux-2.6.5-root/include/asm-arm26/hdreg.h	2004-04-07 23:56:05.925145600 +0200
@@ -1,15 +1 @@
-/*
- *  linux/include/asm-arm26/hdreg.h
- *
- *  Used by include/linux/ide.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMARM_HDREG_H
-#define __ASMARM_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMARM_HDREG_H */
-
+#include <asm-generic/hdreg.h>
diff -puN include/asm-arm/hdreg.h~generic_asm_hdreg include/asm-arm/hdreg.h
--- linux-2.6.5/include/asm-arm/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.884151832 +0200
+++ linux-2.6.5-root/include/asm-arm/hdreg.h	2004-04-07 23:56:05.926145448 +0200
@@ -1,13 +1 @@
-/*
- *  linux/include/asm-arm/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASMARM_HDREG_H
-#define __ASMARM_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMARM_HDREG_H */
-
+#include <asm-generic/hdreg.h>
diff -puN /dev/null include/asm-generic/hdreg.h
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.5-root/include/asm-generic/hdreg.h	2004-04-07 23:56:05.926145448 +0200
@@ -0,0 +1,6 @@
+#ifndef __ASM_GENERIC_HDREG_H
+#define __ASM_GENERIC_HDREG_H
+
+typedef unsigned long ide_ioreg_t;
+
+#endif /* __ASM_GENERIC_HDREG_H */
diff -puN include/asm-mips/hdreg.h~generic_asm_hdreg include/asm-mips/hdreg.h
--- linux-2.6.5/include/asm-mips/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.889151072 +0200
+++ linux-2.6.5-root/include/asm-mips/hdreg.h	2004-04-07 23:56:05.927145296 +0200
@@ -1,16 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- *  This file contains the MIPS architecture specific IDE code.
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- *  Copyright (C) 2001 Ralf Baechle
- */
-#ifndef _ASM_HDREG_H
-#define _ASM_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* _ASM_HDREG_H */
+#include <asm-generic/hdreg.h>
diff -puN include/asm-parisc/hdreg.h~generic_asm_hdreg include/asm-parisc/hdreg.h
--- linux-2.6.5/include/asm-parisc/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.892150616 +0200
+++ linux-2.6.5-root/include/asm-parisc/hdreg.h	2004-04-07 23:56:05.928145144 +0200
@@ -1,6 +1 @@
-#ifndef _ASM_HDREG_H
-#define _ASM_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif
+#include <asm-generic/hdreg.h>
diff -puN include/asm-ppc64/hdreg.h~generic_asm_hdreg include/asm-ppc64/hdreg.h
--- linux-2.6.5/include/asm-ppc64/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.903148944 +0200
+++ linux-2.6.5-root/include/asm-ppc64/hdreg.h	2004-04-07 23:56:05.928145144 +0200
@@ -1,22 +1 @@
-/*
- *  linux/include/asm-ppc/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/*
- *  This file contains the ppc architecture specific IDE code.
- */
-
-#ifndef __ASMPPC64_HDREG_H
-#define __ASMPPC64_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMPPC64_HDREG_H */
-
+#include <asm-generic/hdreg.h>
diff -puN include/asm-ppc/hdreg.h~generic_asm_hdreg include/asm-ppc/hdreg.h
--- linux-2.6.5/include/asm-ppc/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.909148032 +0200
+++ linux-2.6.5-root/include/asm-ppc/hdreg.h	2004-04-07 23:56:05.929144992 +0200
@@ -1,17 +1 @@
-/*
- *  include/asm-ppc/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-/*
- *  This file contains the ppc architecture specific IDE code.
- */
-
-#ifndef __ASMPPC_HDREG_H
-#define __ASMPPC_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASMPPC_HDREG_H */
-
+#include <asm-generic/hdreg.h>
diff -puN include/asm-sh/hdreg.h~generic_asm_hdreg include/asm-sh/hdreg.h
--- linux-2.6.5/include/asm-sh/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.913147424 +0200
+++ linux-2.6.5-root/include/asm-sh/hdreg.h	2004-04-07 23:56:05.930144840 +0200
@@ -1,12 +1 @@
-/*
- *  linux/include/asm-sh/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#ifndef __ASM_SH_HDREG_H
-#define __ASM_SH_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASM_SH_HDREG_H */
+#include <asm-generic/hdreg.h>
diff -puN include/asm-sparc64/hdreg.h~generic_asm_hdreg include/asm-sparc64/hdreg.h
--- linux-2.6.5/include/asm-sparc64/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.917146816 +0200
+++ linux-2.6.5-root/include/asm-sparc64/hdreg.h	2004-04-07 23:56:05.930144840 +0200
@@ -1,13 +1 @@
-/* $Id: hdreg.h,v 1.1 1999/05/14 07:23:13 davem Exp $
- * hdreg.h: Ultra/PCI specific IDE glue.
- *
- * Copyright (C) 1997  David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1998  Eddie C. Dost   (ecd@skynet.be)
- */
-
-#ifndef __SPARC64_HDREG_H
-#define __SPARC64_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __SPARC64_HDREG_H */
+#include <asm-generic/hdreg.h>
diff -puN include/asm-sparc/hdreg.h~generic_asm_hdreg include/asm-sparc/hdreg.h
--- linux-2.6.5/include/asm-sparc/hdreg.h~generic_asm_hdreg	2004-04-07 23:56:05.921146208 +0200
+++ linux-2.6.5-root/include/asm-sparc/hdreg.h	2004-04-07 23:56:05.931144688 +0200
@@ -1,13 +1 @@
-/* $Id: hdreg.h,v 1.2 2000/12/05 00:56:36 anton Exp $
- * hdreg.h: SPARC PCI specific IDE glue.
- *
- * Copyright (C) 1997  David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1998  Eddie C. Dost   (ecd@skynet.be)
- */
-
-#ifndef __SPARC_HDREG_H
-#define __SPARC_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __SPARC_HDREG_H */
+#include <asm-generic/hdreg.h>

_

