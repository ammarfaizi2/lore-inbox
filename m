Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVCNKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVCNKzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVCNKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:55:42 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:5834 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261450AbVCNKz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:55:27 -0500
Date: Mon, 14 Mar 2005 11:55:24 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: =?iso-8859-1?Q?=5BPATCH=5D=A0drivers=2Fmed?=
	=?iso-8859-1?Q?ia?= Sparse fixes
Message-ID: <20050314105524.GB24325@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes some sparse warnings on one-bit bitfields.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

--

 dvb/dvb-core/dvb_ca_en50221.c |    6 +++---
 video/cx88/cx88.h             |    4 ++--
 video/msp3400.c               |    4 ++--
 video/videocodec.h            |   16 ++++++++--------
 4 files changed, 15 insertions(+), 15 deletions(-)


===== drivers/media/dvb/dvb-core/dvb_ca_en50221.c 1.10 vs edited =====
--- 1.10/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-14 00:29:37 +01:00
+++ edited/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-14 11:40:56 +01:00
@@ -148,13 +148,13 @@
 	wait_queue_head_t thread_queue;
 
 	/* Flag indicating when thread should exit */
-	int exit:1;
+	unsigned int exit:1;
 
 	/* Flag indicating if the CA device is open */
-	int open:1;
+	unsigned int open:1;
 
 	/* Flag indicating the thread should wake up now */
-	int wakeup:1;
+	unsigned int wakeup:1;
 
 	/* Delay the main thread should use */
 	unsigned long delay;
===== drivers/media/video/msp3400.c 1.34 vs edited =====
--- 1.34/drivers/media/video/msp3400.c	2005-01-25 22:50:27 +01:00
+++ edited/drivers/media/video/msp3400.c	2005-03-14 11:38:24 +01:00
@@ -97,8 +97,8 @@
 	/* thread */
 	struct task_struct   *kthread;
 	wait_queue_head_t    wq;
-	int                  restart:1;
-	int                  watch_stereo:1;
+	unsigned int         restart:1;
+	unsigned int         watch_stereo:1;
 };
 
 #define HAVE_NICAM(msp)   (((msp->rev2>>8) & 0xff) != 00)
===== drivers/media/video/videocodec.h 1.3 vs edited =====
--- 1.3/drivers/media/video/videocodec.h	2005-01-05 03:48:33 +01:00
+++ edited/drivers/media/video/videocodec.h	2005-03-14 11:37:28 +01:00
@@ -222,14 +222,14 @@
 /* ========================= */
 
 struct vfe_polarity {
-	int vsync_pol:1;
-	int hsync_pol:1;
-	int field_pol:1;
-	int blank_pol:1;
-	int subimg_pol:1;
-	int poe_pol:1;
-	int pvalid_pol:1;
-	int vclk_pol:1;
+	unsigned int vsync_pol:1;
+	unsigned int hsync_pol:1;
+	unsigned int field_pol:1;
+	unsigned int blank_pol:1;
+	unsigned int subimg_pol:1;
+	unsigned int poe_pol:1;
+	unsigned int pvalid_pol:1;
+	unsigned int vclk_pol:1;
 };
 
 struct vfe_settings {
===== drivers/media/video/cx88/cx88.h 1.8 vs edited =====
--- 1.8/drivers/media/video/cx88/cx88.h	2005-03-11 21:32:23 +01:00
+++ edited/drivers/media/video/cx88/cx88.h	2005-03-14 11:39:36 +01:00
@@ -188,8 +188,8 @@
 	int                     tda9887_conf;
 	struct cx88_input       input[8];
 	struct cx88_input       radio;
-	int                     blackbird:1;
-	int                     dvb:1;
+	unsigned int            blackbird:1;
+	unsigned int            dvb:1;
 };
 
 struct cx88_subid {
