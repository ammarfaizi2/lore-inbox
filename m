Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDQT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDQT7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDQT7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:59:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:787 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261455AbVDQT6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:58:14 -0400
Date: Sun, 17 Apr 2005 21:58:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/agp/: make code static
Message-ID: <20050417195812.GE3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/agp/ali-agp.c      |    4 ++--
 drivers/char/agp/amd-k7-agp.c   |    2 +-
 drivers/char/agp/amd64-agp.c    |    2 +-
 drivers/char/agp/ati-agp.c      |    2 +-
 drivers/char/agp/backend.c      |    4 ++--
 drivers/char/agp/efficeon-agp.c |    2 +-
 drivers/char/agp/frontend.c     |    6 +++---
 drivers/char/agp/nvidia-agp.c   |    2 +-
 drivers/char/agp/sis-agp.c      |    2 +-
 drivers/char/agp/sworks-agp.c   |    2 +-
 drivers/char/agp/via-agp.c      |    4 ++--
 11 files changed, 16 insertions(+), 16 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/ali-agp.c.old	2005-04-17 17:53:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/ali-agp.c	2005-04-17 17:53:49.000000000 +0200
@@ -192,7 +192,7 @@
 	{4, 1024, 0, 3}
 };
 
-struct agp_bridge_driver ali_generic_bridge = {
+static struct agp_bridge_driver ali_generic_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ali_generic_sizes,
 	.size_type		= U32_APER_SIZE,
@@ -215,7 +215,7 @@
 	.agp_destroy_page	= ali_destroy_page,
 };
 
-struct agp_bridge_driver ali_m1541_bridge = {
+static struct agp_bridge_driver ali_m1541_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ali_generic_sizes,
 	.size_type		= U32_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/amd-k7-agp.c.old	2005-04-17 17:53:58.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/amd-k7-agp.c	2005-04-17 17:54:08.000000000 +0200
@@ -358,7 +358,7 @@
 	{.mask = 1, .type = 0}
 };
 
-struct agp_bridge_driver amd_irongate_driver = {
+static struct agp_bridge_driver amd_irongate_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= amd_irongate_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/amd64-agp.c.old	2005-04-17 17:54:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/amd64-agp.c	2005-04-17 17:54:35.000000000 +0200
@@ -243,7 +243,7 @@
 }
 
 
-struct agp_bridge_driver amd_8151_driver = {
+static struct agp_bridge_driver amd_8151_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= amd_8151_sizes,
 	.size_type		= U32_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/ati-agp.c.old	2005-04-17 17:54:43.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/ati-agp.c	2005-04-17 17:54:51.000000000 +0200
@@ -393,7 +393,7 @@
 	return 0;
 }
 
-struct agp_bridge_driver ati_generic_bridge = {
+static struct agp_bridge_driver ati_generic_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ati_generic_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/backend.c.old	2005-04-17 17:55:00.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/backend.c	2005-04-17 17:55:24.000000000 +0200
@@ -97,7 +97,7 @@
 EXPORT_SYMBOL(agp_backend_release);
 
 
-struct { int mem, agp; } maxes_table[] = {
+static struct { int mem, agp; } maxes_table[] = {
 	{0, 0},
 	{32, 4},
 	{64, 28},
@@ -322,7 +322,7 @@
 	return 0;
 }
 
-void __exit agp_exit(void)
+static void __exit agp_exit(void)
 {
 }
 
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/efficeon-agp.c.old	2005-04-17 17:55:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/efficeon-agp.c	2005-04-17 17:55:47.000000000 +0200
@@ -303,7 +303,7 @@
 }
 
 
-struct agp_bridge_driver efficeon_driver = {
+static struct agp_bridge_driver efficeon_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= efficeon_generic_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/frontend.c.old	2005-04-17 17:55:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/frontend.c	2005-04-17 17:56:18.000000000 +0200
@@ -235,7 +235,7 @@
 
 /* File private list routines */
 
-struct agp_file_private *agp_find_private(pid_t pid)
+static struct agp_file_private *agp_find_private(pid_t pid)
 {
 	struct agp_file_private *curr;
 
@@ -250,7 +250,7 @@
 	return NULL;
 }
 
-void agp_insert_file_private(struct agp_file_private * priv)
+static void agp_insert_file_private(struct agp_file_private * priv)
 {
 	struct agp_file_private *prev;
 
@@ -262,7 +262,7 @@
 	agp_fe.file_priv_list = priv;
 }
 
-void agp_remove_file_private(struct agp_file_private * priv)
+static void agp_remove_file_private(struct agp_file_private * priv)
 {
 	struct agp_file_private *next;
 	struct agp_file_private *prev;
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/nvidia-agp.c.old	2005-04-17 17:56:36.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/nvidia-agp.c	2005-04-17 17:56:46.000000000 +0200
@@ -288,7 +288,7 @@
 };
 
 
-struct agp_bridge_driver nvidia_driver = {
+static struct agp_bridge_driver nvidia_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= nvidia_generic_sizes,
 	.size_type		= U8_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/sis-agp.c.old	2005-04-17 17:56:55.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/sis-agp.c	2005-04-17 17:57:05.000000000 +0200
@@ -119,7 +119,7 @@
 	{4, 1024, 0, 3}
 };
 
-struct agp_bridge_driver sis_driver = {
+static struct agp_bridge_driver sis_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes 	= sis_generic_sizes,
 	.size_type		= U8_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/sworks-agp.c.old	2005-04-17 17:57:19.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/sworks-agp.c	2005-04-17 17:57:34.000000000 +0200
@@ -409,7 +409,7 @@
 	agp_device_command(command, 0);
 }
 
-struct agp_bridge_driver sworks_driver = {
+static struct agp_bridge_driver sworks_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= serverworks_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.12-rc2-mm3-full/drivers/char/agp/via-agp.c.old	2005-04-17 17:57:46.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/agp/via-agp.c	2005-04-17 17:58:11.000000000 +0200
@@ -170,7 +170,7 @@
 }
 
 
-struct agp_bridge_driver via_agp3_driver = {
+static struct agp_bridge_driver via_agp3_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= agp3_generic_sizes,
 	.size_type		= U8_APER_SIZE,
@@ -193,7 +193,7 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-struct agp_bridge_driver via_driver = {
+static struct agp_bridge_driver via_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= via_generic_sizes,
 	.size_type		= U8_APER_SIZE,

