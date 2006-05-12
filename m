Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWELKYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWELKYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWELKYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:24:25 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:43682 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751142AbWELKYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:24:24 -0400
Date: Fri, 12 May 2006 12:24:23 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Linux v2.6.17-rc4
Message-ID: <20060512102422.GA30285@harddisk-recovery.com>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 04:44:03PM -0700, Linus Torvalds wrote:
> Ok, I've let the release time between -rc's slide a bit too much again, 
> but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> 
> If you know of any regressions, please holler now, so that we don't miss 
> them. 

I got assertion failures in the bcm43xx driver:

bcm43xx: Chip ID 0x4318, rev 0x2
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0xd, vendor 0x4243, enabled
bcm43xx: Core 1: ID 0x812, rev 0x9, vendor 0x4243, disabled
bcm43xx: Core 2: ID 0x804, rev 0xc, vendor 0x4243, enabled
bcm43xx: Core 3: ID 0x80d, rev 0x7, vendor 0x4243, enabled
bcm43xx: PHY connected
bcm43xx: Detected PHY: Version: 3, Type 2, Revision 7
bcm43xx: Detected Radio: ID: 8205017f (Manuf: 17f Ver: 2050 Rev: 8)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
bcm43xx: PHY connected
bcm43xx: Radio turned on
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1485:bcm43xx_find_lopair()
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1485:bcm43xx_find_lopair()
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1485:bcm43xx_find_lopair()
bcm43xx: Chip initialized
bcm43xx: DMA initialized
bcm43xx: 80211 cores initialized
bcm43xx: Keys cleared
ADDRCONF(NETDEV_UP): eth2: link is not ready
bcm43xx: ASSERTION FAILED (radio_attenuation < 10) at: drivers/net/wireless/bcm43xx/bcm43xx_phy.c:1485:bcm43xx_find_lopair()
ieee80211_crypt: registered algorithm 'WEP'


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
