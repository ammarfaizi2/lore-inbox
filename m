Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWEXHGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWEXHGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWEXHGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:06:47 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47247 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932632AbWEXHGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:06:46 -0400
Date: Wed, 24 May 2006 03:06:45 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: What's in netdev-2.6.git
Message-ID: <20060524070645.GA11392@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 'upstream' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

contains the following updates (queued for 2.6.18):

 Documentation/networking/README.ipw2200         |   10 
 MAINTAINERS                                     |    6 
 drivers/net/Kconfig                             |   33 
 drivers/net/Makefile                            |    2 
 drivers/net/au1000_eth.c                        |  206 -
 drivers/net/cassini.c                           |    9 
 drivers/net/e1000/Makefile                      |    3 
 drivers/net/e1000/e1000.h                       |    6 
 drivers/net/e1000/e1000_ethtool.c               |   47 
 drivers/net/e1000/e1000_hw.c                    |  115 
 drivers/net/e1000/e1000_hw.h                    |    7 
 drivers/net/e1000/e1000_main.c                  |  271 --
 drivers/net/e1000/e1000_osdep.h                 |    3 
 drivers/net/e1000/e1000_param.c                 |    3 
 drivers/net/ibmlana.c                           |   20 
 drivers/net/ibmlana.h                           |    6 
 drivers/net/ibmveth.c                           |  291 +-
 drivers/net/ibmveth.h                           |   11 
 drivers/net/ixgb/ixgb.h                         |    9 
 drivers/net/ixgb/ixgb_ethtool.c                 |   55 
 drivers/net/ixgb/ixgb_hw.h                      |    1 
 drivers/net/ixgb/ixgb_ids.h                     |    4 
 drivers/net/ixgb/ixgb_main.c                    |  132 -
 drivers/net/ixgb/ixgb_param.c                   |   24 
 drivers/net/myri10ge/Makefile                   |    5 
 drivers/net/myri10ge/myri10ge.c                 | 2851 ++++++++++++++++++++++++
 drivers/net/myri10ge/myri10ge_mcp.h             |  205 +
 drivers/net/myri10ge/myri10ge_mcp_gen_header.h  |   58 
 drivers/net/pcmcia/pcnet_cs.c                   |   42 
 drivers/net/phy/Kconfig                         |    6 
 drivers/net/phy/Makefile                        |    1 
 drivers/net/phy/smsc.c                          |  101 
 drivers/net/s2io-regs.h                         |   32 
 drivers/net/s2io.c                              | 1476 +++++++++---
 drivers/net/s2io.h                              |   59 
 drivers/net/sis900.c                            |   26 
 drivers/net/sis900.h                            |   10 
 drivers/net/sky2.c                              |   19 
 drivers/net/smc911x.c                           | 2307 +++++++++++++++++++
 drivers/net/smc911x.h                           |  835 +++++++
 drivers/net/smc91x.h                            |   18 
 drivers/net/wan/pci200syn.c                     |   27 
 drivers/net/wireless/Kconfig                    |   30 
 drivers/net/wireless/airo.c                     |  271 +-
 drivers/net/wireless/bcm43xx/bcm43xx.h          |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c  |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |   35 
 drivers/net/wireless/hermes.c                   |   66 
 drivers/net/wireless/hermes.h                   |   43 
 drivers/net/wireless/hostap/hostap_80211_tx.c   |    1 
 drivers/net/wireless/hostap/hostap_ap.c         |   11 
 drivers/net/wireless/hostap/hostap_cs.c         |    6 
 drivers/net/wireless/hostap/hostap_main.c       |    2 
 drivers/net/wireless/ipw2200.c                  |  849 ++++++-
 drivers/net/wireless/ipw2200.h                  |   83 
 drivers/net/wireless/orinoco.c                  |  251 --
 drivers/net/wireless/orinoco.h                  |   19 
 drivers/net/wireless/orinoco_cs.c               |   42 
 drivers/net/wireless/orinoco_nortel.c           |  171 -
 drivers/net/wireless/orinoco_pci.c              |  210 -
 drivers/net/wireless/orinoco_pci.h              |  104 
 drivers/net/wireless/orinoco_plx.c              |  223 -
 drivers/net/wireless/orinoco_tmd.c              |   99 
 drivers/net/wireless/spectrum_cs.c              |   81 
 drivers/pci/pci.c                               |    3 
 drivers/s390/net/Makefile                       |    3 
 drivers/s390/net/ctcmain.c                      |   45 
 drivers/s390/net/ctcmain.h                      |   12 
 drivers/s390/net/ctctty.c                       | 1259 ----------
 drivers/s390/net/ctctty.h                       |   35 
 include/linux/pci.h                             |    2 
 include/linux/pci_ids.h                         |    2 
 include/net/ieee80211.h                         |    6 
 include/net/ieee80211softmac.h                  |   38 
 include/net/ieee80211softmac_wx.h               |    5 
 net/ieee80211/ieee80211_crypt_tkip.c            |   11 
 net/ieee80211/ieee80211_rx.c                    |   18 
 net/ieee80211/ieee80211_tx.c                    |   63 
 net/ieee80211/ieee80211_wx.c                    |   44 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   74 
 net/ieee80211/softmac/ieee80211softmac_auth.c   |    3 
 net/ieee80211/softmac/ieee80211softmac_event.c  |   25 
 net/ieee80211/softmac/ieee80211softmac_module.c |  117 
 net/ieee80211/softmac/ieee80211softmac_priv.h   |    5 
 net/ieee80211/softmac/ieee80211softmac_wx.c     |   36 
 85 files changed, 10278 insertions(+), 3480 deletions(-)

