Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUKNA3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUKNA3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 19:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKNA3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 19:29:22 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:45219
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261220AbUKNA3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 19:29:02 -0500
Message-ID: <4196A6CA.9090906@ppp0.net>
Date: Sun, 14 Nov 2004 01:28:58 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: kraxel@bytesex.org
Subject: [PATCH] btaudio module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

btaudio module_param conversion

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

diff -Nru a/sound/oss/btaudio.c b/sound/oss/btaudio.c
--- a/sound/oss/btaudio.c	2004-11-14 01:24:57 +01:00
+++ b/sound/oss/btaudio.c	2004-11-14 01:24:57 +01:00
@@ -1113,15 +1113,15 @@
 module_init(btaudio_init_module);
 module_exit(btaudio_cleanup_module);

-MODULE_PARM(dsp1,"i");
-MODULE_PARM(dsp2,"i");
-MODULE_PARM(mixer,"i");
-MODULE_PARM(debug,"i");
-MODULE_PARM(irq_debug,"i");
-MODULE_PARM(digital,"i");
-MODULE_PARM(analog,"i");
-MODULE_PARM(rate,"i");
-MODULE_PARM(latency,"i");
+module_param(dsp1, int, S_IRUGO);
+module_param(dsp2, int, S_IRUGO);
+module_param(mixer, int, S_IRUGO);
+module_param(debug, int, S_IRUGO | S_IWUSR);
+module_param(irq_debug, int, S_IRUGO | S_IWUSR);
+module_param(digital, int, S_IRUGO);
+module_param(analog, int, S_IRUGO);
+module_param(rate, int, S_IRUGO);
+module_param(latency, int, S_IRUGO);
 MODULE_PARM_DESC(latency,"pci latency timer");

 MODULE_DEVICE_TABLE(pci, btaudio_pci_tbl);
