Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263631AbREYIWT>; Fri, 25 May 2001 04:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263635AbREYIWM>; Fri, 25 May 2001 04:22:12 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263631AbREYIWF>;
	Fri, 25 May 2001 04:22:05 -0400
Message-ID: <20010525005458.A16774@bug.ucw.cz>
Date: Fri, 25 May 2001 00:54:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: jffs on non-mtd device (small bug)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

BTW the printk probably should be KERN_ERR, because this "warning" is
fatal.

								Pavel

inode-v23.c-    if (MAJOR(dev) != MTD_BLOCK_MAJOR) {
inode-v23.c-            printk(KERN_WARNING "JFFS: Trying to mount a "
inode-v23.c:                   "non-mtd device.\n");
inode-v23.c-            return 0;
inode-v23.c-    }

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
