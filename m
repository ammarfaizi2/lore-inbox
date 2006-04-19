Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWDSOkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDSOkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDSOkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:40:11 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:3249 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750803AbWDSOkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:40:10 -0400
Date: Wed, 19 Apr 2006 16:40:08 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Message-ID: <20060419144008.GD24807@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ALSA drivers for PCMCIA devices depend on ISA, but modern
laptops can have PCMCIA support without ISA. This patch removes
the dependency.

Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index 5d1b0b7..c9fa1a2 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -5,7 +5,7 @@ menu "PCMCIA devices"
 
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
-	depends on SND && PCMCIA && ISA
+	depends on SND && PCMCIA
 	select SND_VX_LIB
 	help
 	  Say Y here to include support for Digigram VXpocket and
@@ -16,7 +16,7 @@ config SND_VXPOCKET
 
 config SND_PDAUDIOCF
 	tristate "Sound Core PDAudioCF"
-	depends on SND && PCMCIA && ISA
+	depends on SND && PCMCIA
 	select SND_PCM
 	help
 	  Say Y here to include support for Sound Core PDAudioCF
