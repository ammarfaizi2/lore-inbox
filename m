Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSBNQkY>; Thu, 14 Feb 2002 11:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBNQkR>; Thu, 14 Feb 2002 11:40:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:30736 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291776AbSBNQkK>; Thu, 14 Feb 2002 11:40:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Feb 2002 16:21:18 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] miro radio fix
Message-ID: <20020214162118.C8112@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

The miro radio driver doesn't build any more due to the sound drivers
being moved.  This patch fixes it.

  Gerd

------------------------------- cut here ---------------------------
--- linux-2.5.5-pre1/drivers/media/radio/miropcm20-rds-core.c	Thu Feb 14 14:19:24 2002
+++ linux/drivers/media/radio/miropcm20-rds-core.c	Thu Feb 14 14:20:45 2002
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <asm/semaphore.h>
 #include <asm/io.h>
-#include "../../sound/aci.h"
+#include "../../../sound/oss/aci.h"
 #include "miropcm20-rds-core.h"
 
 #define DEBUG 0
--- linux-2.5.5-pre1/drivers/media/radio/miropcm20-radio.c	Thu Feb 14 14:21:12 2002
+++ linux/drivers/media/radio/miropcm20-radio.c	Thu Feb 14 14:21:44 2002
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/videodev.h>
-#include "../../sound/aci.h"
+#include "../../../sound/oss/aci.h"
 #include "miropcm20-rds-core.h"
 
 static int users = 0;
