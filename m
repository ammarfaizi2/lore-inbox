Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424821AbWKQAlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424821AbWKQAlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424823AbWKQAlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:41:36 -0500
Received: from mail.suse.de ([195.135.220.2]:56448 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424821AbWKQAlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:41:35 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Dennis Stosberg <dennis@stosberg.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/3] aoe: Add forgotten NULL at end of attribute list in aoeblk.c
Date: Thu, 16 Nov 2006 16:41:38 -0800
Message-Id: <11637241053626-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.3.5
In-Reply-To: <11637241024111-git-send-email-greg@kroah.com>
References: <20061117000740.GB687@kroah.com> <11637240981960-git-send-email-greg@kroah.com> <11637241024111-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Stosberg <dennis@stosberg.net>

This caused the system to stall when the aoe module was loaded.  The
error was introduced in commit 4ca5224f3ea4779054d96e885ca9b3980801ce13

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoeblk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index d433f27..aa25f8b 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -68,6 +68,7 @@ static struct attribute *aoe_attrs[] = {
 	&disk_attr_mac.attr,
 	&disk_attr_netif.attr,
 	&disk_attr_fwver.attr,
+	NULL
 };
 
 static const struct attribute_group attr_group = {
-- 
1.4.3.5

