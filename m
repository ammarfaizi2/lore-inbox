Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCEVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCEVBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVCETXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:23:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35555 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261163AbVCESof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:44:35 -0500
Message-ID: <4229FDFC.3010501@pobox.com>
Date: Sat, 05 Mar 2005 13:44:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x net driver updates
Content-Type: multipart/mixed;
 boundary="------------080400060202040209030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080400060202040209030506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just sent this to Andrew/Linus.  The patch was too large (500K) to send 
to mailing lists.

--------------080400060202040209030506
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 Documentation/networking/e100.txt |    3 
 arch/arm/mach-pxa/lubbock.c       |    2 
 arch/arm/mach-sa1100/neponset.c   |    2 
 drivers/net/Kconfig               |   17 
 drivers/net/e1000/e1000.h         |    3 
 drivers/net/e1000/e1000_ethtool.c |   11 
 drivers/net/e1000/e1000_hw.c      |   86 
 drivers/net/e1000/e1000_hw.h      |   11 
 drivers/net/e1000/e1000_main.c    |  249 +
 drivers/net/eepro100.c            |    9 
 drivers/net/ixgb/ixgb.h           |    3 
 drivers/net/ixgb/ixgb_ee.c        |   16 
 drivers/net/ixgb/ixgb_ee.h        |    3 
 drivers/net/ixgb/ixgb_ethtool.c   |    5 
 drivers/net/ixgb/ixgb_hw.c        |    2 
 drivers/net/ixgb/ixgb_hw.h        |    2 
 drivers/net/ixgb/ixgb_ids.h       |    2 
 drivers/net/ixgb/ixgb_main.c      |   73 
 drivers/net/ixgb/ixgb_osdep.h     |    2 
 drivers/net/ixgb/ixgb_param.c     |    2 
 drivers/net/smc91x.c              |  275 +
 drivers/net/smc91x.h              |   79 
 drivers/net/tulip/de2104x.c       |    2 
 drivers/net/typhoon-firmware.h    | 5568 +++++++++++++++++---------------------
 drivers/net/typhoon.c             |  244 +
 drivers/net/wan/sbni.c            |    2 
 26 files changed, 3304 insertions(+), 3369 deletions(-)

through these ChangeSets:

<mallikarjuna.chilakala:intel.com>:
  o e1000: Driver version white space,
  o e1000: Fixes related to Cable length
  o e1000: Report failure code when loopback
  o e1000: Checks for desc ring/rx data
  o e1000: Patch from Peter Kjellstroem --
  o e1000: Fix WOL settings in 82544 based
  o e1000: Delay clean-up of last Tx buffer
  o e1000: Avoid race between e1000_watchdog
  o e1000: use netif_poll_{enable|disable}
  o e1000: Robert Olsson's fix and refinement
  o ixgb: Driver version, white space, other stuff
  o ixgb: Invalidate software cache, when EEPROM write occurs
  o ixgb: Robert Olsson's fix and refinement to poll
  o ixgb: Avoid race e1000_watchdog and ixgb_clean_tx_irq
  o ixgb: use netif_poll_{enable|disable}

Alexander Viro:
  o smc91x iomem annotations

David Dillow:
  o Bump version and release date
  o Version 03.001.008 of the Typhoon firmware, courtesy of 3Com
  o Fixup the version reporting to match 3Com
  o Use module_param() and add descriptions
  o Teach typhoon to use port IO on machines that need it. It will attempt to use MMIO, but if that fails (or the user asks), it will fallback to port IO.
  o Enable bus mastering before saving our state, or we'll only be able to load the modules one time.

Ian Campbell:
  o smc91x: power down PHY on suspend
  o use datacs in smc91x driver

Nicolas Pitre:
  o smc91x: allow RX of VLAN packets

Randy Dunlap:
  o tulip/de2104x: don't mix __init & __devinit sections
  o net/wan/sbni: fix section usage

Scott Feldman:
  o eepro100: remove ID for 82556
  o e100: remove reference to NAPI config option

Tony Lindgren:
  o Add OMAP support to smc91x Ethernet driver

Xose Vazquez Perez:
  o 2.6 eepro100: replace and delete duplicate ids


--------------080400060202040209030506--
