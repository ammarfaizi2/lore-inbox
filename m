Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAMXyA>; Sat, 13 Jan 2001 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAMXxv>; Sat, 13 Jan 2001 18:53:51 -0500
Received: from linuxcare.com.au ([203.29.91.49]:60679 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129511AbRAMXxk>; Sat, 13 Jan 2001 18:53:40 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sun, 14 Jan 2001 10:49:11 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcnet32 one liner
Message-ID: <20010114104911.C20398@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The code below is suspect.

Anton

diff -r -u --new-file --exclude-from=/home/anton/kernel/exclude linux/drivers/net/pcnet32.c linux_work/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c	Tue Dec 12 14:27:56 2000
+++ linux_work/drivers/net/pcnet32.c	Tue Jan  9 15:12:20 2001
@@ -809,7 +809,7 @@
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
     
-    if (lp->mii & !(lp->options & PORT_ASEL)) {
+    if (lp->mii && !(lp->options & PORT_ASEL)) {
 	val = lp->a.read_bcr (ioaddr, 32) & ~0x38; /* disable Auto Negotiation, set 10Mpbs, HD */
 	if (lp->options & PORT_FD)
 	    val |= 0x10;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
