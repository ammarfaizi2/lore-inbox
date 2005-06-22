Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVFVG1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVFVG1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFVGZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:25:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:32156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262801AbVFVFWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:06 -0400
Cc: gregkh@suse.de
Subject: [PATCH] I2C: mark all functions static in atxp1 driver
In-Reply-To: <11194174622441@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174621742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: mark all functions static in atxp1 driver

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 69113efac29e5f1b7a03dd4fdca5ede6901f4eb8
tree 5decc38a1b2f5ede2f8d987c1f749f28a5432556
parent 9cb7d18433ea6db04b3999e8d0b8f52fba551c2d
author Greg K-H <gregkh@suse.de> Tue, 05 Apr 2005 18:00:47 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:50 -0700

 drivers/i2c/chips/atxp1.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/chips/atxp1.c b/drivers/i2c/chips/atxp1.c
--- a/drivers/i2c/chips/atxp1.c
+++ b/drivers/i2c/chips/atxp1.c
@@ -99,7 +99,7 @@ static struct atxp1_data * atxp1_update_
 }
 
 /* sys file functions for cpu0_vid */
-ssize_t atxp1_showvcore(struct device *dev, char *buf)
+static ssize_t atxp1_showvcore(struct device *dev, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -111,7 +111,7 @@ ssize_t atxp1_showvcore(struct device *d
 	return size;
 }
 
-ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -169,7 +169,7 @@ ssize_t atxp1_storevcore(struct device *
 static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
 
 /* sys file functions for GPIO1 */
-ssize_t atxp1_showgpio1(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio1(struct device *dev, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -181,7 +181,7 @@ ssize_t atxp1_showgpio1(struct device *d
 	return size;
 }
 
-ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -211,7 +211,7 @@ ssize_t atxp1_storegpio1(struct device *
 static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
 
 /* sys file functions for GPIO2 */
-ssize_t atxp1_showgpio2(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio2(struct device *dev, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -223,7 +223,7 @@ ssize_t atxp1_showgpio2(struct device *d
 	return size;
 }
 
-ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;

