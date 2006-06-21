Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWFUTux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWFUTux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWFUTuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:14234 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030235AbWFUTte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:34 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/22] [PATCH] Driver Core: CONFIG_DEBUG_PM covers drivers/base/power too
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:51 -0700
Message-Id: <11509191893358-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <115091918546-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

The drivers/base/power PM debug messages should appear when
either PM or driver model debug are enabled.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index c0219ad..ceeeba2 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -4,3 +4,6 @@ obj-$(CONFIG_PM)	+= main.o suspend.o res
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
+ifeq ($(CONFIG_PM_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
-- 
1.4.0

