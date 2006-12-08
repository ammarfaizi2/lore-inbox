Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938020AbWLHJSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938020AbWLHJSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938019AbWLHJSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:18:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45951 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938020AbWLHJSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:18:34 -0500
Date: Fri, 8 Dec 2006 09:18:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_COMPUTONE should depend on ISA|EISA|PCI
Message-ID: <20061208091833.GM4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 24f922f..dc75543 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -97,7 +97,7 @@ config SERIAL_NONSTANDARD
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
-- 
1.4.2.GIT
