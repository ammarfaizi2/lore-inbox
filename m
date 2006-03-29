Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWC2XAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWC2XAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWC2XAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:00:47 -0500
Received: from havoc.gtf.org ([69.61.125.42]:16834 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751210AbWC2XAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:00:46 -0500
Date: Wed, 29 Mar 2006 18:00:40 -0500
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060329230040.GA23939@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[just sent upstream]

The 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

contains the following updates:

 Documentation/networking/bcm43xx.txt            |   36 
 drivers/net/8390.h                              |    2 
 drivers/net/acenic_firmware.h                   |   10 
 drivers/net/b44.c                               |   14 
 drivers/net/bonding/bond_3ad.c                  |   28 
 drivers/net/bonding/bond_3ad.h                  |    1 
 drivers/net/bonding/bond_main.c                 |   97 
 drivers/net/bonding/bonding.h                   |    4 
 drivers/net/ixp2000/ixpdev.c                    |    5 
 drivers/net/natsemi.c                           |   18 
 drivers/net/pcmcia/axnet_cs.c                   |   61 
 drivers/net/pcnet32.c                           |    4 
 drivers/net/spider_net.c                        |    4 
 drivers/net/via-rhine.c                         |   21 
 drivers/net/wireless/Kconfig                    |    7 
 drivers/net/wireless/Makefile                   |    1 
 drivers/net/wireless/bcm43xx/Kconfig            |   62 
 drivers/net/wireless/bcm43xx/Makefile           |   12 
 drivers/net/wireless/bcm43xx/bcm43xx.h          |  926 +++++
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c  |  499 +++
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h  |  117 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c      |  968 +++++
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |  218 +
 drivers/net/wireless/bcm43xx/bcm43xx_ethtool.c  |   50 
 drivers/net/wireless/bcm43xx/bcm43xx_ethtool.h  |    8 
 drivers/net/wireless/bcm43xx/bcm43xx_ilt.c      |  337 ++
 drivers/net/wireless/bcm43xx/bcm43xx_ilt.h      |   32 
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c     |  293 +
 drivers/net/wireless/bcm43xx/bcm43xx_leds.h     |   56 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     | 3973 ++++++++++++++++++++++++
 drivers/net/wireless/bcm43xx/bcm43xx_main.h     |  168 +
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c      | 2345 ++++++++++++++
 drivers/net/wireless/bcm43xx/bcm43xx_phy.h      |   74 
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c      |  606 +++
 drivers/net/wireless/bcm43xx/bcm43xx_pio.h      |  138 
 drivers/net/wireless/bcm43xx/bcm43xx_power.c    |  358 ++
 drivers/net/wireless/bcm43xx/bcm43xx_power.h    |   47 
 drivers/net/wireless/bcm43xx/bcm43xx_radio.c    | 2026 ++++++++++++
 drivers/net/wireless/bcm43xx/bcm43xx_radio.h    |   99 
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c    |  322 +
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h    |   25 
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c       | 1002 ++++++
 drivers/net/wireless/bcm43xx/bcm43xx_wx.h       |   36 
 drivers/net/wireless/bcm43xx/bcm43xx_xmit.c     |  582 +++
 drivers/net/wireless/bcm43xx/bcm43xx_xmit.h     |  156 
 drivers/net/wireless/hostap/hostap_80211.h      |    2 
 drivers/net/wireless/hostap/hostap_80211_tx.c   |    9 
 drivers/usb/net/zd1201.c                        |    2 
 net/ieee80211/ieee80211_wx.c                    |    4 
 net/ieee80211/softmac/ieee80211softmac_module.c |   17 
 net/ieee80211/softmac/ieee80211softmac_priv.h   |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c     |   12 
 52 files changed, 15820 insertions(+), 76 deletions(-)

Adrian Bunk:
      PCMCIA_SPECTRUM must select FW_LOADER

Arthur Othieno:
      net: remove CONFIG_NET_CBUS conditional for NS8390

Danny van Dyk:
      Sync bcm43xx_phy_initb6() with specs

David Woodhouse:
      softmac: reduce scan dwell time
      softmac: reduce default rate to 11Mbps.

Gary Zambrano:
      b44: fix force mac address before ifconfig up
      b44: ensure valid mac addr

Jay Vosburgh:
      bonding: support carrier state for master

Jean Tourrilhes:
      zd1201 wireless stat update

Jens Osterkamp:
      spidernet : reduce console spam
      spidernet : enable tx checksum offloading by default

John W. Linville:
      wireless: import bcm43xx sources
      bcm43xx: patch Kconfig and wireless/Makefile for import

Jouni Malinen:
      hostap: Make hostap_tx_encrypt() static
      hostap: Fix EAPOL frame encryption

Komuro:
      axnet_cs.c : add hardware multicast support

Larry Finger:
      Minor (janitorial) change to ieee80211

Lennert Buytenhek:
      ixp2000: fix gcc4 breakage

Linas Vepstas:
      Janitor: drivers/net/pcnet32: fix incorrect comments

Mark Brown:
      natsemi: Support oversized EEPROMs

Michael Buesch:
      bcm43xx: sync with svn.berlios.de
      bcm43xx: remove linux version compatibility code.
      bcm43xx: Move README file to Documentation directory.
      bcm43xx: remove redundant COPYING file.
      bcm43xx: add DEBUG Kconfig option. Also fix indention.
      bcm43xx: Fix makefile. Remove all the "out-of-tree" stuff.
      bcm43xx: Add more initvals sanity checks and error out, if one sanity check fails.
      bcm43xx: Remove function bcm43xx_channel_is_allowed()
      bcm43xx: basic ethtool support
      bcm43xx: Wireless Ext update
      bcm43xx: fix txpower reporting in WE.
      bcm43xx: enable SPROM writing.
      bcm43xx: heavily increase mac_suspend timeout.
      bcm43xx: fix compiletime warning (phy_xmitpower)
      bcm43xx: remove WX debugging.
      bcm43xx: Partially fix PIO code. Add Kconfig option for PIO or DMA mode (or both).
      bcm43xx: add a note that not all devices support PIO.
      Apple Airport: Add Kconfig note that the bcm43xx driver has to be used for Airport Extreme cards.
      bcm43xx: update README
      bcm43xx: fix LED code.
      bcm43xx: rewrite and simplify the periodic task handling.
      bcm43xx: Code cleanups. This removes various "inline" statements and reduces codesize.
      bcm43xx: Move sprom lowlevel reading/writing to its own functions.
      bcm43xx: make bcm43xx_sprom_crc() static.
      bcm43xx: split the channel helper functions, so that they can be used without a valid running core.
      bcm43xx: remove old unused struct.
      bcm43xx: Fix Kconfig typo (transfer mode default)
      bcm43xx: Workaround init_board vs IRQ race.
      bcm43xx: move initialized = 1 to the end of init_board.
      bcm43xx: add assert(bcm->initialized) to periodic_tasks_setup().
      bcm43xx: Move TX/RX related functions to its own file. Add basic RTS/CTS code.
      bcm43xx: Add sysfs attributes for device specific tunables.
      bcm43xx: Set both, the DMAmask and the coherent DMAmask.
      bcm43xx: Abstract the locking mechanism.
      bcm43xx: Remove the mmio access printing facility overhead.
      bcm43xx: fix some stuff, add a few missing mmiowb(), remove dead code.
      bcm43xx: receive TX status on MMIO or DMA unconditionally regarding the 80211 core rev.
      bcm43xx: add functions bcm43xx_dma_read/write, bcm43xx_dma_tx_suspend/resume.
      bcm43xx: reduce the size of bcm43xx_private by removing unneeded members.
      bcm43xx: Fix crash on ifdown, by being careful in pio/dma freeing.
      bcm43xx: Remove the workaround in dummy_transmission,
      bcm43xx: Do boardflags workarounds for specific boards.
      bcm43xx: properly mask txctl1 before writing it to hardware.
      bcm43xx: remove check for mmio length, as it differs among platforms. (especially embedded)
      bcm43xx: fix some gpio register trashing (hopefully :D)
      bcm43xx: merge all iwmode code into the set_iwmode function.
      bcm43xx: some IRQ handler cleanups.
      bcm43xx: set default attenuation values.
      bcm43xx: sync interference mitigation code to the specs.
      bcm43xx: fix nrssi_threshold calculation.
      bcm43xx: add useless and broken statistics stuff. People seem to want it. well...
      bcm43xx: get rid of "/* vim: ..." lines at the end of several files.
      bcm43xx: fix "include" issues on some platforms.
      bcm43xx: remove some compilerwarnings.
      bcm43xx: fix the remaining sparse warnings.
      bcm43xx: sync GPHY init with the specs.
      bcm43xx: don't set the channel on a device, which is down.

Pete Zaitcev:
      bcm43xx: fix DMA TX skb freeing in case of fragmented packets.

Randy Dunlap:
      acenic: fix section mismatches

Roger Luethi:
      via-rhine: link state fix

