Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136635AbREJN7p>; Thu, 10 May 2001 09:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136664AbREJN7g>; Thu, 10 May 2001 09:59:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136635AbREJN7Q>;
	Thu, 10 May 2001 09:59:16 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: tulip: no link beat, media switching to 10Base2
From: Russell Senior <seniorr@aracnet.com>
Date: 09 May 2001 20:58:45 -0700
In-Reply-To: Jeff Garzik's message of "Wed, 09 May 2001 08:48:34 -0400"
Message-ID: <86wv7p7t3e.fsf_-_@coulee.tdb.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[a repost of a message sent to the tulip bugtracking system on sourceforge]

I am using the tulip driver from vanilla linux-2.4.4, and when I
disconnect the rj45 from the card I get the following message:

eth1: No 21041 10baseT link beat, Media switched to 10base2.

... and it never switches back (until I ifdown/ifup the interface,
which is mighty inconvenient when I am off-site, which is usually).

Here are the bootup messages in 2.4.4:

[...] 
Linux Tulip driver version 0.9.14e (April 20, 2001) 
tulip0: 21041 Media table, default media 0800 (Autosense). 
tulip0: 21041 media #0, 10baseT. 
tulip0: 21041 media #4, 10baseT-FDX. 
tulip0: 21041 media #1, 10base2. 
eth0: Digital DC21041 Tulip rev 17 at 0xf880, 21041 mode, 00:00:C0:D4:74:D6, IRQ 5. 
tulip1: 21041 Media table, default media 0800 (Autosense). 
tulip1: 21041 media #0, 10baseT. 
tulip1: 21041 media #4, 10baseT-FDX. 
tulip1: 21041 media #1, 10base2. 
eth1: Digital DC21041 Tulip rev 17 at 0xf800, 21041 mode, 00:00:C0:6A:7F:D5, IRQ 11. 
[...] 

There are two identical(-ish) cards in the machine (it is acting as a
router), both the same brand anyway (SMC EtherPower PCI). I was able
to hack in 10BaseT stability in a previous kernel (2.4.1) using
TULIP_DEFAULT_MEDIA and TULIP_NO_MEDIA_SWITCH, but I noticed in the
ChangeLog for 2.4.4 that these features were removed. How do I get
reliable 10BaseT operation inspite of possible cabling disconnections.


-- 
Russell Senior         ``The two chiefs turned to each other.        
seniorr@aracnet.com      Bellison uncorked a flood of horrible       
                         profanity, which, translated meant, `This is
                         extremely unusual.' ''                      
