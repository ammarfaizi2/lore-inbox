Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbUCZEXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbUCZEXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:23:49 -0500
Received: from 220-244-186-86-qld.tpgi.com.au ([220.244.186.86]:58151 "EHLO
	dawn.private.network") by vger.kernel.org with ESMTP
	id S263888AbUCZEXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:23:37 -0500
Subject: Re: RadeonFB
From: Oystein Haare <lkml-account@mazdaracing.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stewart Smith <stewart@flamingspork.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1080254335.1195.37.camel@gaston>
References: <1079366460.853.3.camel@dawn>  <1080187819.2763.1.camel@kennedy>
	 <1080254335.1195.37.camel@gaston>
Content-Type: multipart/mixed; boundary="=-Ck6tDqafsKezR4RIGe+K"
Message-Id: <1080274786.1791.1.camel@dawn.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:19:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ck6tDqafsKezR4RIGe+K
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-03-26 at 08:38, Benjamin Herrenschmidt wrote:
> > > This is what it outputs:
> > > 
> > > radeonfb: Found Intel x86 BIOS ROM Image
> > > radeonfb: Retreived PLL infos from BIOS
> > > radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
> > > System=220.00 MHz
> > > Non-DDC laptop panel detected
> > > radeonfb: Monitor 1 type LCD found
> > > radeonfb: Monitor 2 type no found
> > > radeonfb: panel ID string: Samsung LTN150P1-L02    
> > > radeonfb: detected LVDS panel size from BIOS: 1400x1050
> > > radeondb: BIOS provided dividers will be used
> > > radeonfb: Assuming panel size 1400x1050
> > > radeonfb: Power Management enabled for Mobility chipsets
> > > radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> > > 
> > > Could the flickering have something to do with the fact that the lcd
> > > panel on my laptop can only do 1280x800 resolution? Or doesn't the
> > > 1400x1050 have anything to do with resolution at all?
> > >
> 
> That's weird. Yet another case of BIOS lying about the panel
> size. Can you try enabling DDC I2C probing ?
> 
> Ben.

Yes, didn't help.
Enabled debug output as well. Relevant dmesg output attached.

Oystein


--=-Ck6tDqafsKezR4RIGe+K
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=
Content-Transfer-Encoding: 7bit

radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=220.00 MHz
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = c
post_divider = 1
fbk_divider = 60
Scanning BIOS table ...
 18 x 19689
 8236 x 21569
 30240 x 12598
 0 x 0
 21065 x 4098
 0 x 0
 45 x 8237
 2 x 20484
 0 x 644
 41217 x 62890
 16832 x 65535
 64511 x 65535
 13312 x 65376
 0 x 256
 1845 x 7
 35584 x 4096
 254 x 20353
 1280 x 101
Didn't find panel in BIOS table !
Guessing panel info...
radeonfb: Assuming panel size 1400x1050
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
radeonfb_pci_register END
ikconfig 0.7 with /proc/config*
hStart = 1440, hEnd = 1552, hTotal = 1688
vStart = 1051, vEnd = 1054, vTotal = 1067
h_total_disp = 0xae00d2	   hsync_strt_wid = 0x8e059a
v_total_disp = 0x419042a	   vsync_strt_wid = 0x83041a
pixclock = 9259
freq = 10800
lvds_gen_cntl: 003dffa1
Console: switching to colour frame buffer device 175x65

--=-Ck6tDqafsKezR4RIGe+K--

