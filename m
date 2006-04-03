Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWDCRVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWDCRVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWDCRVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:21:41 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40220 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932363AbWDCRVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:21:40 -0400
Date: Mon, 3 Apr 2006 19:21:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 2/9] s390: ebdic to ascii conversion tables.
Message-ID: <20060403172138.GB11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 2/9] s390: ebdic to ascii conversion tables.

Make the length of ebcdic<->ascii conversion arrays known. This
avoid warnings with source code checking tools.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/ebcdic.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/include/asm-s390/ebcdic.h linux-2.6-patched/include/asm-s390/ebcdic.h
--- linux-2.6/include/asm-s390/ebcdic.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/ebcdic.h	2006-04-03 18:46:35.000000000 +0200
@@ -14,12 +14,12 @@
 #include <types.h>
 #endif
 
-extern __u8 _ascebc_500[];   /* ASCII -> EBCDIC 500 conversion table */
-extern __u8 _ebcasc_500[];   /* EBCDIC 500 -> ASCII conversion table */
-extern __u8 _ascebc[];   /* ASCII -> EBCDIC conversion table */
-extern __u8 _ebcasc[];   /* EBCDIC -> ASCII conversion table */
-extern __u8 _ebc_tolower[]; /* EBCDIC -> lowercase */
-extern __u8 _ebc_toupper[]; /* EBCDIC -> uppercase */
+extern __u8 _ascebc_500[256];   /* ASCII -> EBCDIC 500 conversion table */
+extern __u8 _ebcasc_500[256];   /* EBCDIC 500 -> ASCII conversion table */
+extern __u8 _ascebc[256];   /* ASCII -> EBCDIC conversion table */
+extern __u8 _ebcasc[256];   /* EBCDIC -> ASCII conversion table */
+extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
+extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
 
 static inline void
 codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
