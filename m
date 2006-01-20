Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWATGIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWATGIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWATGIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:7063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422692AbWATGIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:09 -0500
Cc: kaber@trash.net
Subject: [PATCH] W1: Remove incorrect MODULE_ALIAS
In-Reply-To: <11377372363607@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jan 2006 22:07:16 -0800
Message-Id: <11377372363603@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: Remove incorrect MODULE_ALIAS

The w1 netlink socket is created by a hardware specific driver calling
w1_add_master_device, so there is no point in including a module alias
for netlink autoloading in the core.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Acked-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c8d1a16495d65c58ac1454e33b124105db9eb4fd
tree d184d519cee36d595685abbcde303f4e9d2f164a
parent b6036c958a190777a16e89dc53088bd9fabfc2ff
author Patrick McHardy <kaber@trash.net> Sun, 08 Jan 2006 00:44:15 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 19 Jan 2006 21:53:26 -0800

 drivers/w1/w1_int.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 4724693..a2f9065 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -208,5 +208,3 @@ void w1_remove_master_device(struct w1_b
 
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
-
-MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_W1);

