Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWFUXUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWFUXUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbWFUXUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:20:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39435 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030463AbWFUXUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:20:13 -0400
Date: Thu, 22 Jun 2006 01:20:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, alan@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: [-mm patch] make drivers/scsi/pata_pcmcia.c:pcmcia_remove_one() static
Message-ID: <20060621232012.GT9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-libata-all.patch
>...
>  git trees
>...

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/drivers/scsi/pata_pcmcia.c.old	2006-06-22 00:43:23.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/scsi/pata_pcmcia.c	2006-06-22 00:43:33.000000000 +0200
@@ -294,7 +294,7 @@
  *	cleanup. Also called on module unload for any active devices.
  */
 
-void pcmcia_remove_one(struct pcmcia_device *pdev)
+static void pcmcia_remove_one(struct pcmcia_device *pdev)
 {
 	struct ata_pcmcia_info *info = pdev->priv;
 	struct device *dev = &pdev->dev;

