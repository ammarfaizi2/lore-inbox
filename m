Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSDGJ3R>; Sun, 7 Apr 2002 05:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSDGJ3Q>; Sun, 7 Apr 2002 05:29:16 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:10963 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313016AbSDGJ3Q>; Sun, 7 Apr 2002 05:29:16 -0400
Date: Sun, 7 Apr 2002 11:15:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WatchDog Driver Updates
In-Reply-To: <Pine.LNX.4.33.0204062139010.3791-100000@pita.lan>
Message-ID: <Pine.LNX.4.44.0204071114020.8253-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static int sc1200wdt_release(struct inode *inode, struct file *file)
 {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
 	if (expect_close) {
 		sc1200wdt_write_data(WDTO, 0);
 		printk(KERN_INFO PFX "Watchdog disabled\n");
@@ -202,7 +197,6 @@
 		sc1200wdt_write_data(WDTO, timeout);
 		printk(KERN_CRIT PFX "Unexpected close!, timeout = %d 
min(s)\n", timeout);
 	}	
-#endif

hmm, that would allow closing of the watchdog even if 
CONFIG_WATCHDOG_NOWAYOUT is specified. Was this your intention?

	Zwane
-- 
http://function.linuxpower.ca
		

