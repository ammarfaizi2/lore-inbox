Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319796AbSIMVcp>; Fri, 13 Sep 2002 17:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319798AbSIMVcp>; Fri, 13 Sep 2002 17:32:45 -0400
Received: from ulima.unil.ch ([130.223.144.143]:23168 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319796AbSIMVco>;
	Fri, 13 Sep 2002 17:32:44 -0400
Date: Fri, 13 Sep 2002 23:37:36 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 unable to mount root fs on 09:00 (smp,raid1,devfs,scsi )
Message-ID: <20020913213736.GB10593@ulima.unil.ch>
References: <A5974D8E5F98D511BB910002A50A66470580D1AE@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D1AE@hdsmsx103.hd.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maybe what you suggest could be right ;-)

Martin Fahr send me that:

--- C34/fs/partitions/check.c   Mon Sep  9 20:39:52 2002
+++ /tmp/check.c        Tue Sep 10 09:39:47 2002
@@ -327,7 +327,7 @@
        devfs_auto_unregister(dev->disk_de, slave);
        if (!(dev->flags & GENHD_FL_DEVFS))
                devfs_auto_unregister (slave, dir);
-       for (part = 1, p++; part < max_p; part++, p++)
+       for (part = 1; part < max_p; part++, p++)
                if (p->nr_sects)
                        devfs_register_partition(dev, part);
 #endif

Which I applied, and compiled and magically, I can now boot 2.5.34!!!
He also explained me that it could be because the fs is on the last
partition (which is my case)...

Hope it could be of some helps for other too ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
