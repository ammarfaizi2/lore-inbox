Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVDLUSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVDLUSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVDLURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:17:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:24776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262137AbVDLKba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:30 -0400
Message-Id: <200504121031.j3CAVLHn005296@shell0.pdx.osdl.net>
Subject: [patch 043/198] ppc32: fix compilation error in arch/ppc/syslib/open_pic_defs.h
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benoit.boissinot@ens-lyon.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

make defconfig give the following error on ppc (gcc-4):

arch/ppc/syslib/open_pic.c:36: error: static declaration of ‘OpenPIC’ follows non-static declaration
arch/ppc/syslib/open_pic_defs.h:175: error: previous declaration of ‘OpenPIC’ was here

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/syslib/open_pic_defs.h |    3 ---
 1 files changed, 3 deletions(-)

diff -puN arch/ppc/syslib/open_pic_defs.h~ppc32-fix-compilation-error-in-arch-ppc-syslib-open_pic_defsh arch/ppc/syslib/open_pic_defs.h
--- 25/arch/ppc/syslib/open_pic_defs.h~ppc32-fix-compilation-error-in-arch-ppc-syslib-open_pic_defsh	2005-04-12 03:21:13.553076520 -0700
+++ 25-akpm/arch/ppc/syslib/open_pic_defs.h	2005-04-12 03:21:13.556076064 -0700
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC __iomem *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
_
