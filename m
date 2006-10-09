Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932921AbWJIPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbWJIPAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWJIPAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:00:53 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:26769 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S932921AbWJIPAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:00:52 -0400
Date: Mon, 9 Oct 2006 18:00:44 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: drzeus-list@drzeus.cx, rmk+mmc@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MMC: Select only one voltage bit in OCR response
Message-ID: <20061009150044.GB1637@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The card might go to inactive state (according to specification), if
there are unsupported bits set in the OCR.

Signed-off-by: Timo Teras <timo.teras@solidboot.com>

---

 drivers/mmc/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8208e380f51ca772e84a0b83098d24aacfa3cc2b
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index acc5365..61bf3fc 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -475,7 +475,7 @@ static u32 mmc_select_voltage(struct mmc
 	if (bit) {
 		bit -= 1;
 
-		ocr = 3 << bit;
+		ocr = 1 << bit;
 
 		host->ios.vdd = bit;
 		mmc_set_ios(host);
-- 
1.2.3.g90cc1

