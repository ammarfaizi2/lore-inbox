Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754280AbWKMIPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbWKMIPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbWKMIPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:15:23 -0500
Received: from kleekamp.stosberg.net ([85.116.201.130]:15488 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1754280AbWKMIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:15:22 -0500
Date: Mon, 13 Nov 2006 09:15:20 +0100
From: Dennis Stosberg <dennis@stosberg.net>
To: Greg Kroah-Hartman <gregkh@suse.de>, "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aoe: Add forgotten NULL at end of attribute list in aoeblk.c
Message-ID: <20061113081520.G77d5ed8a@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This caused the system to stall when the aoe module was loaded.  The
error was introduced in commit 4ca5224f3ea4779054d96e885ca9b3980801ce13

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

The log of the caused error can be found at
http://stosberg.net/tmp/aoe_trace.txt

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
1.4.3.3

