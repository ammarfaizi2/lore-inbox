Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKODhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKODhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUKODgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:36:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261476AbUKOChD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:37:03 -0500
Date: Mon, 15 Nov 2004 03:22:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: osst@riede.org
Cc: osst-users@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI osst.c: make some code static
Message-ID: <20041115022231.GV2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/osst.c.old	2004-11-13 22:44:39.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/osst.c	2004-11-13 22:44:59.000000000 +0100
@@ -24,7 +24,7 @@
 */
 
 static const char * cvsid = "$Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $";
-const char * osst_version = "0.99.1";
+static const char * osst_version = "0.99.1";
 
 /* The "failure to reconnect" firmware bug */
 #define OSST_FW_NEED_POLL_MIN 10601 /*(107A)*/
@@ -164,7 +164,7 @@
 static int osst_probe(struct device *);
 static int osst_remove(struct device *);
 
-struct scsi_driver osst_template = {
+static struct scsi_driver osst_template = {
 	.owner			= THIS_MODULE,
 	.gendrv = {
 		.name		=  "osst",

