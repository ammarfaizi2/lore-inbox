Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277377AbRJRA1n>; Wed, 17 Oct 2001 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277325AbRJRA1Y>; Wed, 17 Oct 2001 20:27:24 -0400
Received: from pc-62-30-142-167-nm.blueyonder.co.uk ([62.30.142.167]:60423
	"EHLO merry.bs.lan") by vger.kernel.org with ESMTP
	id <S277324AbRJRA1O>; Wed, 17 Oct 2001 20:27:14 -0400
Date: Thu, 18 Oct 2001 01:27:34 +0100
To: David Gibson <hermes@gibson.dropbear.id.au>,
        Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] to tidy up some orinoco driver log messages
Message-ID: <20011018012734.A2802@merry.bs.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Charles Briscoe-Smith <charles@briscoe-smith.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch cleans up a few missing newlines in some log messages
in the Orinoco driver.  Generated from linux-2.4.12 (orinoco.c 0.08a);
should apply cleanly to linux-2.4.13-pre3.

diff -ur linux/drivers/net/wireless/orinoco.c linux-2.4.12/drivers/net/wireless/orinoco.c
--- linux/drivers/net/wireless/orinoco.c	Thu Oct 18 01:08:20 2001
+++ linux-2.4.12/drivers/net/wireless/orinoco.c	Wed Oct 17 23:42:29 2001
@@ -1431,7 +1431,7 @@
 			priv->ibss_port = 0;
 		else {
 			printk(KERN_NOTICE "%s: Intersil firmware earlier "
-			       "than v0.08 - several features not supported.",
+			       "than v0.08 - several features not supported.\n",
 			       dev->name);
 			priv->ibss_port = 1;
 		}
@@ -1497,7 +1497,7 @@
 	err = hermes_read_ltv(hw, USER_BAP, HERMES_RID_CNF_NICKNAME,
 			      sizeof(nickbuf), &reclen, &nickbuf);
 	if (err) {
-		printk(KERN_ERR "%s: failed to read station name!n",
+		printk(KERN_ERR "%s: failed to read station name!\n",
 		       dev->name);
 		goto out;
 	}
@@ -1798,7 +1798,7 @@
 		if (err == -EIO)
 			DEBUG(1, "%s: DEBUG: EIO writing packet header to BAP\n", dev->name);
 		else
-			printk(KERN_ERR "%s: Error %d writing packet header to BAP",
+			printk(KERN_ERR "%s: Error %d writing packet header to BAP\n",
 			       dev->name, err);
 		stats->tx_errors++;
 		goto fail;

-- 
Charles Briscoe-Smith             Hacking Free Software for fun and profit
PGP/GPG:  1024R/B35EE811  74 68 AB 2E 1C 60 22 94  B8 21 2D 01 DE 66 13 E2
Governing Law:
   This License Agreement shall be construed and governed in accordance
   with the laws of the State of Inebriation. 
                                    -- http://www.thalia.org/computer.html
