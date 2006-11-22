Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756314AbWKVSSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbWKVSSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbWKVSSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:18:34 -0500
Received: from gilford.textdrive.com ([207.7.108.53]:6369 "EHLO
	gilford.textdrive.com") by vger.kernel.org with ESMTP
	id S1756295AbWKVSSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:18:33 -0500
Date: Wed, 22 Nov 2006 10:18:02 -0800
From: Ira Snyder <kernel@irasnyder.com>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse fix: initializer entry defined twice in pata_rz1000
Message-Id: <20061122101802.7b035434.kernel@irasnyder.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sparse fix: initializer entry defined twice in pata_rz1000

This removes the extra definition of the .error_handler member
in the pata_rz1000 driver.

Signed-off-by: Ira W. Snyder <kernel@irasnyder.com>

---
commit f84c313680a21fd6c487ac17f69c4c115472e257
tree 6fbf62c0d7dff66229e1c5f48721acd704b4e07e
parent e368d421bd8aef91af4013f1c289c6192f9a3e64
author Ira W. Snyder <kernel@irasnyder.com> Sun, 19 Nov 2006 23:40:03 -0800
committer Ira W. Snyder <kernel@irasnyder.com> Sun, 19 Nov 2006 23:40:03 -0800

 drivers/ata/pata_rz1000.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 4533b63..4747e89 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -103,8 +103,6 @@ static struct ata_port_operations rz1000
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.error_handler	= rz1000_error_handler,
-
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
 	.bmdma_stop	= ata_bmdma_stop,
