Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270336AbRHIRZo>; Thu, 9 Aug 2001 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270349AbRHIRZe>; Thu, 9 Aug 2001 13:25:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29188 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S270336AbRHIRZV>;
	Thu, 9 Aug 2001 13:25:21 -0400
Date: Thu, 9 Aug 2001 19:25:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Anton Altaparmakov <antona@users.sourceforge.net>
Subject: [PATCH] ./fs/partitions/ldm.h
Message-ID: <20010809192531.D25724@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Anton Altaparmakov <antona@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patch is a compile fix for missing braces around
#define parameters...

MfG, JBG

--- linux/fs/partitions/ldm.h.orig	Thu Aug  9 19:20:33 2001
+++ linux/fs/partitions/ldm.h	Thu Aug  9 19:19:17 2001
@@ -81,7 +81,7 @@
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&p->sys_ind))
+#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
 #define NR_SECTS(p)		({ __typeof__(p->nr_sects) __a =	\
 					get_unaligned(&p->nr_sects);	\
 					le32_to_cpu(__a);		\
