Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422918AbWAMUBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918AbWAMUBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422878AbWAMTua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:38036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422866AbWAMTu2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:28 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add locomo bus_type probe/remove methods
In-Reply-To: <11371818081886@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:08 -0800
Message-Id: <1137181808236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add locomo bus_type probe/remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 306955be37dd1b1f232f19766227ccccb83f7873
tree 580a152ea67887e0754419afd7868fb22403d6ad
parent 2876ba4321f0f85c40726b736eeaadf317803f16
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:33:04 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:05 -0800

 arch/arm/common/locomo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 1b7eaab..159ad7e 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -1103,14 +1103,14 @@ static int locomo_bus_remove(struct devi
 struct bus_type locomo_bus_type = {
 	.name		= "locomo-bus",
 	.match		= locomo_match,
+	.probe		= locomo_bus_probe,
+	.remove		= locomo_bus_remove,
 	.suspend	= locomo_bus_suspend,
 	.resume		= locomo_bus_resume,
 };
 
 int locomo_driver_register(struct locomo_driver *driver)
 {
-	driver->drv.probe = locomo_bus_probe;
-	driver->drv.remove = locomo_bus_remove;
 	driver->drv.bus = &locomo_bus_type;
 	return driver_register(&driver->drv);
 }

