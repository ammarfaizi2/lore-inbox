Return-Path: <linux-kernel-owner+w=401wt.eu-S965123AbWLMT4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWLMT4z (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWLMT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:56:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:45515 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965115AbWLMTyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:54:14 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/14] Driver core: deprecate PM_LEGACY, default it to N
Date: Wed, 13 Dec 2006 11:53:05 -0800
Message-Id: <11660396331364-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396303225-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com> <11660396163757-git-send-email-greg@kroah.com> <11660396202644-git-send-email-greg@kroah.com> <11660396233517-git-send-email-greg@kroah.com> <11660396273898-git-send-email-greg@kroah.com> <11660396303225-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Deprecate the old "legacy" PM API, and more importantly default it to "n".
Virtually nothing in-tree uses it any more.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/power/Kconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 710ed08..ed29622 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -20,13 +20,14 @@ config PM
 	  sending the processor to sleep and saving power.
 
 config PM_LEGACY
-	bool "Legacy Power Management API"
+	bool "Legacy Power Management API (DEPRECATED)"
 	depends on PM
-	default y
+	default n
 	---help---
-	   Support for pm_register() and friends.
+	   Support for pm_register() and friends.  This old API is obsoleted
+	   by the driver model.
 
-	   If unsure, say Y.
+	   If unsure, say N.
 
 config PM_DEBUG
 	bool "Power Management Debug Support"
-- 
1.4.4.2

