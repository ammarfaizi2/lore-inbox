Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWIZFpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWIZFpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWIZFow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:44:52 -0400
Received: from mail.suse.de ([195.135.220.2]:64481 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751432AbWIZFkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:09 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 36/47] Driver core: fixed add_bind_files() definition
Date: Mon, 25 Sep 2006 22:37:56 -0700
Message-Id: <1159249200793-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249196427-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

When CONFIG_HOTPLUG is n, add_bind_files() definition is wrong.
This patch has fixed it.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 2e954d0..4d22a1d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -467,7 +467,7 @@ static void remove_bind_files(struct dev
 	driver_remove_file(drv, &driver_attr_unbind);
 }
 #else
-static inline void add_bind_files(struct device_driver *drv) {}
+static inline int add_bind_files(struct device_driver *drv) { return 0; }
 static inline void remove_bind_files(struct device_driver *drv) {}
 #endif
 
-- 
1.4.2.1

