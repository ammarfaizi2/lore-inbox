Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWGESSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWGESSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWGESSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:18:32 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58514 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964962AbWGESSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:18:31 -0400
Date: Wed, 5 Jul 2006 14:18:30 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060705181830.GA14005@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just sent this to Andrew/Linus...

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 MAINTAINERS                                    |    7 
 drivers/net/8139cp.c                           |   35 
 drivers/net/8139too.c                          |   34 
 drivers/net/b44.c                              |   27 
 drivers/net/bnx2.c                             |   30 
 drivers/net/cassini.c                          |   25 
 drivers/net/declance.c                         |    7 
 drivers/net/dl2k.c                             |   43 
 drivers/net/eepro100.c                         |    6 
 drivers/net/epic100.c                          |   93 -
 drivers/net/fealnx.c                           |   36 
 drivers/net/gt96100eth.c                       |    3 
 drivers/net/gt96100eth.h                       |    2 
 drivers/net/hamachi.c                          |   16 
 drivers/net/myri10ge/myri10ge.c                |   17 
 drivers/net/natsemi.c                          |  117 -
 drivers/net/ne2k-pci.c                         |    9 
 drivers/net/ni5010.c                           |   52 
 drivers/net/ns83820.c                          |   41 
 drivers/net/pci-skeleton.c                     |   19 
 drivers/net/pcnet32.c                          |  520 +++++---
 drivers/net/phy/cicada.c                       |   42 
 drivers/net/r8169.c                            |   40 
 drivers/net/starfire.c                         |  123 -
 drivers/net/sundance.c                         |  106 -
 drivers/net/tulip/winbond-840.c                |   29 
 drivers/net/tulip/xircom_tulip_cb.c            |   27 
 drivers/net/via-rhine.c                        |  121 -
 drivers/net/via-velocity.c                     |  102 -
 drivers/net/via-velocity.h                     |    4 
 drivers/net/wan/Kconfig                        |   12 
 drivers/net/wan/Makefile                       |    1 
 drivers/net/wireless/Kconfig                   |    1 
 drivers/net/wireless/Makefile                  |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c    |   31 
 drivers/net/wireless/bcm43xx/bcm43xx_main.h    |   24 
 drivers/net/wireless/bcm43xx/bcm43xx_radio.c   |    7 
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c      |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_xmit.c    |    5 
 drivers/net/wireless/hostap/hostap_plx.c       |    2 
 drivers/net/wireless/zd1211rw/Kconfig          |   19 
 drivers/net/wireless/zd1211rw/Makefile         |   11 
 drivers/net/wireless/zd1211rw/zd_chip.c        | 1615 +++++++++++++++++++++++++
 drivers/net/wireless/zd1211rw/zd_chip.h        |  825 ++++++++++++
 drivers/net/wireless/zd1211rw/zd_def.h         |   48 
 drivers/net/wireless/zd1211rw/zd_ieee80211.c   |  191 ++
 drivers/net/wireless/zd1211rw/zd_ieee80211.h   |   85 +
 drivers/net/wireless/zd1211rw/zd_mac.c         | 1057 ++++++++++++++++
 drivers/net/wireless/zd1211rw/zd_mac.h         |  190 ++
 drivers/net/wireless/zd1211rw/zd_netdev.c      |  267 ++++
 drivers/net/wireless/zd1211rw/zd_netdev.h      |   45 
 drivers/net/wireless/zd1211rw/zd_rf.c          |  151 ++
 drivers/net/wireless/zd1211rw/zd_rf.h          |   82 +
 drivers/net/wireless/zd1211rw/zd_rf_al2230.c   |  308 ++++
 drivers/net/wireless/zd1211rw/zd_rf_rf2959.c   |  279 ++++
 drivers/net/wireless/zd1211rw/zd_types.h       |   71 +
 drivers/net/wireless/zd1211rw/zd_usb.c         | 1316 ++++++++++++++++++++
 drivers/net/wireless/zd1211rw/zd_usb.h         |  240 +++
 drivers/net/wireless/zd1211rw/zd_util.c        |   82 +
 drivers/net/wireless/zd1211rw/zd_util.h        |   29 
 drivers/net/yellowfin.c                        |   39 
 include/net/ieee80211softmac.h                 |    1 
 net/ieee80211/ieee80211_rx.c                   |    4 
 net/ieee80211/ieee80211_tx.c                   |   15 
 net/ieee80211/softmac/ieee80211softmac_assoc.c |   31 
 net/ieee80211/softmac/ieee80211softmac_auth.c  |    4 
 net/ieee80211/softmac/ieee80211softmac_io.c    |    3 
 net/ieee80211/softmac/ieee80211softmac_wx.c    |   36 
 68 files changed, 7760 insertions(+), 1103 deletions(-)

Andreas Mohr:
      NI5010 netcard cleanup

Brice Goglin:
      myri10ge - Use dev_info() when printing parameters after probe
      myri10ge - Export more parameters to ethtool

brice@myri.com:
      myri10ge - Drop unused pm_state
      myri10ge - Drop ununsed nvidia chipset id

Daniel Drake:
      bcm43xx: use softmac-suggested TX rate
      bcm43xx: enable shared key authentication
      ZyDAS ZD1211 USB-WLAN driver
      zd1211rw: disable TX queue during stop

Don Fry:
      pcnet32: Fix Section mismatch error
      pcnet32: Use PCI_DEVICE macro
      pcnet32: Fix off-by-one in get_ringparam
      pcnet32: Use kcalloc instead of kmalloc and memset
      pcnet32: Handle memory allocation failures cleanly when resizing tx/rx rings
      pcnet32: Suspend the chip rather than restart when changing multicast/promisc
      pcnet32: Cleanup rx buffers after loopback test.

Eric Sesterhenn:
      skb used after passing to netif_rx in net/ieee80211/ieee80211_rx.c

Faidon Liambotis:
      Add two PLX device IDs

Hong Liu:
      ieee80211: fix not allocating IV+ICV space when usingencryption in ieee80211_tx_frame

Horms:
      CONFIG_WIRELESS_EXT is neccessary after all

Ingo Molnar:
      lock validator: fix ns83820.c irq-flags bug

Jeff Garzik:
      [netdrvr] epic100: minor cleanups
      [netdrvr] Remove Linux-specific changelogs from several Becker template drivers
      [netdrvr] Remove Becker-template 'io_size' member, when invariant
      [netdrvr] via-velocity: use netdev_priv() where appropriate
      [netdrvr] minor cleanups in Becker-derived drivers
      [netdrvr] via-velocity: misc. cleanups
      [netdrvr] via-velocity: remove io_size struct member, it is invariant
      [netdrvr] Use dev_printk() when ethernet interface isn't available
      [netdrvr] use dev_xxx() printk helpers, rather than dev_printk(KERN_xxx, ...

John W. Linville:
      softmac: fix build-break from 881ee6999d66c8fc903b429b73bbe6045b38c549

Joseph Jezak:
      SoftMAC: Prevent multiple authentication attempts on the same network
      SoftMAC: Add network to ieee80211softmac_call_events when associate times out

Kim Phillips:
      Add support for the Cicada 8201 PHY

Larry Finger:
      Convert bcm43xx-softmac to use the ieee80211_is_valid_channel routine
      2.6.17 missing a call to ieee80211softmac_capabilities from ieee80211softmac_assoc_req

Michael Buesch:
      bcm43xx: workaround init_board vs. IRQ race

Paul Fulghum:
      remove dead entry in net wan Kconfig

Ralf Baechle:
      Fix freeing of net device


