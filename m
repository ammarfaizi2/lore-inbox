Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSFEXXP>; Wed, 5 Jun 2002 19:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSFEXXO>; Wed, 5 Jun 2002 19:23:14 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:19072
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316533AbSFEXXN>; Wed, 5 Jun 2002 19:23:13 -0400
Date: Wed, 5 Jun 2002 16:22:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add <linux/kdev_t.h> to <linux/bio.h>
Message-ID: <20020605232220.GA709@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following add <linux/kdev_t.h> to <linux/bio.h>.

This is needed since bio_ioctl takes a kdev_t for its first argument.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== include/linux/bio.h 1.13 vs edited =====
--- 1.13/include/linux/bio.h	Wed Apr 24 13:00:40 2002
+++ edited/include/linux/bio.h	Wed Jun  5 16:20:06 2002
@@ -20,6 +20,7 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#include <linux/kdev_t.h>
 /* Platforms may set this to teach the BIO layer about IOMMU hardware. */
 #include <asm/io.h>
 #ifndef BIO_VMERGE_BOUNDARY
