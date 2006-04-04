Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWDDJ3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWDDJ3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWDDJ3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:29:36 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:40322 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932423AbWDDJ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:29:35 -0400
Date: Tue, 4 Apr 2006 11:29:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Simon Evans <spse@secret.org.uk>
Subject: [Patch 2/3] Mark block2mtd as not deprecated
Message-ID: <20060404092930.GC12277@wohnheim.fh-wedel.de>
References: <20060404092628.GA12277@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060404092628.GA12277@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last (and only) bugreport for this driver was > 1 year ago.  There
is no reason to mark it as experimental anymore.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/devices/Kconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)


--- blkmtd/drivers/mtd/devices/Kconfig~block2mtd_experimental	2006-04-04 11:05:33.000000000 +0200
+++ blkmtd/drivers/mtd/devices/Kconfig	2006-04-04 11:08:40.000000000 +0200
@@ -143,12 +143,10 @@ config MTD_BLKMTD
 
 config MTD_BLOCK2MTD
 	tristate "MTD using block device (rewrite)"
-	depends on MTD && EXPERIMENTAL
+	depends on MTD
 	help
 	  This driver is basically the same at MTD_BLKMTD above, but
-	  experienced some interface changes plus serious speedups.  In
-	  the long term, it should replace MTD_BLKMTD.  Right now, you
-	  shouldn't entrust important data to it yet.
+	  experienced some interface changes plus serious speedups.
 
 comment "Disk-On-Chip Device Drivers"
 
