Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVJ1AmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVJ1AmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVJ1AmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:42:22 -0400
Received: from havoc.gtf.org ([69.61.125.42]:59856 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965025AbVJ1AmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:42:21 -0400
Date: Thu, 27 Oct 2005 20:42:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20051028004217.GA16213@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream' branch of
master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following misc. updates, many of them minor fixes, and a
ton of accumulated wireless updates.

 drivers/net/gianfar_phy.c                     |  661 ------------
 drivers/net/gianfar_phy.h                     |  213 ----
 drivers/net/hamradio/mkiss.h                  |   62 -
 Documentation/networking/bonding.txt          |    5 
 drivers/net/8139cp.c                          |    5 
 drivers/net/8139too.c                         |    5 
 drivers/net/Kconfig                           |   23 
 drivers/net/Makefile                          |    4 
 drivers/net/au1000_eth.c                      |   13 
 drivers/net/b44.c                             |  136 ++
 drivers/net/b44.h                             |    2 
 drivers/net/bonding/bond_main.c               |   57 +
 drivers/net/declance.c                        |   37 
 drivers/net/e100.c                            |    4 
 drivers/net/e1000/e1000.h                     |   74 +
 drivers/net/e1000/e1000_ethtool.c             |   95 +
 drivers/net/e1000/e1000_hw.c                  |  220 +++-
 drivers/net/e1000/e1000_hw.h                  |   96 +
 drivers/net/e1000/e1000_main.c                | 1082 +++++++++++++++-----
 drivers/net/e1000/e1000_param.c               |   10 
 drivers/net/epic100.c                         |    4 
 drivers/net/forcedeth.c                       |  310 +++--
 drivers/net/gianfar.c                         |  412 +------
 drivers/net/gianfar.h                         |   30 
 drivers/net/gianfar_ethtool.c                 |  100 +
 drivers/net/gianfar_mii.c                     |  219 ++++
 drivers/net/gianfar_mii.h                     |   45 
 drivers/net/hamradio/Kconfig                  |    1 
 drivers/net/hamradio/bpqether.c               |    9 
 drivers/net/hamradio/mkiss.c                  |  182 ++-
 drivers/net/hp100.c                           |   48 
 drivers/net/irda/stir4200.c                   |    7 
 drivers/net/ixgb/ixgb_ethtool.c               |    8 
 drivers/net/ixgb/ixgb_main.c                  |    3 
 drivers/net/lne390.c                          |    2 
 drivers/net/mii.c                             |   15 
 drivers/net/mipsnet.c                         |  371 ++++++
 drivers/net/mipsnet.h                         |  127 ++
 drivers/net/ne.c                              |   15 
 drivers/net/ne2k-pci.c                        |    2 
 drivers/net/ns83820.c                         |    3 
 drivers/net/pcnet32.c                         |  278 ++++-
 drivers/net/phy/Kconfig                       |    8 
 drivers/net/phy/phy.c                         |    8 
 drivers/net/phy/phy_device.c                  |    3 
 drivers/net/r8169.c                           |    2 
 drivers/net/rionet.c                          |  574 ++++++++++
 drivers/net/s2io-regs.h                       |   11 
 drivers/net/s2io.c                            |  801 ++++++++++++---
 drivers/net/s2io.h                            |   50 
 drivers/net/sb1250-mac.c                      | 1380 +++++++++++++-------------
 drivers/net/sgiseeq.c                         |   37 
 drivers/net/skge.c                            |    2 
 drivers/net/sundance.c                        |   53 
 drivers/net/tokenring/ibmtr.c                 |    9 
 drivers/net/tokenring/olympic.c               |    2 
 drivers/net/tokenring/tms380tr.c              |    3 
 drivers/net/tulip/de2104x.c                   |    5 
 drivers/net/typhoon.c                         |    7 
 drivers/net/via-rhine.c                       |   38 
 drivers/net/wan/cosa.c                        |    6 
 drivers/net/wan/cycx_drv.c                    |    7 
 drivers/net/wan/cycx_main.c                   |    2 
 drivers/net/wan/cycx_x25.c                    |    5 
 drivers/net/wan/dscc4.c                       |   23 
 drivers/net/wan/farsync.c                     |   27 
 drivers/net/wan/hdlc_fr.c                     |    2 
 drivers/net/wan/lmc/lmc_debug.c               |   10 
 drivers/net/wan/lmc/lmc_media.c               |    8 
 drivers/net/wan/pc300.h                       |   16 
 drivers/net/wan/pc300_drv.c                   |   87 -
 drivers/net/wan/pc300_tty.c                   |   18 
 drivers/net/wan/sdla.c                        |   20 
 drivers/net/wan/sdla_fr.c                     |    4 
 drivers/net/wan/sdla_x25.c                    |    8 
 drivers/net/wan/sdladrv.c                     |   16 
 drivers/net/wan/syncppp.c                     |   10 
 drivers/net/wireless/airo.c                   |   37 
 drivers/net/wireless/airport.c                |   19 
 drivers/net/wireless/atmel.c                  |   24 
 drivers/net/wireless/hermes.c                 |   11 
 drivers/net/wireless/hermes.h                 |  111 +-
 drivers/net/wireless/hostap/hostap.c          |    6 
 drivers/net/wireless/hostap/hostap_80211_rx.c |   43 
 drivers/net/wireless/hostap/hostap_80211_tx.c |   28 
 drivers/net/wireless/hostap/hostap_ap.c       |   80 -
 drivers/net/wireless/hostap/hostap_ap.h       |    6 
 drivers/net/wireless/hostap/hostap_cs.c       |   50 
 drivers/net/wireless/hostap/hostap_hw.c       |   22 
 drivers/net/wireless/hostap/hostap_ioctl.c    |   23 
 drivers/net/wireless/hostap/hostap_pci.c      |   21 
 drivers/net/wireless/hostap/hostap_plx.c      |   11 
 drivers/net/wireless/hostap/hostap_wlan.h     |    2 
 drivers/net/wireless/ipw2100.c                |   24 
 drivers/net/wireless/ipw2100.h                |    2 
 drivers/net/wireless/ipw2200.c                |   27 
 drivers/net/wireless/ipw2200.h                |    4 
 drivers/net/wireless/netwave_cs.c             |  185 ---
 drivers/net/wireless/orinoco.c                |  235 +---
 drivers/net/wireless/orinoco.h                |   16 
 drivers/net/wireless/orinoco_cs.c             |  110 +-
 drivers/net/wireless/orinoco_nortel.c         |   20 
 drivers/net/wireless/orinoco_pci.c            |   18 
 drivers/net/wireless/orinoco_plx.c            |   18 
 drivers/net/wireless/orinoco_tmd.c            |   18 
 drivers/net/wireless/prism54/isl_ioctl.c      |   10 
 drivers/net/wireless/prism54/islpci_dev.c     |   10 
 drivers/net/wireless/prism54/islpci_dev.h     |    2 
 drivers/net/wireless/prism54/islpci_mgt.c     |    5 
 drivers/net/wireless/ray_cs.c                 |   46 
 drivers/net/wireless/spectrum_cs.c            |   79 -
 drivers/net/wireless/wavelan.c                |    8 
 drivers/net/wireless/wavelan.p.h              |    4 
 drivers/net/wireless/wavelan_cs.c             |    8 
 drivers/net/wireless/wavelan_cs.p.h           |    4 
 drivers/net/wireless/wl3501.h                 |    2 
 drivers/s390/net/qeth.h                       |   45 
 drivers/s390/net/qeth_fs.h                    |   12 
 drivers/s390/net/qeth_main.c                  |  419 +++++--
 drivers/s390/net/qeth_mpc.c                   |    6 
 drivers/s390/net/qeth_mpc.h                   |   15 
 drivers/s390/net/qeth_sys.c                   |   28 
 include/asm-mips/sgi/hpc3.h                   |   40 
 include/linux/cyclomx.h                       |    2 
 include/linux/cycx_drv.h                      |    1 
 include/linux/ibmtr.h                         |    4 
 include/linux/if_arp.h                        |    1 
 include/linux/mii.h                           |    1 
 include/linux/netdevice.h                     |    6 
 include/linux/sdladrv.h                       |    4 
 include/linux/wanpipe.h                       |    9 
 include/net/ieee80211.h                       |  523 +++++++--
 include/net/ieee80211_crypt.h                 |   38 
 include/net/ieee80211_radiotap.h              |  231 ++++
 include/net/syncppp.h                         |    1 
 net/ieee80211/Makefile                        |    3 
 net/ieee80211/ieee80211_crypt.c               |   59 -
 net/ieee80211/ieee80211_crypt_ccmp.c          |   75 -
 net/ieee80211/ieee80211_crypt_tkip.c          |  150 +-
 net/ieee80211/ieee80211_crypt_wep.c           |   26 
 net/ieee80211/ieee80211_geo.c                 |  141 ++
 net/ieee80211/ieee80211_module.c              |   65 -
 net/ieee80211/ieee80211_rx.c                  |  610 ++++++++---
 net/ieee80211/ieee80211_tx.c                  |  321 ++++--
 net/ieee80211/ieee80211_wx.c                  |  372 +++++--
 145 files changed, 8163 insertions(+), 4651 deletions(-)

Adrian Bunk:
      drivers/net/wan/: possible cleanups

Andrew Morton:
      e1000_intr build fix
      s2io build fix
      e1000 build fix

Andy Fleming:
      [netdrvr gianfar] use new phy layer

Ayaz Abdulla:
      [netdrvr forcedeth] scatter gather and segmentation offload support

Dale Farnsworth:
      mii: Add test for GigE support

Hong Liu:
      Fixed problem with not being able to decrypt/encrypt broadcast packets.
      Fixed oops if an uninitialized key is used for encryption.

Hubert WS Lin:
      pcnet32: set_ringparam implementation
      pcnet32: set min ring size to 4

Ivo van Doorn:
      This will move the ieee80211_is_ofdm_rate function to the ieee80211.h
      Currently the info_element is parsed by 2 seperate functions, this
      When an assoc_resp is received the network structure is not completely

James Ketrenos:
      Fixed some endian issues with 802.11 header usage in ieee80211_rx.c
      ieee80211 quality scaling algorithm extension handler
      ieee80211 Added wireless spy support
      Changed 802.11 headers to use ieee80211_info_element[0]
      ieee80211 Removed ieee80211_info_element_hdr
      ieee80211 Cleanup memcpy parameters.
      ieee80211 Switched to sscanf in store_debug_level
      ieee80211 Fixed type-o of abg_ture -> abg_true
      Updated ipw2200 to compile with ieee80211 abg_ture to abg_true change
      ieee80211: Updated ipw2100 to be compatible with ieee80211_hdr changes
      ieee80211: Updated ipw2100 to be compatible with ieee80211's hard_start_xmit change
      ieee80211: Updated ipw2200 to be compatible with ieee80211_hdr changes
      ieee80211: Updated ipw2200 to be compatible with ieee80211's hard_start_xmit change.
      ieee80211: Updated atmel to be compatible with ieee80211_hdr changes
      ieee80211: Fixed a kernel oops on module unload
      ieee80211: Hardware crypto and fragmentation offload support
      ieee80211: Fix time calculation, switching to use jiffies_to_msecs
      ieee80211: Fix kernel Oops when module unload
      ieee80211: Allow drivers to fix an issue when using wpa_supplicant with WEP
      ieee82011: Added WE-18 support to default wireless extension handler
      ieee80211: Renamed ieee80211_hdr to ieee80211_hdr_3addr
      ieee80211: adds support for the creation of RTS packets
      ieee82011: Added ieee80211_tx_frame to convert generic 802.11 data frames, and callbacks
      ieee80211: Fix TKIP, repeated fragmentation problem, and payload_size reporting
      ieee80211: Return NETDEV_TX_BUSY when QoS buffer full
      ieee80211: Add QoS (WME) support to the ieee80211 subsystem
      ieee80211: Added ieee80211_geo to provide helper functions
      ieee80211: Added ieee80211_radiotap.h
      ieee80211: Additional fixes for endian-aware types
      ieee80211: "extern inline" to "static inline"
      ieee80211: Type-o, capbility definition for QoS, and ERP parsing
      ieee80211: Mixed PTK/GTK CCMP/TKIP support
      ieee80211: Keep auth mode unchanged after iwconfig key off/on cycle
      ieee80211: Updated copyright dates
      ieee80211: Updated hostap to be compatible with ieee80211_hdr changes
      ieee80211: Updated hostap to be compatible with extra_prefix_len changes
      ieee82011: Remove WIRELESS_EXT ifdefs
      ieee80211: Added subsystem version string and reporting via MODULE_VERSION
      ieee80211: Added handle_deauth() callback, enhanced tkip/ccmp support of varying hw/sw offload
      ieee80211: added IE comments, reason_code to reason, removed info_element from ieee80211_disassoc
      ieee80211: in-tree driver updates to sync with latest ieee80211 series
      ieee80211: update orinoco, wl3501 drivers for latest struct naming
      Lindent and trailing whitespace script executed ieee80211 subsystem
      Update version ieee80211 stamp to 1.1.6
      ieee80211 build fix

Jean Tourrilhes:
      hostap: Add support for WE-19
      hostap: Use GFP_ATOMIC to get rid of weird might_sleep issue
      hostap: Remove iwe_stream_add_event kludge

Jeff Garzik:
      [netdrvr] delete CONFIG_PHYCONTROL
      Remove WIRELESS_EXT ifdefs from several wireless drivers.
      [wireless airo] remove needed dma_addr_t obfuscation
      e1000: fix warnings

Jiri Benc:
      ieee80211: division by zero fix

John Linville:
      [netdrvr s2io] Add a MODULE_VERSION entry

John W. Linville:
      8139cp: support ETHTOOL_GPERMADDR
      8139too: support ETHTOOL_GPERMADDR
      b44: support ETHTOOL_GPERMADDR
      e1000: support ETHTOOL_GPERMADDR
      e100: support ETHTOOL_GPERMADDR
      forcedeth: support ETHTOOL_GPERMADDR
      ixgb: support ETHTOOL_GPERMADDR
      ne2k-pci: support ETHTOOL_GPERMADDR
      pcnet32: support ETHTOOL_GPERMADDR
      r8169: support ETHTOOL_GPERMADDR
      skge: support ETHTOOL_GPERMADDR
      sundance: support ETHTOOL_GPERMADDR
      via-rhine: support ETHTOOL_GPERMADDR
      s2io: change strncpy length arg to use size of target
      bonding: replicate IGMP traffic in activebackup mode
      via-rhine: change mdelay to msleep and remove from ISR path
      epic100: fix counting of work_done in epic_poll
      bonding: fix typos in bonding documentation
      8139too: fix resume for Realtek 8100B/8139D
      bonding: cleanup comment for mode 1 IGMP xmit hack
      b44: alternate allocation option for DMA descriptors
      orinoco: remove redundance skb length check before padding
      sundance: remove if (1) { ... } block in sundance_probe1
      sundance: expand reset mask
      sundance: include MII address 0 in PHY probe

Jouni Malinen:
      hostap: Remove hw specific dev_open/close handlers
      hostap: Fix hostap_pci build with PRISM2_IO_DEBUG
      hostap: Do not free local->hw_priv before unregistering netdev
      hostap: Unregister netdevs before freeing local data

Mallikarjuna R Chilakala:
      e1000: Support for 82571 and 82572 controllers
      e1000: multi-queue defines/modification to data structures
      e1000: implementation of the multi-queue feature
      e1000: Enable custom configuration bits for 82571/2 controllers
      e1000: Fixes for packet split related issues
      e1000: Added msleep_interruptible delay
      e1000: Flush shadow RAM
      e1000: Driver version, white space, comments, device id & other

Manfred Spraul:
      forcedeth: add hardware tx checksumming

Mateusz Berezecki:
      [wireless ipw2200] remove redundant return statement

Matt Porter:
      Add rapidio net driver

Michael Buesch:
      ieee80211 subsystem:

Michael Wu:
      This patch fixes a typo in ieee80211.h: ieee82011_deauth -> ieee80211_deauth

Michal Schmidt:
      airo: fix resume

Nishanth Aravamudan:
      drivers/net: fix-up schedule_timeout() usage

Pavel Roskin:
      orinoco: WE-18 support
      orinoco: Remove conditionals that are useless in the kernel drivers.
      orinoco: Don't include <net/ieee80211.h> twice.
      orinoco: Update PCMCIA ID's.
      orinoco: Remove inneeded system includes.
      orinoco: Make nortel_pci_hw_init() static.
      orinoco: Fix memory leak and unneeded unlock in orinoco_join_ap()
      orinoco: orinoco_send_wevents() could return without unlocking.
      orinoco: Remove unneeded forward declarations.
      orinoco: Annotate endianess of variables and structure members.
      orinoco: Read only needed data in __orinoco_ev_txexc().
      orinoco: Bump version to 0.15rc3.
      hostap: Fix pci_driver name for hostap_plx and hostap_pci

Ralf Baechle:
      AX.25: Delete debug printk from mkiss driver
      AX.25: Convert mkiss.c to DEFINE_RWLOCK
      rcu in bpqether driver.
      SMACK support for mkiss
      Initialize the .owner field the tty_ldisc structure.
      sb1250-mac: Check the actual setting for reporting hw checksumming.
      sb1250-mac: Ensure 16-byte alignment of the descriptor ring.
      au1000_eth: Misc Au1000 net driver fixes.
      de2104x: Resurrect Cobalt support for 2.6.
      sgiseeq: Fix resource handling.
      sgiseeq: Configure PIO and DMA timing requests.
      declance: Convert to irqreturn_t.
      declance: Fix mapping of device.
      declance: Deal with the bloody KSEG vs CKSEG horror...
      declance: Use physical addresses at the interface level.
      ne: Support for RBHMA4500 eval board.
      mipsnet: Virtual ethernet driver for MIPSsim.
      Remove unused header.
      sb1250-mac: Get rid of all the funny SBMAC_WRITECSR and SBMAC_READCSR macros.
      sb1250-mac: Whitespace cleanup.
      sb1250-mac: PHY probing fixes.

Randy Dunlap:
      Fix implicit nocast warnings in ieee80211 code:

Ravinandan Arakali:
      S2io: MSI/MSI-X support (runtime configurable)

ravinandan.arakali@neterion.com:
      S2io: Offline diagnostics fixes

Tobias Klauser:
      Replace drivers/net/wan custom ctype macros with standard ones

Ursula Braun:
      s390: introducing support in qeth for new OSA CHPID type OSN

viro@ZenIV.linux.org.uk:
      lne390 bogus casts
      C99 initializers in ray_cs.c

