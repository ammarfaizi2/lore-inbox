Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422901AbWAMT7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWAMT7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWAMT5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:51092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422883AbWAMTuc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:32 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add SA1111 bus_type probe/remove methods
In-Reply-To: <11371818084013@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:08 -0800
Message-Id: <11371818081886@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add SA1111 bus_type probe/remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2876ba4321f0f85c40726b736eeaadf317803f16
tree bff3510763543ff92b613810347c34fcf7b4bdb7
parent e08b754161d6de4f91e2d3c805f350b35a95d8b8
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:32:32 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:05 -0800

 arch/arm/common/sa1111.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index d0d6e6d..1475089 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1247,14 +1247,14 @@ static int sa1111_bus_remove(struct devi
 struct bus_type sa1111_bus_type = {
 	.name		= "sa1111-rab",
 	.match		= sa1111_match,
+	.probe		= sa1111_bus_probe,
+	.remove		= sa1111_bus_remove,
 	.suspend	= sa1111_bus_suspend,
 	.resume		= sa1111_bus_resume,
 };
 
 int sa1111_driver_register(struct sa1111_driver *driver)
 {
-	driver->drv.probe = sa1111_bus_probe;
-	driver->drv.remove = sa1111_bus_remove;
 	driver->drv.bus = &sa1111_bus_type;
 	return driver_register(&driver->drv);
 }

