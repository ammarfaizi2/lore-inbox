Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129670AbQKMNsD>; Mon, 13 Nov 2000 08:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129705AbQKMNrx>; Mon, 13 Nov 2000 08:47:53 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:10767 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S129670AbQKMNrh>;
	Mon, 13 Nov 2000 08:47:37 -0500
Date: Mon, 13 Nov 2000 14:47:53 +0000
From: Francois romieu <romieu@ensta.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test11-pre4 compile fixes
Message-ID: <20001113144753.B12459@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- sound modules: adding __init without <linux/init.h> doesn't seem to work;
- typo in net/ax25/sysctl_net_ax25.c.

diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/gus_midi.c linux-2.4.0-test11-pre4/drivers/sound/gus_midi.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/gus_midi.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/gus_midi.c	Mon Nov 13 11:26:44 2000
@@ -14,6 +14,7 @@
  * 11-10-2000	Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *		Added __init to gus_midi_init()
  */
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "gus.h"
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/gus_wave.c linux-2.4.0-test11-pre4/drivers/sound/gus_wave.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/gus_wave.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/gus_wave.c	Mon Nov 13 11:28:10 2000
@@ -19,6 +19,7 @@
  
  
 #include <linux/config.h>
+#include <linux/init.h>
 
 #define GUSPNP_AUTODETECT
 
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/ics2101.c linux-2.4.0-test11-pre4/drivers/sound/ics2101.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/ics2101.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/ics2101.c	Mon Nov 13 11:28:59 2000
@@ -14,6 +14,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  * Bartlomiej Zolnierkiewicz : added __init to ics2101_mixer_init()
  */
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include <linux/ultrasound.h>
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_midi.c linux-2.4.0-test11-pre4/drivers/sound/pas2_midi.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_midi.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/pas2_midi.c	Mon Nov 13 11:29:54 2000
@@ -12,7 +12,7 @@
  *
  * Bartlomiej Zolnierkiewicz	: Added __init to pas_init_mixer()
  */
-
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "pas2.h"
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_mixer.c linux-2.4.0-test11-pre4/drivers/sound/pas2_mixer.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_mixer.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/pas2_mixer.c	Mon Nov 13 11:30:35 2000
@@ -16,6 +16,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  * Bartlomiej Zolnierkiewicz : added __init to pas_init_mixer()
  */
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "pas2.h"
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_pcm.c linux-2.4.0-test11-pre4/drivers/sound/pas2_pcm.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/pas2_pcm.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/pas2_pcm.c	Mon Nov 13 11:31:07 2000
@@ -14,6 +14,7 @@
  *		     more things module options.
  * Bartlomiej Zolnierkiewicz : Added __init to pas_pcm_init()
  */
+#include <linux/init.h>
 
 #include "sound_config.h"
 
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/drivers/sound/yss225.c linux-2.4.0-test11-pre4/drivers/sound/yss225.c
--- linux-2.4.0-test11-pre4.orig/drivers/sound/yss225.c	Mon Nov 13 09:55:55 2000
+++ linux-2.4.0-test11-pre4/drivers/sound/yss225.c	Mon Nov 13 11:33:07 2000
@@ -1,3 +1,5 @@
+#include <linux/init.h>
+
 unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
 0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,
diff -u -N --recursive linux-2.4.0-test11-pre4.orig/net/ax25/sysctl_net_ax25.c linux-2.4.0-test11-pre4/net/ax25/sysctl_net_ax25.c
--- linux-2.4.0-test11-pre4.orig/net/ax25/sysctl_net_ax25.c	Mon Nov 13 09:55:57 2000
+++ linux-2.4.0-test11-pre4/net/ax25/sysctl_net_ax25.c	Mon Nov 13 13:13:15 2000
@@ -114,7 +114,7 @@
 	memset(ax25_table, 0x00, ax25_table_size);
 
 	for (n = 0, ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next) {
-		ctl_table *child = kmalloc(sizeof(ax25_param_table, GFP_ATOMIC);
+		ctl_table *child = kmalloc(sizeof(ax25_param_table), GFP_ATOMIC);
 		if (!child) {
 			while (n--)
 				kfree(ax25_table[n].child);

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
