Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWGTP7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWGTP7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGTP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:59:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17584 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030347AbWGTP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:59:22 -0400
Date: Fri, 21 Jul 2006 02:58:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, auke-jan.h.kok@intel.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: e1000: "fix" it on thinkpad x60
Message-ID: <20060721005832.GA1889@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e1000 in thinkpad x60 fails without this dirty hack. What to do with
it?

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 6414eba4f65ded35f3a8f2d61261d1134e292506
tree e6560bba2cc0d18b76075e6b5db415d6c0c31db3
parent fa6f216422f9020c06dd1137aec8c72224cbe440
author <pavel@amd.ucw.cz> Fri, 21 Jul 2006 02:16:52 +0200
committer <pavel@amd.ucw.cz> Fri, 21 Jul 2006 02:16:52 +0200

 drivers/net/e1000/e1000_main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 6e7d31b..808c442 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -842,8 +842,10 @@ e1000_probe(struct pci_dev *pdev,
 
 	if (e1000_validate_eeprom_checksum(&adapter->hw) < 0) {
 		DPRINTK(PROBE, ERR, "The EEPROM Checksum Is Not Valid\n");
+/*
 		err = -EIO;
 		goto err_eeprom;
+*/
 	}
 
 	/* copy the MAC address out of the EEPROM */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
