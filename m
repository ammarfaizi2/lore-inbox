Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHCMVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHCMVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUHCMV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:21:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47316 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265974AbUHCMV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:21:26 -0400
Date: Tue, 3 Aug 2004 14:21:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: yokota@netlab.is.tsukuba.ac.jp, gotom@debian.or.jp
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI nsp32.c: missing parts of inline removal patch
Message-ID: <20040803122120.GZ2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The SCSI tree as included in 2.6.8-rc2-mm2 only removes the inline's 
from the functions prototypes, but the part of my original patch that 
also removes the inline's from the functions was lost.

Please additionally apply the patch below.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/nsp32.c.old	2004-07-16 00:34:49.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/nsp32.c	2004-07-16 00:37:26.000000000 +0200
@@ -3387,7 +3387,7 @@
 	return val;
 }
 
-static inline void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
+static void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
 {
 	int base = data->BaseAddress;
 	int tmp;
@@ -3405,7 +3405,7 @@
 	udelay(10);
 }
 
-static inline int nsp32_prom_get(nsp32_hw_data *data, int bit)
+static int nsp32_prom_get(nsp32_hw_data *data, int bit)
 {
 	int base = data->BaseAddress;
 	int tmp, ret;

