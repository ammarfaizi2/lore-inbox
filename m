Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVFTXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVFTXgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVFTXWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:22:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:1253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261806AbVFTXAS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:18 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: fix show_modalias() function due to attribute change
In-Reply-To: <11193083692279@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:30 -0700
Message-Id: <11193083702132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix show_modalias() function due to attribute change

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 87c8a4433b608261a9becdb0ce2d2f2ed4b71d05
tree c3ddd09b1ad6312fccecc67d26098bd634ea17de
parent 4893e9d1cfeb614b5155c43eefbb338b4f02cb34
author Greg Kroah-Hartman <gregkh@suse.de> Sun, 19 Jun 2005 12:21:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:28:51 -0700

 drivers/pci/pci-sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -73,7 +73,7 @@ resource_show(struct device * dev, struc
 	return (str - buf);
 }
 
-static ssize_t modalias_show(struct device *dev, char *buf)
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 

