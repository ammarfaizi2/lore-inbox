Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268549AbTCAMFN>; Sat, 1 Mar 2003 07:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTCAMFN>; Sat, 1 Mar 2003 07:05:13 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:6290 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268549AbTCAMFM>;
	Sat, 1 Mar 2003 07:05:12 -0500
Date: Sat, 1 Mar 2003 13:15:16 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [via-rhine][PATCH] 1.17 release
Message-ID: <20030301121516.GA2706@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20030227114417.GA3970@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Alas no rave reviews on lkml, but the private feedback I have received so
far on the recent changes has been excellent. The Rhine-II is now finally
usable with via-rhine. Time to call it 1.17. -- Please apply.

FWIW I think the four patches (including this one) leading up to 1.17 are
2.4 material, too. The drivers were identical at 1.16, and some kind souls
successfully tested 1.17 on 2.4. Given the low frequency of 2.4 releases
and the brokenness of the driver until now, it would seem like a good idea
to have it in 2.4.21.

Roger


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.17-version_log.diff"

--- 09_reset_trivial/drivers/net/via-rhine.c	Thu Feb 27 13:27:00 2003
+++ 10_version_log/drivers/net/via-rhine.c	Sat Mar  1 12:53:03 2003
@@ -108,11 +108,18 @@
 	- New reset code uses "force reset" cmd on Rhine-II
 	- Various clean ups
 
+	LK1.1.17 (Roger Luethi)
+	- Fix race in via_rhine_start_tx()
+	- On errors, wait for Tx engine to turn off before scavenging
+	- Handle Tx descriptor write-back race on Rhine-II
+	- Force flushing for PCI posted writes
+	- More reset code changes
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.16"
-#define DRV_RELDATE	"February-15-2003"
+#define DRV_VERSION	"1.1.17"
+#define DRV_RELDATE	"March-1-2003"
 
 
 /* A few user-configurable values.

--GvXjxJ+pjyke8COw--
