Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWJHCaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWJHCaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWJHCaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:30:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750753AbWJHCay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:30:54 -0400
Date: Sun, 8 Oct 2006 04:30:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, pcaulfie@redhat.com, teigland@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Dmytro Bagrii <dmb@pochta.ru>
Subject: [2.6 patch] Kconfig: don't show an empty DLM menu
Message-ID: <20061008023048.GD29474@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't show an empty "Distributed Lock Manager" menu if IP_SCTP=n.

Reported by Dmytro Bagrii in kernel Bugzilla #7268.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/dlm/Kconfig.old	2006-10-08 04:20:28.000000000 +0200
+++ linux-2.6/fs/dlm/Kconfig	2006-10-08 04:21:05.000000000 +0200
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

