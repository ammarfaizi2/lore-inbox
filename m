Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWCXBbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWCXBbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422978AbWCXBbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:31:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:40132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422977AbWCXBbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:31:14 -0500
Cc: Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/8] fix W1_MASTER_DS9490_BRIDGE dependencies
In-Reply-To: <11431638371389-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 17:30:37 -0800
Message-Id: <11431638374-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the
dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/w1/masters/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ec068072f0e8499cfe7b71749b4a63c503e7d328
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 1ff11b5..c6bad4d 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -26,7 +26,7 @@ config W1_MASTER_DS9490
 
 config W1_MASTER_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_DS9490
+	depends on W1_MASTER_DS9490
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.
-- 
1.2.4


