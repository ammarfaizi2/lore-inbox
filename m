Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUDNUFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDNUFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:05:18 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:4072 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261479AbUDNUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:05:09 -0400
Subject: [PATCH 2.6.5-mm4] Trivial : emu10k1 definition redundancy
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-IfKV+k5/zX+Fhh2k6zJj"
Message-Id: <1081973268.5445.35.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 14 Apr 2004 22:07:48 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx016.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IfKV+k5/zX+Fhh2k6zJj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Remove emu10k1_t definition redundancy

Regards,
Fabian



--=-IfKV+k5/zX+Fhh2k6zJj
Content-Disposition: attachment; filename=emu10k11.diff
Content-Type: text/x-patch; name=emu10k11.diff; charset=
Content-Transfer-Encoding: 7bit

diff -Naur orig/include/sound/emu10k1.h edited/include/sound/emu10k1.h
--- orig/include/sound/emu10k1.h	2004-04-04 05:36:52.000000000 +0200
+++ edited/include/sound/emu10k1.h	2004-04-07 11:25:50.000000000 +0200
@@ -1368,4 +1368,6 @@
 #define SNDRV_EMU10K1_IOCTL_SINGLE_STEP	_IOW ('H', 0x83, int)
 #define SNDRV_EMU10K1_IOCTL_DBG_READ	_IOR ('H', 0x84, int)
 
+#define chip_t emu10k1_t
+
 #endif	/* __SOUND_EMU10K1_H */
diff -Naur orig/sound/pci/emu10k1/emufx.c edited/sound/pci/emu10k1/emufx.c
--- orig/sound/pci/emu10k1/emufx.c	2004-04-04 05:37:07.000000000 +0200
+++ edited/sound/pci/emu10k1/emufx.c	2004-04-07 11:26:09.000000000 +0200
@@ -33,8 +33,6 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-#define chip_t emu10k1_t
-
 #if 0		/* for testing purposes - digital out -> capture */
 #define EMU10K1_CAPTURE_DIGITAL_OUT
 #endif
diff -Naur orig/sound/pci/emu10k1/emumixer.c edited/sound/pci/emu10k1/emumixer.c
--- orig/sound/pci/emu10k1/emumixer.c	2004-04-04 05:38:11.000000000 +0200
+++ edited/sound/pci/emu10k1/emumixer.c	2004-04-07 11:25:54.000000000 +0200
@@ -32,8 +32,6 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-#define chip_t emu10k1_t
-
 static int snd_emu10k1_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;

--=-IfKV+k5/zX+Fhh2k6zJj--

