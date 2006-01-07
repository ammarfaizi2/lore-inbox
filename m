Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWAGXo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWAGXo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWAGXo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:44:57 -0500
Received: from stinky.trash.net ([213.144.137.162]:21705 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1161068AbWAGXo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:44:56 -0500
Message-ID: <43C0524F.1030602@trash.net>
Date: Sun, 08 Jan 2006 00:44:15 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [W1]: Remove incorrect MODULE_ALIAS
Content-Type: multipart/mixed;
 boundary="------------020006040501050104000605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020006040501050104000605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020006040501050104000605
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[W1]: Remove incorrect MODULE_ALIAS

The w1 netlink socket is created by a hardware specific driver calling
w1_add_master_device, so there is no point in including a module alias
for netlink autoloading in the core.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit a8657adb8c04bbe30544306ec55005a635ba65fd
tree 2c029cf104239958220629d34c76c7290bd99e43
parent b73952761225e41cb81afe157cb312a594a95693
author Patrick McHardy <kaber@trash.net> Sun, 08 Jan 2006 00:42:42 +0100
committer Patrick McHardy <kaber@trash.net> Sun, 08 Jan 2006 00:42:42 +0100

 drivers/w1/w1_int.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index c3f67ea..e2920f0 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -217,5 +217,3 @@ void w1_remove_master_device(struct w1_b
 
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
-
-MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_W1);

--------------020006040501050104000605--
