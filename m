Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWFVSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWFVSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWFVSbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:9098 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030357AbWFVSbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:04 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/14] [PATCH] drivers/w1/w1.c: fix a compile error
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:16 -0700
Message-Id: <11510008791727-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1151000876534-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com> <11510008691087-git-send-email-greg@kroah.com> <1151000872615-git-send-email-greg@kroah.com> <1151000876534-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

drivers/w1/w1.c:197: error: static declaration of 'w1_bus_type' follows non-static declaration
drivers/w1/w1.h:217: error: previous declaration of 'w1_bus_type' was here

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index c90a928..f1df534 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -211,7 +211,6 @@ static inline struct w1_master* dev_to_w
 }
 
 extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
 extern struct device w1_master_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;
-- 
1.4.0

