Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766655AbWJUSij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766655AbWJUSij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766653AbWJUSij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:38:39 -0400
Received: from havoc.gtf.org ([69.61.125.42]:15306 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1766641AbWJUSii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:38:38 -0400
Date: Sat, 21 Oct 2006 14:38:34 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061021183834.GA27990@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent this upstream]

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/Kconfig                             |    2 
 drivers/net/e1000/e1000_main.c                  |    4 
 drivers/net/ibmveth.c                           |   10 
 drivers/net/ioc3-eth.c                          |    4 
 drivers/net/r8169.c                             |    7 
 drivers/net/sb1250-mac.c                        |    2 
 drivers/net/sky2.c                              |   33 -
 drivers/net/smc91x.h                            |   18 +
 drivers/net/ucc_geth.c                          |  633 ++++++++++++-----------
 drivers/net/ucc_geth.h                          |  248 ++++-----
 drivers/net/ucc_geth_phy.c                      |   26 -
 drivers/net/ucc_geth_phy.h                      |    2 
 drivers/net/wan/pc300_drv.c                     |   24 +
 drivers/net/wireless/airo.c                     |  105 +++-
 drivers/net/wireless/atmel.c                    |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c      |   28 +
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |   17 +
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c     |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |   34 -
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c       |    2 
 drivers/net/wireless/orinoco.c                  |   16 -
 drivers/net/wireless/ray_cs.c                   |    1 
 drivers/net/wireless/zd1201.c                   |    6 
 drivers/net/wireless/zd1211rw/zd_mac.c          |    2 
 include/net/ieee80211softmac.h                  |   35 +
 net/core/wireless.c                             |   33 +
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   56 +-
 net/ieee80211/softmac/ieee80211softmac_io.c     |   11 
 net/ieee80211/softmac/ieee80211softmac_module.c |    1 
 net/ieee80211/softmac/ieee80211softmac_wx.c     |   71 ++-
 30 files changed, 809 insertions(+), 626 deletions(-)

Andrew Morton:
      r8169: PCI ID for Corega Gigabit network card

Arnaud Patard:
      r8169: fix infinite loop during hotplug

Dave Jones:
      Remove useless comment from sb1250

Dave Kleikamp:
      airo: check if need to freeze

David Gibson:
      ibmveth: Fix index increment calculation

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Eric Sesterhenn:
      zd1201: Possible NULL dereference

Florin Malita:
      airo.c: check returned values

Jean Tourrilhes:
      orinoco: fix WE-21 buffer overflow
      wireless: More WE-21 potential overflows...

Jeff Garzik:
      WAN/pc300: handle, propagate minor errors

John W. Linville:
      zd1211rw: fix build-break caused by association race fix
      wireless: WE-20 compatibility for ESSID and NICKN ioctls

Larry Finger:
      bcm43xx-softmac: check returned value from pci_enable_device
      bcm43xx-softmac: Fix system hang for x86-64 with >1GB RAM

Laurent Riffard:
      sotftmac: fix a slab corruption in WEP restricted key association

Li Yang:
      ucc_geth: changes to ucc_geth driver as a result of qe_lib changes and bugfixes

Linas Vepstas:
      e1000: Reset all functions after a PCI error

Michael Buesch:
      bcm43xx: fix race condition in periodic work handler
      softmac: Fix WX and association related races

Ralf Baechle:
      Fix timer race

Stephen Hemminger:
      sky2: 88E803X transmit lockup

