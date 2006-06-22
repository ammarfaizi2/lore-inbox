Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWFVSdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWFVSdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWFVSdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:33:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59326 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161174AbWFVSbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:13 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/14] [PATCH] w1: clean up W1_CON dependency.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:17 -0700
Message-Id: <11510008821893-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008791727-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com> <11510008691087-git-send-email-greg@kroah.com> <1151000872615-git-send-email-greg@kroah.com> <1151000876534-git-send-email-greg@kroah.com> <11510008791727-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

If w1 is not enabled, w1_con should not appear in configuration,
even if no logic is turned on without w1.
W1_CON should depend on W1 also.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
index 0c6c435..f2d9a08 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -12,7 +12,7 @@ config W1
 	  will be called wire.ko.
 
 config W1_CON
-	depends on CONNECTOR
+	depends on CONNECTOR && W1
 	bool "Userspace communication over connector"
 	default y
 	--- help ---
-- 
1.4.0

