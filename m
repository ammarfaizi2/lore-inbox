Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWIZFvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWIZFvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWIZFvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:51:12 -0400
Received: from mail.suse.de ([195.135.220.2]:57313 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751384AbWIZFjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:10 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/47] PM: schedule /sys/devices/.../power/state for removal
Date: Mon, 25 Sep 2006 22:37:41 -0700
Message-Id: <11592491512235-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491482560-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>

This lists the /sys/devices/.../power/state file, and its internal support,
as due for removal next year.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/feature-removal-schedule.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index a89a1b7..611acc3 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,21 @@ be removed from this file.
 
 ---------------------------
 
+What:	/sys/devices/.../power/state
+	dev->power.power_state
+	dpm_runtime_{suspend,resume)()
+When:	July 2007
+Why:	Broken design for runtime control over driver power states, confusing
+	driver-internal runtime power management with:  mechanisms to support
+	system-wide sleep state transitions; event codes that distinguish
+	different phases of swsusp "sleep" transitions; and userspace policy
+	inputs.  This framework was never widely used, and most attempts to
+	use it were broken.  Drivers should instead be exposing domain-specific
+	interfaces either to kernel or to userspace.
+Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
 What:	RAW driver (CONFIG_RAW_DRIVER)
 When:	December 2005
 Why:	declared obsolete since kernel 2.6.3
-- 
1.4.2.1

