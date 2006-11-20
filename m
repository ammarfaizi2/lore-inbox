Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966729AbWKTVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966729AbWKTVLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966744AbWKTVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:11:03 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:34689 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S966729AbWKTVLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:11:00 -0500
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git (again)
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Nov 2006 13:10:58 -0800
Message-ID: <adafycdhli5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Nov 2006 21:10:59.0101 (UTC) FILETIME=[604DDCD0:01C70CE8]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

Sorry for the multiple pull requests today, but this came in just
after I prepared my previous pull.  This adds one more tiny Kconfig
fix:

Bryan O'Sullivan (1):
      IB/ipath: Depend on CONFIG_NET

 drivers/infiniband/hw/ipath/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


commit 3f5a6ca31c334011fd929501a078424c0d3f71be
Author: Bryan O'Sullivan <bos@serpentine.com>
Date:   Mon Nov 20 10:54:34 2006 -0800

    IB/ipath: Depend on CONFIG_NET
    
    ipath uses skb functions and won't build without CONFIG_NET.
    
    Spotted by Randy Dunlap.
    
    Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>
    Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/hw/ipath/Kconfig b/drivers/infiniband/hw/ipath/Kconfig
index 5ca471a..90c1454 100644
--- a/drivers/infiniband/hw/ipath/Kconfig
+++ b/drivers/infiniband/hw/ipath/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_IPATH
 	tristate "QLogic InfiniPath Driver"
-	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND
+	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND && NET
 	---help---
 	This is a driver for QLogic InfiniPath host channel adapters,
 	including InfiniBand verbs support.  This driver allows these
