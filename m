Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162300AbWLAXYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162300AbWLAXYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162278AbWLAXYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:24:17 -0500
Received: from ns.suse.de ([195.135.220.2]:53389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162241AbWLAXX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:59 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/36] Driver core: make drivers/base/core.c:setup_parent() static
Date: Fri,  1 Dec 2006 15:22:01 -0800
Message-Id: <11650154282911-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154251022-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

This patch makes the needlessly global setup_parent() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a29e685..75b45a1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -389,7 +389,7 @@ void device_initialize(struct device *de
 }
 
 #ifdef CONFIG_SYSFS_DEPRECATED
-int setup_parent(struct device *dev, struct device *parent)
+static int setup_parent(struct device *dev, struct device *parent)
 {
 	/* Set the parent to the class, not the parent device */
 	/* this keeps sysfs from having a symlink to make old udevs happy */
@@ -418,7 +418,7 @@ static int virtual_device_parent(struct
 	return 0;
 }
 
-int setup_parent(struct device *dev, struct device *parent)
+static int setup_parent(struct device *dev, struct device *parent)
 {
 	int error;
 
-- 
1.4.4.1

