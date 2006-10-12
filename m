Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWJLRPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWJLRPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWJLRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:15:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932169AbWJLROv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:14:51 -0400
Subject: [PATCH 3/7] [DLM] Kconfig: don't show an empty DLM menu
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Patrick Caulfield <pcaulfie@redhat.com>,
       David Teigland <teigland@redhat.com>, Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:06 +0100
Message-Id: <1160673546.11901.820.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 1ee48af22ed6dcddea8cdf93c7f2a268cbcf0d56 Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 8 Oct 2006 04:30:48 +0200
Subject: [DLM] Kconfig: don't show an empty DLM menu

Don't show an empty "Distributed Lock Manager" menu if IP_SCTP=n.

Reported by Dmytro Bagrii in kernel Bugzilla #7268.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/Kconfig b/fs/dlm/Kconfig
index 490f85b..81b2c64 100644
--- a/fs/dlm/Kconfig
+++ b/fs/dlm/Kconfig
@@ -1,10 +1,9 @@
 menu "Distributed Lock Manager"
-	depends on INET && EXPERIMENTAL
+	depends on INET && IP_SCTP && EXPERIMENTAL
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
 	depends on IPV6 || IPV6=n
-	depends on IP_SCTP
 	select CONFIGFS_FS
 	help
 	A general purpose distributed lock manager for kernel or userspace
-- 
1.4.1



