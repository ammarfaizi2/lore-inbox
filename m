Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbTFMB6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTFMB6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:58:22 -0400
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:14770 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S265103AbTFMB6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:58:21 -0400
Date: Thu, 12 Jun 2003 22:12:06 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: RTC causes hard lockups in 2.5.70-mm8
Message-ID: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If I set CONFIG_RTC=m and rebuild, when the kernel autoloads rtc.ko the
system immediately locks hard, not responding even to magic SysRq series.
Backing out either of the rtc-* patches from -mm8 does not seem to fix the
problem.

Hardware is a Fujitsu P2120 with Transmeta TM8500 with ALi chipset:
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:02.0 USB Controller: ALi Corporation. [ALi] USB 1.1 Controller (rev 03)
00:04.0 Multimedia audio controller: ALi Corporation. [ALi] M5451 PCI
AC-Link Controller Audio Device (rev 01)
00:06.0 Bridge: ALi Corporation. [ALi] M7101 PMU
00:07.0 ISA bridge: ALi Corporation. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
00:09.0 USB Controller: NEC Corporation USB (rev 41)
00:09.1 USB Controller: NEC Corporation USB (rev 41)
00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
00:0f.0 IDE interface: ALi Corporation. [ALi] M5229 IDE (rev c3)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:12.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset
(rev 01)
00:13.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000
Controller (PHY/Link)
00:14.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6
LY

Any additional information needed I'll be happy to provide.

- --nwf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6TLZR4WVIgmDWjIRAsSNAJ0UZUq/4A4MmQ4DHcl6qnncWcIFDwCfSUYD
mE9xrtTweq57eM95dbs9Tbo=
=iUCG
-----END PGP SIGNATURE-----
