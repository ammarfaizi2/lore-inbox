Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263635AbREYIXt>; Fri, 25 May 2001 04:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263636AbREYIXj>; Fri, 25 May 2001 04:23:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5892 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263635AbREYIX0>;
	Fri, 25 May 2001 04:23:26 -0400
Message-ID: <20010525005253.A16005@bug.ucw.cz>
Date: Fri, 25 May 2001 00:52:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jffs-dev@axis.com
Subject: jffs on non-MTD device?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to run jffs on my ATA-flash disk (running ext2 could kill
some flash cells too soon, right?) but it refuses:

        if (MAJOR(dev) != MTD_BLOCK_MAJOR) {
                printk(KERN_WARNING "JFFS: Trying to mount a "
                       "non-mtd device.\n");
                return 0;
        }

What are reasons for this check?

								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
