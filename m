Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWBHDSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWBHDSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWBHDSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56704 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751138AbWBHDSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:18 -0500
To: torvalds@osdl.org
Subject: [PATCH 05/29] fix breakage in ocp.c
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1F6fqT-0006Bi-0E@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1137627616 -0500

it's ocp_device_...., not ocp_driver_....

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ppc/syslib/ocp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

83ec98be051b277635bc7379b863b25f6dbe54ce
diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index ab34b1d..2fe28de 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -189,8 +189,8 @@ ocp_device_resume(struct device *dev)
 struct bus_type ocp_bus_type = {
 	.name = "ocp",
 	.match = ocp_device_match,
-	.probe = ocp_driver_probe,
-	.remove = ocp_driver_remove,
+	.probe = ocp_device_probe,
+	.remove = ocp_device_remove,
 	.suspend = ocp_device_suspend,
 	.resume = ocp_device_resume,
 };
-- 
0.99.9.GIT

