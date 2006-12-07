Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032101AbWLGMOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032101AbWLGMOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032100AbWLGMOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:14:23 -0500
Received: from havoc.gtf.org ([69.61.125.42]:59493 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032098AbWLGMOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:14:22 -0500
Date: Thu, 7 Dec 2006 07:14:21 -0500
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver updates
Message-ID: <20061207121421.GA5627@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just sent this upstream]

Random schtuff.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/3c501.c                            |    2 
 drivers/net/3c503.c                            |    2 
 drivers/net/3c505.c                            |    2 
 drivers/net/3c507.c                            |    2 
 drivers/net/3c523.c                            |    2 
 drivers/net/3c527.c                            |    2 
 drivers/net/ac3200.c                           |    2 
 drivers/net/apne.c                             |    4 
 drivers/net/appletalk/cops.c                   |    2 
 drivers/net/arm/at91_ether.c                   |   88 ++--
 drivers/net/arm/at91_ether.h                   |    1 
 drivers/net/arm/ether1.c                       |    6 
 drivers/net/arm/ether3.c                       |    8 
 drivers/net/at1700.c                           |    2 
 drivers/net/atarilance.c                       |    4 
 drivers/net/bonding/bond_main.c                |    2 
 drivers/net/cs89x0.c                           |    2 
 drivers/net/declance.c                         |  404 ++++++++++----------
 drivers/net/e2100.c                            |    2 
 drivers/net/eepro.c                            |    2 
 drivers/net/eexpress.c                         |    2 
 drivers/net/es3210.c                           |    2 
 drivers/net/eth16i.c                           |    2 
 drivers/net/hp-plus.c                          |    2 
 drivers/net/hp.c                               |    2 
 drivers/net/lance.c                            |    2 
 drivers/net/lne390.c                           |    2 
 drivers/net/mv643xx_eth.c                      |    4 
 drivers/net/mvme147.c                          |    4 
 drivers/net/myri10ge/myri10ge.c                |   95 +++--
 drivers/net/myri10ge/myri10ge_mcp.h            |   56 +--
 drivers/net/myri10ge/myri10ge_mcp_gen_header.h |    2 
 drivers/net/ne.c                               |    2 
 drivers/net/ne2.c                              |    2 
 drivers/net/netxen/netxen_nic.h                |  331 ++++++++++++----
 drivers/net/netxen/netxen_nic_ethtool.c        |   65 ++-
 drivers/net/netxen/netxen_nic_hdr.h            |    6 
 drivers/net/netxen/netxen_nic_hw.c             |  483 +++++++++++++++++++-----
 drivers/net/netxen/netxen_nic_hw.h             |   10 
 drivers/net/netxen/netxen_nic_init.c           |  361 ++++++++++++++----
 drivers/net/netxen/netxen_nic_ioctl.h          |    8 
 drivers/net/netxen/netxen_nic_isr.c            |   51 +--
 drivers/net/netxen/netxen_nic_main.c           |  306 +++++++++------
 drivers/net/netxen/netxen_nic_niu.c            |   32 +-
 drivers/net/netxen/netxen_nic_phan_reg.h       |  228 +++++++----
 drivers/net/ni52.c                             |    2 
 drivers/net/ni65.c                             |    2 
 drivers/net/ns83820.c                          |   25 +
 drivers/net/r8169.c                            |   84 +++-
 drivers/net/seeq8005.c                         |    2 
 drivers/net/sk98lin/skgesirq.c                 |    2 
 drivers/net/skge.h                             |  150 ++++---
 drivers/net/sky2.c                             |  117 +++---
 drivers/net/sky2.h                             |   54 +--
 drivers/net/smc-ultra.c                        |    2 
 drivers/net/smc-ultra32.c                      |    2 
 drivers/net/smc9194.c                          |    2 
 drivers/net/smc91x.h                           |   24 +
 drivers/net/sun3lance.c                        |    4 
 drivers/net/tokenring/smctr.c                  |    2 
 drivers/net/wd.c                               |    2 
 drivers/net/wireless/hostap/hostap_ap.c        |    4 
 drivers/net/wireless/hostap/hostap_cs.c        |    3 
 drivers/net/wireless/hostap/hostap_download.c  |    4 
 drivers/net/wireless/hostap/hostap_hw.c        |   12 -
 drivers/net/wireless/hostap/hostap_info.c      |    3 
 drivers/net/wireless/hostap/hostap_ioctl.c     |   12 -
 drivers/net/wireless/hostap/hostap_pci.c       |    3 
 drivers/net/wireless/hostap/hostap_plx.c       |    3 
 drivers/net/wireless/ipw2100.c                 |    2 
 drivers/net/wireless/ipw2200.c                 |   24 +
 drivers/net/wireless/prism54/isl_ioctl.c       |    9 
 drivers/net/wireless/prism54/oid_mgt.c         |    4 
 drivers/net/wireless/zd1211rw/zd_chip.c        |   13 +
 drivers/net/wireless/zd1211rw/zd_chip.h        |   43 ++
 drivers/net/wireless/zd1211rw/zd_mac.c         |   53 ++-
 drivers/net/wireless/zd1211rw/zd_mac.h         |    3 
 drivers/net/wireless/zd1211rw/zd_netdev.c      |    2 
 net/ieee80211/softmac/ieee80211softmac_assoc.c |   14 +
 net/ieee80211/softmac/ieee80211softmac_auth.c  |    2 
 net/ieee80211/softmac/ieee80211softmac_priv.h  |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c    |    3 
 82 files changed, 2115 insertions(+), 1180 deletions(-)

