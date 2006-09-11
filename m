Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWIKN1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWIKN1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWIKN1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:27:11 -0400
Received: from havoc.gtf.org ([69.61.125.42]:28292 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751440AbWIKN1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:27:09 -0400
Date: Mon, 11 Sep 2006 09:27:07 -0400
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: What's in netdev-2.6.git
Message-ID: <20060911132707.GA8058@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following stuff is queued for 2.6.19.

A ton of driver updates.  Nothing really stands out except the addition
of the qla3xxx driver.



The 'upstream' branch of
git://git.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

contains the following updates:

 Documentation/networking/LICENSE.qla3xxx        |   46 
 MAINTAINERS                                     |   37 
 drivers/isdn/i4l/Kconfig                        |    1 
 drivers/net/3c501.c                             |    1 
 drivers/net/3c59x.c                             |    2 
 drivers/net/8139cp.c                            |    2 
 drivers/net/8139too.c                           |    2 
 drivers/net/8390.c                              |   10 
 drivers/net/Kconfig                             |   33 
 drivers/net/Makefile                            |   11 
 drivers/net/acenic.c                            |    2 
 drivers/net/amd8111e.c                          |    2 
 drivers/net/arcnet/com20020-pci.c               |    2 
 drivers/net/b44.c                               |    2 
 drivers/net/bnx2.c                              |    2 
 drivers/net/cassini.c                           |    2 
 drivers/net/chelsio/cxgb2.c                     |    2 
 drivers/net/defxx.c                             |    2 
 drivers/net/dl2k.c                              |    2 
 drivers/net/dm9000.c                            |    4 
 drivers/net/e100.c                              |   30 
 drivers/net/e1000/e1000.h                       |    6 
 drivers/net/e1000/e1000_ethtool.c               |  257 -
 drivers/net/e1000/e1000_hw.c                    | 1077 +++----
 drivers/net/e1000/e1000_hw.h                    |   26 
 drivers/net/e1000/e1000_main.c                  |  154 -
 drivers/net/e1000/e1000_param.c                 |  161 -
 drivers/net/eepro100.c                          |    2 
 drivers/net/epic100.c                           |    2 
 drivers/net/fealnx.c                            |    2 
 drivers/net/forcedeth.c                         |  560 ++-
 drivers/net/hp100.c                             |    1 
 drivers/net/irda/mcs7780.c                      |    1 
 drivers/net/irda/w83977af_ir.c                  |    1 
 drivers/net/ixgb/ixgb.h                         |    5 
 drivers/net/ixgb/ixgb_ethtool.c                 |    6 
 drivers/net/ixgb/ixgb_hw.c                      |   11 
 drivers/net/ixgb/ixgb_ids.h                     |    1 
 drivers/net/ixgb/ixgb_main.c                    |  152 -
 drivers/net/myri10ge/myri10ge.c                 |  228 +
 drivers/net/myri10ge/myri10ge_mcp.h             |   47 
 drivers/net/natsemi.c                           |    2 
 drivers/net/ne2k-pci.c                          |    2 
 drivers/net/netx-eth.c                          |    1 
 drivers/net/ns83820.c                           |    2 
 drivers/net/pci-skeleton.c                      |    2 
 drivers/net/pcmcia/axnet_cs.c                   |    3 
 drivers/net/pcmcia/pcnet_cs.c                   |   15 
 drivers/net/pcnet32.c                           |    2 
 drivers/net/phy/smsc.c                          |    1 
 drivers/net/phy/vitesse.c                       |    1 
 drivers/net/qla3xxx.c                           | 3537 ++++++++++++++++++++++++
 drivers/net/qla3xxx.h                           | 1194 ++++++++
 drivers/net/r8169.c                             |    2 
 drivers/net/rrunner.c                           |    2 
 drivers/net/s2io.c                              |    2 
 drivers/net/saa9730.c                           |    2 
 drivers/net/sis190.c                            |    2 
 drivers/net/sis900.c                            |    3 
 drivers/net/sk98lin/skge.c                      |    2 
 drivers/net/skfp/skfddi.c                       |    2 
 drivers/net/skge.c                              |  204 -
 drivers/net/skge.h                              |    1 
 drivers/net/sky2.c                              |  188 -
 drivers/net/sky2.h                              |    3 
 drivers/net/slhc.c                              |   28 
 drivers/net/smc911x.c                           |    2 
 drivers/net/starfire.c                          |    2 
 drivers/net/sundance.c                          |   15 
 drivers/net/sungem.c                            |    2 
 drivers/net/tc35815.c                           |    2 
 drivers/net/tg3.c                               |    2 
 drivers/net/tokenring/3c359.c                   |    2 
 drivers/net/tokenring/lanstreamer.c             |    2 
 drivers/net/tulip/21142.c                       |    6 
 drivers/net/tulip/de2104x.c                     |   18 
 drivers/net/tulip/de4x5.c                       |    2 
 drivers/net/tulip/dmfe.c                        |    2 
 drivers/net/tulip/eeprom.c                      |    2 
 drivers/net/tulip/interrupt.c                   |    2 
 drivers/net/tulip/media.c                       |    2 
 drivers/net/tulip/pnic.c                        |    2 
 drivers/net/tulip/pnic2.c                       |    2 
 drivers/net/tulip/timer.c                       |   16 
 drivers/net/tulip/tulip.h                       |   36 
 drivers/net/tulip/tulip_core.c                  |   94 
 drivers/net/tulip/uli526x.c                     |   12 
 drivers/net/tulip/winbond-840.c                 |   82 
 drivers/net/tulip/xircom_tulip_cb.c             |    2 
 drivers/net/typhoon.c                           |    2 
 drivers/net/via-rhine.c                         |    2 
 drivers/net/via-velocity.c                      |    2 
 drivers/net/via-velocity.h                      |   19 
 drivers/net/wan/cycx_main.c                     |    1 
 drivers/net/wan/dlci.c                          |    1 
 drivers/net/wan/dscc4.c                         |    2 
 drivers/net/wan/farsync.c                       |    2 
 drivers/net/wan/lmc/lmc_main.c                  |    2 
 drivers/net/wan/pc300_drv.c                     |    2 
 drivers/net/wan/pci200syn.c                     |    2 
 drivers/net/wan/sdla.c                          |    1 
 drivers/net/wan/wanxl.c                         |    2 
 drivers/net/wireless/Kconfig                    |   23 
 drivers/net/wireless/airo.c                     |   52 
 drivers/net/wireless/atmel_pci.c                |    2 
 drivers/net/wireless/bcm43xx/bcm43xx.h          |  174 -
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c  |   80 
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h  |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c      |  583 ++-
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |  296 +-
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c     |   10 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |  840 +++--
 drivers/net/wireless/bcm43xx/bcm43xx_main.h     |    3 
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c      |   33 
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c      |    4 
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c    |  104 
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c       |  166 -
 drivers/net/wireless/bcm43xx/bcm43xx_xmit.c     |    5 
 drivers/net/wireless/ipw2100.c                  |    7 
 drivers/net/wireless/ipw2200.c                  |  246 -
 drivers/net/wireless/ipw2200.h                  |   51 
 drivers/net/wireless/orinoco.c                  |    1 
 drivers/net/wireless/orinoco.h                  |    8 
 drivers/net/wireless/orinoco_nortel.c           |    2 
 drivers/net/wireless/orinoco_pci.c              |    2 
 drivers/net/wireless/orinoco_plx.c              |    2 
 drivers/net/wireless/orinoco_tmd.c              |    2 
 drivers/net/wireless/prism54/isl_ioctl.c        |  573 +++
 drivers/net/wireless/prism54/isl_ioctl.h        |    6 
 drivers/net/wireless/prism54/islpci_dev.c       |    4 
 drivers/net/wireless/prism54/islpci_dev.h       |    2 
 drivers/net/wireless/prism54/islpci_hotplug.c   |    2 
 drivers/net/wireless/ray_cs.c                   |    2 
 drivers/net/wireless/zd1211rw/Makefile          |    1 
 drivers/net/wireless/zd1211rw/zd_chip.c         |   62 
 drivers/net/wireless/zd1211rw/zd_chip.h         |   15 
 drivers/net/wireless/zd1211rw/zd_def.h          |    6 
 drivers/net/wireless/zd1211rw/zd_mac.c          |    6 
 drivers/net/wireless/zd1211rw/zd_mac.h          |    2 
 drivers/net/wireless/zd1211rw/zd_netdev.c       |   17 
 drivers/net/wireless/zd1211rw/zd_rf.c           |    7 
 drivers/net/wireless/zd1211rw/zd_rf.h           |    1 
 drivers/net/wireless/zd1211rw/zd_rf_al2230.c    |  155 -
 drivers/net/wireless/zd1211rw/zd_rf_al7230b.c   |  274 +
 drivers/net/wireless/zd1211rw/zd_usb.c          |  122 
 drivers/net/wireless/zd1211rw/zd_usb.h          |    1 
 drivers/net/yellowfin.c                         |    2 
 include/net/ieee80211.h                         |    9 
 include/net/ieee80211softmac.h                  |   60 
 net/ieee80211/ieee80211_crypt_ccmp.c            |   23 
 net/ieee80211/ieee80211_crypt_tkip.c            |  108 
 net/ieee80211/ieee80211_crypt_wep.c             |   35 
 net/ieee80211/ieee80211_rx.c                    |   56 
 net/ieee80211/ieee80211_tx.c                    |    9 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   21 
 net/ieee80211/softmac/ieee80211softmac_io.c     |   14 
 net/ieee80211/softmac/ieee80211softmac_module.c |   90 
 net/ieee80211/softmac/ieee80211softmac_priv.h   |    8 
 158 files changed, 10025 insertions(+), 2814 deletions(-)

Adrian Bunk:
      make drivers/net/e1000/e1000_hw.c:e1000_phy_igp_get_info() static

Andy Gospodarek:
      cleanup unnecessary forcedeth printk

Arjan van de Ven:
      resend of 8390 patch for lockdep

Auke Kok:
      e100: increment version to 3.5.10-k4
      e1000: Same cosmetic fix as earlier sent out for IPV4.
      e1000: Increment driver version to 7.1.9-k6
      ixgb: Increment version to 1.0.109-k4
      e1000: Whitespace cleanup, cosmetic changes
      e1000: error out if we cannot enable PCI device on resume
      e1000: remove unused part_num reading code
      e1000: Use module param array code
      e1000: Increment driver version to 7.2.7-k2
      e100: Convert e100 to use netdev_alloc_skb().
      e100: remove skb->dev assignment
      e100: increment version to 3.5.16-k2
      ixgb: Convert dev_alloc_skb to netdev_alloc_skb.
      ixgb: convert dev->priv to netdev_priv(dev).
      ixgb: recalculate after how many descriptors to wake the queue
      ixgb: remove skb->dev assignment
      ixgb: Increment version to 1.0.112-k2

Ayaz Abdulla:
      forcedeth: move mac address setup/teardown
      forcedeth: mac address corrected
      forcedeth: errata for marvell phys
      forcedeth: decouple vlan and rx checksum dependency

Brice Goglin:
      myri10ge: define some previously hardwired firmware constants
      myri10ge: convert to netdev_alloc_skb
      myri10ge: use netif_msg_link
      myri10ge: use multicast support in the firmware
      myri10ge: improve firmware selection

Christoph Hellwig:
      e1000: clean up skb allocation code

Dan Williams:
      prism54: update to WE-19 for WPA support

Daniel Drake:
      zd1211rw: Add Sagem device ID's
      zd1211rw: Implement SIOCGIWNICKN
      Add zd1211rw MAINTAINERS entry
      ieee80211: small ERP handling additions
      softmac: ERP handling and driver-level notifications
      softmac: export highest_supported_rate function
      ieee80211: Make ieee80211_rx_any usable
      softmac: Add MAINTAINERS entry
      zd1211rw: ZD1211B ASIC/FWT, not jointly decoder
      zd1211rw: Match vendor driver IFS values
      zd1211rw: AL2230 ZD1211B vendor sync
      zd1211rw: Support AL7230B RF
      zd1211rw: Add ID for Senao NUB-8301
      zd1211rw: Add ID for Allnet ALLSPOT Hotspot finder
      zd1211rw: Firmware version vs bootcode version mismatch handling
      zd1211rw: Add ID for ZyXEL G220F
      zd1211rw: Convert installer CDROM device into WLAN device

Daniele Venzano:
      Add new PHY to sis900 supported list

Dave Jones:
      remove unnecessary config.h includes from drivers/net/

Dirk Opfer:
      Fix dm9000 release_resource

Francois Romieu:
      Defer tulip_select_media() to process context

Grant Grundler:
      Print physical address in tulip_init_one
      Flush MMIO writes in reset sequence
      Clean up tulip.h
      Use tulip.h in winbond-840.c

Henrik Kretzschmar:
      initialisation cleanup for ULI526x-net-driver
      remove an unused function from the header

Jeff Garzik:
      drivers/net: Remove deprecated use of pci_module_init()

Jeff Kirsher:
      e100: Fix MDIO/MDIO-X
      e1000: Remove 0x1000 as supported device
      e1000: Allow NVM to setup LPLU for IGP2 and IGP3
      e1000: Force full DMA clocking for 10/100 speed
      e1000: Disable aggressive clocking on esb2 with SERDES port

Jesse Brandeburg:
      e1000: Explicitly power up the PHY during loopback testing.
      e1000: explicit locking for two ethtool path functions
      ixgb: fix cache miss due to miscalculation
      e1000: unify WoL capability detection code
      e1000: Add PCI ID 0x10a4 for our new 4-port PCI-Express device
      ixgb: Set a constant blink rate for ixgb adapter identify (1sec on, 1sec off)
      ixgb: Cache-align all TX components of the adapter struct.
      ixgb: Add buffer_info and test like e1000 has.

John W. Linville:
      bcm43xx: fix-up build breakage from merging patches out of order
      bcm43xx: reduce mac_suspend delay loop count

Komuro:
      network: pcnet_cs.c: remove unnecessary 'mdio_reset'
      network: axnet_cs.c: add new id (0x021b, 0x0202)

Larry Finger:
      bcm43xx: improved statistics
      bcm43xx: improved statistics
      bcm43xx: add missing mac_suspended initialization
      bcm43xx: optimization of DMA bitfields
      bcm43xx: return correct hard_start_xmit error code
      bcm43xx - set correct value in mac_suspended for ifdown/ifup sequence
      bcm43xx: Set floor of wireless signal and noise at -110 dBm

Linas Vepstas:
      e100: fix error recovery
      ixgb: Add PCI Error recovery callbacks

Manasi Deval:
      ixgb: Add CX4 PHY type detection and subdevice ID.

Michael Buesch:
      bcm43xx: opencoded locking
      bcm43xx: voluntary preemtion in the calibration loops
      bcm43xx: suspend MAC while executing long pwork
      bcm43xx: lower mac_suspend udelay
      bcm43xx: fix mac_suspend refcount
      bcm43xx: init routine rewrite
      bcm43xx: >1G and 64bit DMA support
      bcm43xx: re-add bcm43xx_rng_init() call
      MAINTAINERS: Add Larry Finger for bcm43xx (softmac)

Michael Wu:
      ray_cs: Remove dependency on ieee80211

Pavel Machek:
      cleanup // comments from ipw2200

Pavel Roskin:
      orinoco: Don't use "extern inline" on locking functions
      orinoco: include linux/if_arp.h directly

Philippe De Muyter:
      sundance: small cleanup

Ralf Baechle:
      Cleanup SLHC configuration
      Convert to kzalloc
      Remove useless casts
      Remove useless #ifdef MODULE stuff and printout

Robert Schulze:
      airo: collapse debugging-messages in issuecommand to one line

Ron Mercer:
      qla3xxx NIC driver

shemminger@osdl.org:
      sky2: remove cloned/pskb_expand_head check
      sky2: use netdev_alloc_skb
      sky2: dont use force status bit
      sky2: MSI test timing
      sky2: TSO mss optimization
      sky2: optimize checksum offload information
      sky2: power down PHY when not up
      sky2: pci post bug
      sky2: version 1.7

Stephen Hemminger:
      sky2: add another PCI ID
      forcedeth: coding style cleanups
      forcedeth: le32 annotation
      sky2: more pci device ids
      sky2: status interrupt handling improvement
      forcdeth: revised NAPI support
      skge: cleanup suspend/resume code
      skge: pci bus post fixes
      skge: use dev_alloc_skb
      skge: use ethX for irq assigments
      skge: version 1.7
      sky2: more pci device id's
      skge: use netdev_alloc_skb
      skge: irq lock race
      skge: use NAPI for transmit complete
      skge: version 1.8
      skge: check for PCI hotplug during IRQ

Sukadev Bhattiprolu:
      kthread: airo.c

Thibaut Varene:
      Make DS21143 printout match lspci output

Ulrich Kunitz:
      zd1211rw: USB id 1582:6003 for Longshine 8131G3 added
      zd1211rw: cleanups

Valerie Henson:
      Change tulip maintainer
      Handle pci_enable_device() errors in resume

Vasily Averin:
      e1000: IRQ resources cleanup
      e1000: e1000_probe resources cleanup
      e1000: ring buffers resources cleanup

Zhu Yi:
      ieee80211: Fix header->qos_ctl endian issue
      ieee80211: remove ieee80211_tx() is_queue_full warning
      ieee80211: TKIP and CCMP replay check rework
      ieee80211: Fix TKIP and WEP decryption error on SMP machines
      ieee80211: Workaround malformed 802.11 frames from AP
      ipw2200: always enable frequently used debugging code
      ipw2200: SIOCGIWFREQ ioctl returns frequency rather than channel
      ipw2200: ipw_wx_set_essid fix
      ipw2200: Reassociate even if set the same essid.
      ipw2200: remove unused struct ipw_rx_buffer
      ipw2200: Fix ipw2200 QOS parameters endian issue
      ipw2200: remove the MAC timestamp present field from radiotap head
      ipw2200: mark "iwconfig retry 255" as invalid
      ipw2200: Fix kernel Oops if cmdlog debug is enabled
      ipw2200: Add pci .shutdown handler
      ipw2100: Fix deadlock detected by lockdep
      ipw2200: enable wireless extension passive scan
      ipw2200: Update version stamp to 1.1.4
      ipw2200: Fix compile error when CONFIG_IPW2200_DEBUG is not selected

