Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWF0QTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWF0QTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWF0QTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:19:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:24071 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161153AbWF0QTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:19:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pyXliFO+PKhU3Yx2i6eKTnyTncKJ4Wx0UfDzyVucQDe8PEPSq1pZ0czDCyNzwFgs+nZeSML63oBlmEU7aKyHMWVy5sT8ebDHOnjuycYa2iynCXeUoduAXZplJhgKiEynk+L0Ez0D4NO4dwmWwEjV3g+ggS5hpAxTPY5b7cpKC1Q=
Message-ID: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
Date: Tue, 27 Jun 2006 12:19:07 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH, trivial] Remove about 50 unneeded #includes in fbdev
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove about 50 unneeded #includes in fbdev

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index db878fd..e498a54 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -46,26 +46,14 @@
  */


-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <asm/uaccess.h>
  #include <linux/fb.h>
-#include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/ioport.h>
 #include <linux/console.h>
-#include <linux/backlight.h>
-#include <asm/io.h>

  #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index c5185f7..5f4c76c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -49,26 +49,13 @@
 ******************************************************************************/


-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/console.h>
  #include <linux/fb.h>
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
 #include <linux/backlight.h>

-#include <asm/io.h>
 #include <asm/uaccess.h>

 #include <video/mach64.h>
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index c5ecbb0..56445ea 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -52,25 +52,6 @@

 #define RADEON_VERSION	"0.2.0"

-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/time.h>
-#include <linux/fb.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/vmalloc.h>
-#include <linux/device.h>
-
-#include <asm/io.h>
 #include <asm/uaccess.h>

  #ifdef CONFIG_PPC_OF
diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
index a9d0414..4855c0a 100644
--- a/drivers/video/aty/radeon_i2c.c
+++ b/drivers/video/aty/radeon_i2c.c
@@ -1,9 +1,3 @@
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/pci.h>
  #include <linux/fb.h>
