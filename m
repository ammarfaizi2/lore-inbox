Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVCVO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVCVO2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCVO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:28:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19974 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261298AbVCVO2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:28:09 -0500
Date: Tue, 22 Mar 2005 15:28:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: osst@riede.org, osst-users@lists.sourceforge.net,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/osst.c: make code static
Message-ID: <20050322142806.GR3982@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Feb 2005

 drivers/scsi/osst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/osst.c.old	2005-02-28 19:36:05.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/osst.c	2005-02-28 19:36:25.000000000 +0100
@@ -24,7 +24,7 @@
 */
 
 static const char * cvsid = "$Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $";
-const char * osst_version = "0.99.3";
+static const char * osst_version = "0.99.3";
 
 /* The "failure to reconnect" firmware bug */
 #define OSST_FW_NEED_POLL_MIN 10601 /*(107A)*/
@@ -170,7 +170,7 @@
 static int osst_probe(struct device *);
 static int osst_remove(struct device *);
 
-struct scsi_driver osst_template = {
+static struct scsi_driver osst_template = {
 	.owner			= THIS_MODULE,
 	.gendrv = {
 		.name		=  "osst",

