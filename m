Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUA3SWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUA3SWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:22:37 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:62864 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S263166AbUA3SW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:22:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: lspci & idebus=xx confusion
Date: Fri, 30 Jan 2004 13:22:28 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401301322.28228.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.53.166] at Fri, 30 Jan 2004 12:22:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

In an lspci -vv, all devices have a Cap and 66 in the report,
but some show it s a + and some show it as a -, like this:
---
[root@coyote root]# lspci -vv|grep 66Mhz
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
---
So I set the option "idebus=66" on the grub command line and rebooted.
But eventually it reports in dmesg:
---
VP_IDE: User given PCI clock speed impossible (66000), using 33 MHz instead.
VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
--
that its resetting the speed back to 33mhz.  The boot process seemed
to be faster till then.  I'm going to try the ide0=ata66 and ide1=ata66
next.

I've read the lspci manpage, and the kernel-parameters.txt without
getting any real insight re this.

Can someone explain what the + an - signs in the lspci output are
really telling me?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
