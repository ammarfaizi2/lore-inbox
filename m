Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317820AbSGPNhW>; Tue, 16 Jul 2002 09:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317831AbSGPNhV>; Tue, 16 Jul 2002 09:37:21 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:62367 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S317820AbSGPNhV>; Tue, 16 Jul 2002 09:37:21 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 16 Jul 2002 15:25:17 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] miro radio build fix
Message-ID: <20020716152517.A6131@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Trivial patch to fix miro radio build failure.

  Gerd

===== drivers/media/radio/miropcm20-rds-core.c 1.4 vs edited =====
--- 1.4/drivers/media/radio/miropcm20-rds-core.c	Fri Mar  8 13:42:38 2002
+++ edited/drivers/media/radio/miropcm20-rds-core.c	Tue Jul 16 15:14:43 2002
@@ -19,6 +19,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 #include <asm/semaphore.h>
 #include <asm/io.h>
 #include "../../../sound/oss/aci.h"
