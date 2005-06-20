Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVFUDXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVFUDXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVFUDXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:23:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:2532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261639AbVFTW7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:31 -0400
Cc: gregkh@suse.de
Subject: [PATCH] USB: fix show_modalias() function due to attribute change
In-Reply-To: <11193083693615@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <11193083692279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: fix show_modalias() function due to attribute change

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4893e9d1cfeb614b5155c43eefbb338b4f02cb34
tree 4f6637cf3496fa9d6d645d38680d542c21e8b263
parent 9d9d27fb651a7c95a46f276bacb4329db47470a6
author Greg Kroah-Hartman <gregkh@suse.de> Sun, 19 Jun 2005 12:21:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:27:35 -0700

 drivers/usb/core/sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -286,7 +286,7 @@ static ssize_t show_interface_string(str
 }
 static DEVICE_ATTR(interface, S_IRUGO, show_interface_string, NULL);
 
-static ssize_t show_modalias(struct device *dev, char *buf)
+static ssize_t show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf;
 	struct usb_device *udev;

