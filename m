Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWANR00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWANR00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWANR00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:26:26 -0500
Received: from ip-205-196-208-25.dreamhost.com ([205.196.208.25]:13469 "EHLO
	hannibal.dreamhost.com") by vger.kernel.org with ESMTP
	id S1750706AbWANR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:26:25 -0500
From: Matthew Marshall <matthew@matthewmarshall.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PCI WiFi card works with livecd's but not with HD install with Ali mobo.
Date: Sat, 14 Jan 2006 14:27:36 -0300
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601141427.36915.matthew@matthewmarshall.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems using a DWL-G510 PCI 802.11g card (Atheros chipset) with 
my ASROCK 939Dual-SATA2.  The really strange thing is that it works perfectly 
fine with every live-cd I have tried, but always fails from a hd install.

The problem is that, instead of flashing, one of the lights on the card is 
held constant, while the other remains off.  This happens with both 
ndiswrapper and madwifi.  Both of these drivers work fine without a hitch in 
both knoppix and slax.

This seems to be a bug with the driver for the southbridge (ULi M1567) as I 
had the card working fine with another mobo (with the same distro.)

Here is my hardware setup:
ASROCK 939Dual-SATA2 (with ULi M1567 southbridge)
AMD64 3000+  (running in 32 bit mode)
ATI Radeon 9200 AGP  (probably not relevent)
DWL-G510 PCI 802.11g
Lite-On DVD Burner (on Primary IDE)
Seagate Barracuda 7200RPM 80GB (on SATA; possibly problematic?)

I am currently running kernel 2.6.15.  However, I have also tried a number of 
other versions, including the -mm tree, and using the kernel and modules from 
the Slax livecd.  There wasn't any difference.  pci=routeirq and noacip 
doesn't seem to change anything either.

dmesg output (with autoloading ath_pci):
http://pastebin.com/505478

lspci -v output:
http://pastebin.com/505481

Some more observations:
ath_pci (madwifi) loads and unloads without reporting any errors.  However 
modprobe ndiswrapper shows the following in dmesg:
http://pastebin.com/505525
modprobe -r ndiswraper segfaults.

I would really appreciate some help here.  Please let me know if there is 
anything more I can do.  It seems that using a new/uncommon/weird chipset 
like this is almost begging for trouble :D

Thanks for reading,
	Matthew Marshall
