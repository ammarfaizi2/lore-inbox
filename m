Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316481AbSEUBTl>; Mon, 20 May 2002 21:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316484AbSEUBTk>; Mon, 20 May 2002 21:19:40 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:37882 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316481AbSEUBTj>; Mon, 20 May 2002 21:19:39 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.41128.652928.573561@wombat.chubb.wattle.id.au>
Date: Tue, 21 May 2002 11:19:36 +1000
To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Allow aic7xx firmware to be built from BK tree.
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the two generate files (that are also in the
distributed kernel) before attempting to regenerate them.

The real question is, why are there generated files distributed with
the kernel source?

(Patch against 2.5.16)


===== drivers/scsi/aic7xxx/Makefile 1.8 vs edited =====
--- 1.8/drivers/scsi/aic7xxx/Makefile   Thu Apr 25 05:16:44 2002
+++ edited/drivers/scsi/aic7xxx/Makefile        Tue May 14 10:04:50 2002
@@ -26,6 +26,7 @@
 
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
 aic7xxx_seq.h aic7xxx_reg.h: aic7xxx.seq aic7xxx.reg aicasm/aicasm
+       -rm -f aic7xx_seq.h aic7xx_reg.h
        aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
 endif
 
