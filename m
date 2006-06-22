Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWFVSfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWFVSfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWFVSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:34:47 -0400
Received: from ns1.suse.de ([195.135.220.2]:1930 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030337AbWFVSah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:37 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/14] [PATCH] w1: Move w1-connector definitions into linux/include/connector.h
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:08 -0700
Message-Id: <11510008522327-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008461301-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1_netlink.h   |    3 ---
 include/linux/connector.h |    5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index 5644221..56122b9 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -27,9 +27,6 @@ #include <linux/connector.h>
 
 #include "w1.h"
 
-#define CN_W1_IDX	3
-#define CN_W1_VAL	1
-
 enum w1_netlink_message_types {
 	W1_SLAVE_ADD = 0,
 	W1_SLAVE_REMOVE,
diff --git a/include/linux/connector.h b/include/linux/connector.h
index ad1a22c..4c02119 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -34,8 +34,11 @@ #define CN_IDX_PROC			0x1
 #define CN_VAL_PROC			0x1
 #define CN_IDX_CIFS			0x2
 #define CN_VAL_CIFS                     0x1
+#define CN_W1_IDX			0x3	/* w1 communication */
+#define CN_W1_VAL			0x1
 
-#define CN_NETLINK_USERS		1
+
+#define CN_NETLINK_USERS		4
 
 /*
  * Maximum connector's message size.
-- 
1.4.0

