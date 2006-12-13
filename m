Return-Path: <linux-kernel-owner+w=401wt.eu-S965120AbWLMTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWLMTyN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWLMTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:13 -0500
Received: from mx1.suse.de ([195.135.220.2]:45505 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965110AbWLMTyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:54:07 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/14] Driver core: "platform_driver_probe() can save codespace": save codespace
Date: Wed, 13 Dec 2006 11:53:03 -0800
Message-Id: <11660396273898-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396233517-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com> <11660396163757-git-send-email-greg@kroah.com> <11660396202644-git-send-email-greg@kroah.com> <11660396233517-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

This function can be __init

Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d1df4a0..0338289 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -473,7 +473,7 @@ EXPORT_SYMBOL_GPL(platform_driver_unregister);
  * Returns zero if the driver registered and bound to a device, else returns
  * a negative error code and with the driver not registered.
  */
-int platform_driver_probe(struct platform_driver *drv,
+int __init_or_module platform_driver_probe(struct platform_driver *drv,
 		int (*probe)(struct platform_device *))
 {
 	int retval, code;
-- 
1.4.4.2

