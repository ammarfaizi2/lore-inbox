Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756043AbWKQX6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbWKQX6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWKQX6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:58:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34054 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756043AbWKQX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:58:22 -0500
Date: Sat, 18 Nov 2006 00:58:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [-mm patch] make sound/pci/hda/patch_sigmatel.c:stac92xx_dmic_labels[] static
Message-ID: <20061117235820.GL31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-alsa.patch
>...
>  git trees
>...

This patch makes the needlessly global stac92xx_dmic_labels[] static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/sound/pci/hda/patch_sigmatel.c.old	2006-11-17 18:36:16.000000000 +0100
+++ linux-2.6.19-rc5-mm2/sound/pci/hda/patch_sigmatel.c	2006-11-17 18:36:26.000000000 +0100
@@ -1201,7 +1201,7 @@
 }
 
 /* labels for dmic mux inputs */
-const char *stac92xx_dmic_labels[5] = {
+static const char *stac92xx_dmic_labels[5] = {
 	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
 	"Digital Mic 3", "Digital Mic 4"
 };

