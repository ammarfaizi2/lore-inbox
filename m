Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWFYXN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFYXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWFYXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:13:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16147 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932416AbWFYXN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:13:26 -0400
Date: Mon, 26 Jun 2006 01:13:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, alan@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: [-mm patch] make drivers/scsi/pata_it821x.c:it821x_passthru_dev_select() static
Message-ID: <20060625231324.GK23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
>  git-libata-all.patch
>...
>  git trees
>...

This patch makes the needlessly global it821x_passthru_dev_select() 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/drivers/scsi/pata_it821x.c.old	2006-06-25 22:52:11.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/scsi/pata_it821x.c	2006-06-25 22:52:52.000000000 +0200
@@ -411,7 +411,8 @@
  *	Device selection hook. If neccessary perform clock switching
  */
  
-void it821x_passthru_dev_select(struct ata_port *ap, unsigned int device)
+static void it821x_passthru_dev_select(struct ata_port *ap,
+				       unsigned int device)
 {
 	struct it821x_dev *itdev = ap->private_data;
 	if (itdev && device != itdev->last_device) {

