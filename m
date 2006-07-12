Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWGLXbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWGLXbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWGLXbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:31:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:8165 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932236AbWGLXaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:30:46 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/5] [PATCH] Driver core: bus.c cleanups
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:26:52 -0700
Message-Id: <11527468203373-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11527468173384-git-send-email-greg@kroah.com>
References: <20060712232343.GA22672@kroah.com> <1152746814664-git-send-email-greg@kroah.com> <11527468173384-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

This patch contains the following cleanups:
- make the needlessly global bus_subsys static
- #if 0 the unused find_bus()

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 83fa8b2..2e954d0 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -129,7 +129,7 @@ static struct kobj_type ktype_bus = {
 
 };
 
-decl_subsys(bus, &ktype_bus, NULL);
+static decl_subsys(bus, &ktype_bus, NULL);
 
 
 #ifdef CONFIG_HOTPLUG
@@ -598,12 +598,13 @@ void put_bus(struct bus_type * bus)
  *
  *	Note that kset_find_obj increments bus' reference count.
  */
-
+#if 0
 struct bus_type * find_bus(char * name)
 {
 	struct kobject * k = kset_find_obj(&bus_subsys.kset, name);
 	return k ? to_bus(k) : NULL;
 }
+#endif  /*  0  */
 
 
 /**
-- 
1.4.1

