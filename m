Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSFIXjK>; Sun, 9 Jun 2002 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSFIXjJ>; Sun, 9 Jun 2002 19:39:09 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:45327 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315337AbSFIXjI>; Sun, 9 Jun 2002 19:39:08 -0400
Message-ID: <3D03E68E.8010704@megapathdsl.net>
Date: Sun, 09 Jun 2002 16:36:46 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: PATCH -- Re: 2.5.21 -- emumpu401.c:309: parse error before "emu10k1_midi_init"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds linux/init.h in all the necessary places to
get the emu10k1 driver building again.

	Miles

--- linux/sound/pci/emu10k1/emumpu401.c~        Sun Jun  9 04:30:46 2002
+++ linux/sound/pci/emu10k1/emumpu401.c Sun Jun  9 04:31:51 2002
@@ -22,6 +22,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

diff -u -r ../tmp2/emufx.c sound/pci/emu10k1/emufx.c
--- ../tmp2/emufx.c	Thu May 30 23:12:54 2002
+++ sound/pci/emu10k1/emufx.c	Sun Jun  9 16:25:12 2002
@@ -28,6 +28,7 @@
  #define __NO_VERSION__
  #include <sound/driver.h>
  #include <linux/delay.h>
+#include <linux/init.h>
  #include <linux/slab.h>
  #include <sound/core.h>
  #include <sound/emu10k1.h>
diff -u -r ../tmp2/emumixer.c sound/pci/emu10k1/emumixer.c
--- ../tmp2/emumixer.c	Thu May 30 23:19:29 2002
+++ sound/pci/emu10k1/emumixer.c	Sun Jun  9 16:24:29 2002
@@ -29,6 +29,7 @@
  #define __NO_VERSION__
  #include <sound/driver.h>
  #include <linux/time.h>
+#include <linux/init.h>
  #include <sound/core.h>
  #include <sound/emu10k1.h>

diff -u -r ../tmp2/emupcm.c sound/pci/emu10k1/emupcm.c
--- ../tmp2/emupcm.c	Thu May 30 23:13:53 2002
+++ sound/pci/emu10k1/emupcm.c	Sun Jun  9 16:10:40 2002
@@ -29,6 +29,7 @@
  #include <sound/driver.h>
  #include <linux/slab.h>
  #include <linux/time.h>
+#include <linux/init.h>
  #include <sound/core.h>
  #include <sound/emu10k1.h>

diff -u -r ../tmp2/emuproc.c sound/pci/emu10k1/emuproc.c
--- ../tmp2/emuproc.c	Thu May 30 23:13:53 2002
+++ sound/pci/emu10k1/emuproc.c	Sun Jun  9 16:23:41 2002
@@ -28,6 +28,7 @@
  #define __NO_VERSION__
  #include <sound/driver.h>
  #include <linux/slab.h>
+#include <linux/init.h>
  #include <sound/core.h>
  #include <sound/emu10k1.h>