Adrian Bunk:
      ieee80211_wx.c: remove dead code
      drivers/net/s2io.c: make bus_speed[] static

Ananda Raju:
      s2io: performance improvements
      s2io: input parms, output messages update
      s2io: fixes
      s2io: additional stats
      s2io: init/shutdown fixes

Arjan van de Ven:
      unused exports in wireless drivers

Auke Kok:
      e1000: Remove PM warning DPRINTKs breaking 2.4.x kernels
      e1000: Esb2 wol link cycle bug and uninitialized registers
      e1000: De-inline functions to benefit from compiler smartness
      e1000: Made an adapter struct variable into a local (txb2b)
      e1000: Update truesize with the length of the packet for packet split
      e1000: Dead variable cleanup
      e1000: Buffer optimizations for small MTU
      e1000: implement more efficient tx queue locking
      e1000: Version bump, contact fix, year string change
      {e100{,0},ixgb}: Add Auke Kok as new patch maintainer for e{100,1000} and ixgb
      e1000: fix mispatch for media type detect.
      e1000: fix mismerge skb_put.
      ixgb: fix rare early tso completion
      ixgb: remove duplicate code setting duplex and speed
      ixgb: fix flow control
      ixgb: add NETIF_F_LLTX analogous to e1000
      ixgb: add copper 10gig driver id
      ixgb: remove hardcoded number
      ixgb: use DPRINTK and msglvl, and ethtool to control it
      ixgb: add tx timeout counter
      ixgb: increment version to 1.0.104-k2
      e1000: add shutdown handler back to fix WOL
      e1000: remove backslash r debug printfs
      e1000: remove leading and trailing whitespace.
      e1000: Fix date string in Makefile
      e1000: remove changelog in driver
      e1000: bump version to 7.0.38-k4

Brice Goglin:
      Revive pci_find_ext_capability
      Add Myri-10G Ethernet driver

Dan Williams:
      wireless/airo: minimal WPA awareness

Daniel Drake:
      softmac: deauthentication implies deassociation
      softmac: suggest per-frame-type TX rate

Daniele Venzano:
      Add VLAN (802.1q) support to sis900 driver

Dustin McIntire:
      RE: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of ethernet chips

Florin Malita:
      orinoco: possible null pointer dereference in orinoco_rx_monitor()

Frank Pavlic:
      s390: remove tty support from ctc network device driver [1/2]
      s390: remove tty support from ctc network device driver [2/2]

Herbert Valerio Riedel:
      phy: new SMSC LAN83C185 PHY driver

Jeff Garzik:
      [netdrvr smc911x] trim trailing whitespace
      [netdrvr pcnet_cs, myri] trim trailing whitespace
      [netdrvr ibmlana, ibmveth] trim trailing whitespace

