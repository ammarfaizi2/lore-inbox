Return-Path: <linux-kernel-owner+w=401wt.eu-S1762519AbWLJTV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762519AbWLJTV4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762525AbWLJTV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:21:56 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:56987 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762519AbWLJTVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:21:55 -0500
Date: Sun, 10 Dec 2006 19:21:51 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH] Make lm70_remove a __devexit function
Message-ID: <20061210192151.GA32262@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saves a few bytes on the module.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 6ba8473..7eaae38 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -126,7 +126,7 @@ out_dev_reg_failed:
 	return status;
 }
 
-static int __exit lm70_remove(struct spi_device *spi)
+static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
 