Al Viro:
      __iomem annotations: smc91x
      mv643xx_eth.c NULL noise removal
      trivial missing __init in drivers/net/*
      drivers/net/arm missing __devinit
      myri10ge annotations
      ns83820 annotations

Amit S. Kale:
      NetXen: whitespace cleaup and more cleanup fixes
      NetXen: multiport firmware support, ioctl interface

Andrew Victor:
      AT91RM9200 Ethernet: Remove 'at91_dev' and use netdev_priv()
      AT91RM9200 Ethernet: Move check_timer variable and use mod_timer()
      AT91RM9200 Ethernet: Add netpoll / netconsole support
      AT91RM9200 Ethernet: Use dev_alloc_skb()

Andy Gospodarek:
      bonding: incorrect bonding state reported via ioctl

Brice Goglin:
      myri10ge: write as 2 32-byte blocks in myri10ge_submit_8rx

Daniel Drake:
      zd1211rw: zd_mac_rx isn't always called in IRQ context
      zd1211rw: Fill enc_capa in GIWRANGE handler

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Francois Romieu:
      r8169: more magic during initialization of the hardware
      r8169: tweak the PCI data parity error recovery
      r8169: phy program update
      r8169: more alignment for the 0x8168

Jeff Garzik:
      [netdrvr] netxen: workqueue-related build fixes
      [wireless] zd1211rw: workqueue-related build fixes

Maciej W. Rozycki:
      declance: Fix PMAX and PMAD support
      declance: Support the I/O ASIC LANCE w/o TURBOchannel

Mariusz Kozlowski:
      sk98lin debug build fix
      net: smc91x add missing bracket

Maxime Austruy:
      softmac: fix unbalanced mutex_lock/unlock in ieee80211softmac_wx_set_mlme

Stephen Hemminger:
      sky2: add PCI for 88ec033
      sky2: add comments to PCI ids
      sky2: beter ram buffer partitioning
      sky2: receive queue watermark tweak
      skge: fix sparse warnings
      sky2: sparse warnings

Ulrich Kunitz:
      zd1211rw: Support for multicast addresses
      softmac: Fixed handling of deassociation from AP

Yan Burman:
      hostap: replace kmalloc+memset with kzalloc
      prism54: replace kmalloc+memset with kzalloc
      ipw2200: replace kmalloc+memset with kcalloc

Zhu Yi:
      ipw2200: Add IEEE80211_RADIOTAP_TSFT for promiscuous mode
      ipw2200: Update version stamp to 1.2.0
      ipw2200: Fix a typo
      ipw2200: Fix debug output endian issue

