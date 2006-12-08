Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425274AbWLHJTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425274AbWLHJTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425286AbWLHJTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:19:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45998 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425274AbWLHJTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:19:38 -0500
Date: Fri, 8 Dec 2006 09:19:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] appldata_mem dependes on vm counters
Message-ID: <20061208091933.GN4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 583d9ff..82313d8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -401,7 +401,7 @@ config APPLDATA_BASE
 
 config APPLDATA_MEM
 	tristate "Monitor memory management statistics"
-	depends on APPLDATA_BASE
+	depends on APPLDATA_BASE && VM_EVENT_COUNTERS
 	help
 	  This provides memory management related data to the Linux - VM Monitor
 	  Stream, like paging/swapping rate, memory utilisation, etc.
-- 
1.4.2.GIT
