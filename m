Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752589AbWAHLs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbWAHLs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWAHLs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:48:57 -0500
Received: from [85.8.13.51] ([85.8.13.51]:962 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1752589AbWAHLs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:48:56 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Support MMC version 4 cards.
Date: Sun, 08 Jan 2006 12:48:47 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060108114846.4507.9475.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4 of the MMC specification increased the version number of the
CID structure. None of the fields changed though so the only required
change is adding '4' to the approved list.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 6696f71..bfca5c1 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -495,6 +495,7 @@ static void mmc_decode_cid(struct mmc_ca
 
 		case 2: /* MMC v2.0 - v2.2 */
 		case 3: /* MMC v3.1 - v3.3 */
+		case 4: /* MMC v4 */
 			card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
 			card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 			card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);