Jiri Benc:
      orinoco: fix BAP0 offset error after several days of operation

Johannes Berg:
      sungem: Marvell PHY suspend
      softmac: add SIOCSIWMLME
      softmac: clean up event handling code

Krzysztof Halasa:
      Goramo PCI200SYN WAN driver subsystem ID patch

Lennert Buytenhek:
      smc91x: add support for LogicPD PXA270 platform

Marc Zyngier:
      netdrvr: Convert cassini to pci_iomap

Marcin Juszkiewicz:
      hostap: new pcmcia IDs
      pcnet_cs: Add TRENDnet TE-CF100 ethernet adapter ID

Michael Buesch:
      bcm43xx: use pci_iomap() for convenience.

Michal Schmidt:
      wireless/airo: minimal WPA awareness

Pavel Roskin:
      orinoco: Remove useless CIS validation
      orinoco: remove PCMCIA audio support, it's useless for wireless cards
      orinoco: remove underscores from little-endian field names
      orinoco: remove tracing code, it's unused
      orinoco: remove debug buffer code and userspace include support
      orinoco: Symbol card supported by spectrum_cs is LA4137, not LA4100
      orinoco: optimize Tx exception handling in orinoco
      orinoco: orinoco_xmit() should only return valid symbolic constants
      orinoco replace hermes_write_words() with hermes_write_bytes()
      orinoco: don't use any padding for Tx frames
      orinoco: refactor and clean up Tx error handling
      orinoco: simplify 802.3 encapsulation code
      orinoco: delay FID allocation after firmware initialization
      orinoco_pci: disable device and free IRQ when suspending
      orinoco_pci: use pci_iomap() for resources
      orinoco: support PCI suspend/resume for Nortel, PLX and TMD adaptors
      orinoco: reduce differences between PCI drivers, create orinoco_pci.h
      orinoco: further comment cleanup in the PCI drivers
      orinoco: bump version to 0.15
      orinoco: unregister network device before releasing PCMCIA resources
      orinoco: report more relevant data on startup
      orinoco: simplify locking, fix error handling in PCMCIA resume
      orinoco: eliminate the suspend/resume functions if CONFIG_PM is unset
      orinoco: don't put PCI resource data to the network device

Santiago Leon:
      ibmveth change buffer pools dynamically

Sergei Shtylyov:
      au1000_eth.c probe code straightened up

Stefano Brivio:
      bcm43xx: fix whitespace
      bcm43xx: add PCI ID for bcm4319

Stephen Hemminger:
      sky2: fix jumbo packet support

Zhu Yi:
      ieee80211: Fix TKIP MIC calculation for QoS frames
      ieee80211: Fix TX code doesn't enable QoS when using WPA + QoS
      ieee80211: export list of bit rates with standard WEXT procddures
      ieee80211: remove unnecessary CONFIG_WIRELESS_EXT checking
      ieee80211: replace debug IEEE80211_WARNING with each own debug macro
      ieee80211: update version stamp to 1.1.13
      ipw2200: Exponential averaging for signal and noise Level
      ipw2200: Fix TX QoS enabled frames problem
      ipw2200: generates a scan event after a scan has completed
      ipw2200: add module_param support for antenna selection
      ipw2200: fix compile warning when !CONFIG_IPW2200_DEBUG
      ipw2200: Do not continue loading the firmware if kmalloc fails
      ipw2200: turn off signal debug log
      ipw2200: Set the 'fixed' flags in wext get_rate
      ipw2200: Fix endian issues with v3.0 fw image format
      README.ipw2200: rename CONFIG_IPW_DEBUG to CONFIG_IPW2200_DEBUG
      ipw2200: Enable rtap interface for RF promiscuous mode while associated
      ipw2200: version string rework
      ipw2200: update version stamp to 1.1.2
      ipw2200: rename CONFIG_IPW_QOS to CONFIG_IPW2200_QOS
      wireless Kconfig add IPW2200_RADIOTAP
      ipw2200: rename CONFIG_IEEE80211_RADIOTAP to CONFIG_IPW2200_RADIOTAP
      ipw2200: remove priv->last_noise reference
      ipw2200: Fix wpa_supplicant association problem

