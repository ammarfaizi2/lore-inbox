Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759009AbWK3E0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009AbWK3E0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759008AbWK3E0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:26:21 -0500
Received: from www.swissdisk.com ([216.66.254.197]:24755 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1759016AbWK3E0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:26:18 -0500
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH 4/4] [HVCS] Select HVC_CONSOLE if HVCS is enabled.
Reply-To: Ben Collins <bcollins@ubuntu.com>
Date: Wed, 29 Nov 2006 23:26:08 -0500
Message-Id: <1164860773166-git-send-email-bcollins@ubuntu.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11648607683157-git-send-email-bcollins@ubuntu.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If HVC_CONSOLE provides symbols that HVCS requires.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/char/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 2af12fc..c94ecdc 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -598,6 +598,7 @@ config HVC_RTAS
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES
+	select HVC_CONSOLE
 	help
 	  Partitionable IBM Power5 ppc64 machines allow hosting of
 	  firmware virtual consoles from one Linux partition by
-- 
1.4.1

