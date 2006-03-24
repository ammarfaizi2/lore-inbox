Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422983AbWCXBdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWCXBdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWCXBcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:32:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:39620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422976AbWCXBbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:31:14 -0500
Cc: Patrick McHardy <kaber@trash.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/8] W1: Remove incorrect MODULE_ALIAS
In-Reply-To: <11431638374-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 17:30:37 -0800
Message-Id: <11431638372371-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The w1 netlink socket is created by a hardware specific driver calling
w1_add_master_device, so there is no point in including a module alias
for netlink autoloading in the core.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Acked-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/w1/w1_int.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

ecd5136c85cb4531a51f65241e7b3cd58420f3ed
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 4724693..a2f9065 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -208,5 +208,3 @@ void w1_remove_master_device(struct w1_b
 
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
-
-MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_W1);
-- 
1.2.4


