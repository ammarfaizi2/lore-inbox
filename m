Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274814AbTHFCvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274826AbTHFCvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:51:21 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19841 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S274814AbTHFCsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:48:03 -0400
Date: Tue, 5 Aug 2003 22:16:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221620.GE13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030805221415.GB13275@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805221415.GB13275@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/08/05	ambx1@neo.rr.com	1.1110
# [SOUND] Remove __(dev)initdata from all pnp sound drivers
# 
# This patch is needed in order to avoid a potential oops.  It is
# similiar to the changes made to pci.
# 
# --------------------------------------------
#
diff -Nru a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
--- a/sound/isa/ad1816a/ad1816a.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/ad1816a/ad1816a.c	Tue Aug  5 21:24:50 2003
@@ -93,7 +93,7 @@
 	struct pnp_dev *devmpu;
 };
 
-static struct pnp_card_device_id snd_ad1816a_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_ad1816a_pnpids[] = {
 	/* Analog Devices AD1815 */
 	{ .id = "ADS7150", .devs = { { .id = "ADS7150" }, { .id = "ADS7151" } } },
 	/* Analog Devices AD1816A - added by Kenneth Platz <kxp@atl.hp.com> */
diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/als100.c	Tue Aug  5 21:24:50 2003
@@ -98,7 +98,7 @@
 	struct pnp_dev *devopl;
 };
 
-static struct pnp_card_device_id snd_als100_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_als100_pnpids[] = {
 	/* ALS100 - PRO16PNP */
 	{ .id = "ALS0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } } },
 	/* ALS110 - MF1000 - Digimate 3D Sound */
diff -Nru a/sound/isa/azt2320.c b/sound/isa/azt2320.c
--- a/sound/isa/azt2320.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/azt2320.c	Tue Aug  5 21:24:50 2003
@@ -109,7 +109,7 @@
 	struct pnp_dev *devmpu;
 };
 
-static struct pnp_card_device_id snd_azt2320_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_azt2320_pnpids[] = {
 	/* PRO16V */
 	{ .id = "AZT1008", .devs = { { "AZT1008" }, { "AZT2001" }, } },
 	/* Aztech Sound Galaxy 16 */
diff -Nru a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
--- a/sound/isa/cmi8330.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/cmi8330.c	Tue Aug  5 21:24:50 2003
@@ -172,7 +172,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_cmi8330_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_cmi8330_pnpids[] = {
 	{ .id = "CMI0001", .devs = { { "@@@0001" }, { "@X@0001" } } },
 	{ .id = "" }
 };
diff -Nru a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
--- a/sound/isa/cs423x/cs4236.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/cs423x/cs4236.c	Tue Aug  5 21:24:50 2003
@@ -174,7 +174,7 @@
 
 
 #ifdef CS4232
-static struct pnp_card_device_id snd_cs423x_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* Philips PCA70PS */
 	{ .id = "CSC0d32", .devs = { { "CSC0000" }, { "CSC0010" }, { "PNPb006" } } },
 	/* TerraTec Maestro 32/96 (CS4232) */
@@ -193,7 +193,7 @@
 	{ .id = "" }	/* end */
 };
 #else /* CS4236 */
-static struct pnp_card_device_id snd_cs423x_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	/* Intel Marlin Spike Motherboard - CS4235 */
 	{ .id = "CSC0225", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
 	/* Intel Marlin Spike Motherboard (#2) - CS4235 */
diff -Nru a/sound/isa/dt019x.c b/sound/isa/dt019x.c
--- a/sound/isa/dt019x.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/dt019x.c	Tue Aug  5 21:24:50 2003
@@ -88,7 +88,7 @@
 	struct pnp_dev *devopl;
 };
 
-static struct pnp_card_device_id snd_dt019x_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_dt019x_pnpids[] = {
 	/* DT197A30 */
 	{ .id = "RWB1688", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
 	/* DT0196 / ALS-007 */
diff -Nru a/sound/isa/es18xx.c b/sound/isa/es18xx.c
--- a/sound/isa/es18xx.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/es18xx.c	Tue Aug  5 21:24:50 2003
@@ -1940,7 +1940,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_audiodrive_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_audiodrive_pnpids[] = {
 	/* ESS 1868 (integrated on Compaq dual P-Pro motherboard and Genius 18PnP 3D) */
 	{ .id = "ESS1868", .devs = { { "ESS1868" }, { "ESS0000" } } },
 	/* ESS 1868 (integrated on Maxisound Cards) */
diff -Nru a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
--- a/sound/isa/gus/interwave.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/gus/interwave.c	Tue Aug  5 21:24:50 2003
@@ -138,7 +138,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_interwave_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_interwave_pnpids[] = {
 #ifndef SNDRV_STB
 	/* Gravis UltraSound Plug & Play */
 	{ .id = "GRV0001", .devs = { { .id = "GRV0000" } } },
diff -Nru a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/opl3sa2.c	Tue Aug  5 21:24:50 2003
@@ -161,7 +161,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_opl3sa2_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
 	{ .id = "YMH0020", .devs = { { "YMH0021" } } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
diff -Nru a/sound/isa/sb/es968.c b/sound/isa/sb/es968.c
--- a/sound/isa/sb/es968.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/sb/es968.c	Tue Aug  5 21:24:50 2003
@@ -69,7 +69,7 @@
 	struct pnp_dev *dev;
 };
 
-static struct pnp_card_device_id snd_es968_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_es968_pnpids[] = {
 	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
 	{ .id = "", } /* end */
 };
diff -Nru a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
--- a/sound/isa/sb/sb16.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/sb/sb16.c	Tue Aug  5 21:24:50 2003
@@ -157,7 +157,7 @@
 
 static snd_card_t *snd_sb16_legacy[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-static struct pnp_card_device_id snd_sb16_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_sb16_pnpids[] = {
 #ifndef SNDRV_SBAWE
 	/* Sound Blaster 16 PnP */
 	{ .id = "CTL0024", .devs = { { "CTL0031" } } },
diff -Nru a/sound/isa/sscape.c b/sound/isa/sscape.c
--- a/sound/isa/sscape.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/sscape.c	Tue Aug  5 21:24:50 2003
@@ -78,7 +78,7 @@
 MODULE_PARM_SYNTAX(dma, SNDRV_DMA8_DESC);
   
 #ifdef CONFIG_PNP
-static struct pnp_card_device_id sscape_pnpids[] __devinitdata = {
+static struct pnp_card_device_id sscape_pnpids[] = {
 	{ .id = "ENS3081", .devs = { { "ENS0000" } } },
 	{ .id = "" }	/* end */
 };
diff -Nru a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
--- a/sound/isa/wavefront/wavefront.c	Tue Aug  5 21:24:50 2003
+++ b/sound/isa/wavefront/wavefront.c	Tue Aug  5 21:24:50 2003
@@ -102,7 +102,7 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card_device_id snd_wavefront_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_wavefront_pnpids[] = {
 	/* Tropez */
 	{ .id = "CSC7532", .devs = { { "CSC0000" }, { "CSC0010" }, { "PnPb006" }, { "CSC0004" } } },
 	/* Tropez+ */
