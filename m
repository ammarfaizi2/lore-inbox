Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVBMUjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVBMUjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBMUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:39:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25239 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261304AbVBMUi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:38:58 -0500
Message-ID: <420FBAD3.3020909@pobox.com>
Date: Sun, 13 Feb 2005 15:38:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: netdev-2.6 queue updated
Content-Type: multipart/mixed;
 boundary="------------020904010101080409030203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904010101080409030203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached for list of changes, BK info, and patch URL.

Recent changes:

* posted patch against 2.6.11-rc4 (see attached)

* incorporated ieee80211 lib code into the wireless-2.6 sub-tree, which 
is included in this queue.  This code will form the basis of the "Linux 
wireless stack".  Wireless hackers...  start hacking!

* r8169 fixes, sundance fix, bonding update, smc91x update


--------------020904010101080409030203
Content-Type: text/plain;
 name="netdev.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="netdev.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.11-rc4-netdev1.patch.bz2

This will update the following files:

 drivers/net/bagetlance.c                        | 1368 -----
 include/linux/dp83840.h                         |   41 
 Documentation/networking/bonding.txt            | 2101 +++++----
 Documentation/networking/e100.txt               |    3 
 Documentation/networking/ixgb.txt               |    9 
 MAINTAINERS                                     |    7 
 arch/arm/mach-pxa/lubbock.c                     |    2 
 arch/arm/mach-sa1100/neponset.c                 |    2 
 drivers/net/3c503.c                             |   67 
 drivers/net/3c515.c                             |   32 
 drivers/net/8139cp.c                            |  100 
 drivers/net/8139too.c                           |  291 -
 drivers/net/Kconfig                             |   56 
 drivers/net/Makefile                            |    2 
 drivers/net/Space.c                             |   11 
 drivers/net/arcnet/arc-rawmode.c                |    4 
 drivers/net/arcnet/arc-rimi.c                   |   14 
 drivers/net/arcnet/arcnet.c                     |   30 
 drivers/net/arcnet/com20020.c                   |    6 
 drivers/net/arcnet/com90io.c                    |    4 
 drivers/net/arcnet/com90xx.c                    |    8 
 drivers/net/arcnet/rfc1051.c                    |    8 
 drivers/net/arcnet/rfc1201.c                    |   12 
 drivers/net/au1000_eth.c                        | 1361 ++++-
 drivers/net/au1000_eth.h                        |   55 
 drivers/net/b44.h                               |   14 
 drivers/net/bonding/bond_alb.c                  |    8 
 drivers/net/bonding/bond_main.c                 |   35 
 drivers/net/cs89x0.c                            |    4 
 drivers/net/eepro100.c                          |   10 
 drivers/net/es3210.c                            |   32 
 drivers/net/ewrk3.c                             |   87 
 drivers/net/fealnx.c                            |  275 -
 drivers/net/hamradio/baycom_epp.c               |   53 
 drivers/net/hamradio/baycom_par.c               |    8 
 drivers/net/hamradio/baycom_ser_fdx.c           |    7 
 drivers/net/hamradio/baycom_ser_hdx.c           |    7 
 drivers/net/hamradio/bpqether.c                 |   17 
 drivers/net/hamradio/dmascc.c                   | 2073 ++++----
 drivers/net/hamradio/hdlcdrv.c                  |   48 
 drivers/net/hamradio/mkiss.c                    |   12 
 drivers/net/hamradio/yam.c                      |   38 
 drivers/net/ibm_emac/ibm_emac.h                 |    4 
 drivers/net/ibmlana.c                           |   99 
 drivers/net/ibmlana.h                           |    1 
 drivers/net/ioc3-eth.c                          |   83 
 drivers/net/irda/act200l-sir.c                  |    3 
 drivers/net/irda/irtty-sir.c                    |    4 
 drivers/net/irda/ma600-sir.c                    |   12 
 drivers/net/irda/sir_dev.c                      |    4 
 drivers/net/irda/tekram-sir.c                   |    3 
 drivers/net/jazzsonic.c                         |  217 
 drivers/net/meth.c                              |  275 -
 drivers/net/meth.h                              |    2 
 drivers/net/mv643xx_eth.c                       | 2400 +++++-----
 drivers/net/mv643xx_eth.h                       |  603 --
 drivers/net/ni65.c                              |    3 
 drivers/net/ns83820.c                           |    3 
 drivers/net/pcmcia/ibmtr_cs.c                   |    7 
 drivers/net/pcmcia/xirc2ps_cs.c                 |   23 
 drivers/net/pcnet32.c                           |   47 
 drivers/net/ppp_generic.c                       |    2 
 drivers/net/r8169.c                             |   92 
 drivers/net/s2io.c                              |   45 
 drivers/net/sb1250-mac.c                        |  109 
 drivers/net/sgiseeq.c                           |   70 
 drivers/net/sis900.c                            |  195 
 drivers/net/sk_mca.c                            |  126 
 drivers/net/sk_mca.h                            |   19 
 drivers/net/skge.c                              | 3334 ++++++++++++++
 drivers/net/skge.h                              | 3005 ++++++++++++
 drivers/net/smc-mca.c                           |   37 
 drivers/net/smc-ultra.c                         |   34 
 drivers/net/smc-ultra32.c                       |   30 
 drivers/net/smc91x.c                            |  203 
 drivers/net/smc91x.h                            |   79 
 drivers/net/sonic.c                             |    4 
 drivers/net/sundance.c                          |    7 
 drivers/net/tg3.h                               |   14 
 drivers/net/tokenring/ibmtr.c                   |  158 
 drivers/net/typhoon-firmware.h                  | 5568 ++++++++++--------------
 drivers/net/typhoon.c                           |  244 -
 drivers/net/wan/cosa.c                          |    7 
 drivers/net/wan/dscc4.c                         |  117 
 drivers/net/wd.c                                |   36 
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/Makefile                   |    2 
 drivers/net/wireless/airo.c                     |   25 
 drivers/net/wireless/airport.c                  |    5 
 drivers/net/wireless/arlan.h                    |    4 
 drivers/net/wireless/atmel_cs.c                 |    3 
 drivers/net/wireless/hermes.c                   |   43 
 drivers/net/wireless/hermes.h                   |   62 
 drivers/net/wireless/hostap/Kconfig             |  104 
 drivers/net/wireless/hostap/Makefile            |    8 
 drivers/net/wireless/hostap/hostap.c            | 1205 +++++
 drivers/net/wireless/hostap/hostap.h            |   57 
 drivers/net/wireless/hostap/hostap_80211.h      |  107 
 drivers/net/wireless/hostap/hostap_80211_rx.c   | 1080 ++++
 drivers/net/wireless/hostap/hostap_80211_tx.c   |  522 ++
 drivers/net/wireless/hostap/hostap_ap.c         | 3259 ++++++++++++++
 drivers/net/wireless/hostap/hostap_ap.h         |  272 +
 drivers/net/wireless/hostap/hostap_common.h     |  556 ++
 drivers/net/wireless/hostap/hostap_config.h     |   86 
 drivers/net/wireless/hostap/hostap_crypt.c      |  167 
 drivers/net/wireless/hostap/hostap_crypt.h      |   50 
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |  486 ++
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |  696 +++
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |  281 +
 drivers/net/wireless/hostap/hostap_cs.c         |  785 +++
 drivers/net/wireless/hostap/hostap_download.c   |  761 +++
 drivers/net/wireless/hostap/hostap_hw.c         | 3607 +++++++++++++++
 drivers/net/wireless/hostap/hostap_info.c       |  469 ++
 drivers/net/wireless/hostap/hostap_ioctl.c      | 3624 +++++++++++++++
 drivers/net/wireless/hostap/hostap_pci.c        |  452 +
 drivers/net/wireless/hostap/hostap_plx.c        |  611 ++
 drivers/net/wireless/hostap/hostap_proc.c       |  466 ++
 drivers/net/wireless/hostap/hostap_wlan.h       | 1071 ++++
 drivers/net/wireless/orinoco_cs.c               |   10 
 drivers/net/wireless/orinoco_pci.c              |    7 
 drivers/net/wireless/orinoco_plx.c              |   82 
 drivers/net/wireless/orinoco_tmd.c              |   51 
 drivers/net/wireless/prism54/isl_ioctl.c        |    2 
 drivers/net/wireless/ray_cs.c                   |    5 
 include/linux/ibmtr.h                           |   15 
 include/linux/mii.h                             |    4 
 include/linux/mv643xx.h                         |  434 +
 include/linux/netdevice.h                       |    2 
 include/linux/pci_ids.h                         |    8 
 include/net/ieee80211.h                         |  883 +++
 include/net/ieee80211_crypt.h                   |   86 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/dev.c                                  |   28 
 net/ieee80211/Kconfig                           |   71 
 net/ieee80211/Makefile                          |   11 
 net/ieee80211/ieee80211_crypt.c                 |  253 +
 net/ieee80211/ieee80211_crypt_ccmp.c            |  473 ++
 net/ieee80211/ieee80211_crypt_tkip.c            |  711 +++
 net/ieee80211/ieee80211_crypt_wep.c             |  275 +
 net/ieee80211/ieee80211_module.c                |  268 +
 net/ieee80211/ieee80211_rx.c                    | 1206 +++++
 net/ieee80211/ieee80211_tx.c                    |  448 +
 net/ieee80211/ieee80211_wx.c                    |  471 ++
 144 files changed, 42414 insertions(+), 9971 deletions(-)

through these ChangeSets:

<andi:cosy.sbg.ac.at>:
  o sundance: attempt to address high irqs due to TX overflow

<dfarnsworth:mvista.com>:
  o Big rename
  o Rename MV_READ => mv_read and MV_WRITE => mv_write
  o Additional whitespace cleanups, mostly changing spaces to tabs in comments
  o Run mv643xx_eth.[ch] through scripts/Lindent
  o Add a function to detect at runtime whether a PHY is attached to the specified port, and use it to cause the probe routine to fail when there is no PHY.
  o This one liner removes a spurious left paren fixing an obvious syntax error in the #ifndef MV64340_NAPI case
  o Add support for PHYs/boards that don't support autonegotiation
  o With this patch, the driver now calls netif_carrier_off/netif_carrier_on
  o This patch cleans up the handling of receive skb sizing

<jketreno:linux.intel.com>:
  o ieee80211 subsystem

<philipp.gortan:tttech.com>:
  o [netdrvr 8139cp] add PCI ID

Adrian Bunk:
  o remove dp83840.h

Alexander Viro:
  o 3c503 (iomem + isa-ectomy)
  o ibmlana part 2 (iomem annotations and isa-ectomy)
  o ibmlana part 1 (netdev_priv())
  o sk_mca - iomem and isa-ectomy
  o sk_mca - netdev_priv()
  o ibmtr 2/2: ibmtr annotations - the rest
  o ibmtr 1/2: iomem annotations - trivial part
  o es3210 iomem annotions and isa-ectomy
  o ewrk3 iomem annotations + isa-ectomy
  o wd iomem annotations + isa-ectomy
  o smc-ultra32 iomem annotations + isa-ectomy
  o smc-ultra iomem annotations + isa-ectomy
  o smc-mca iomem annotations and isa-ectomy
  o fealnx iomem annotations, switch to io{read,write}
  o wireless iomem annotations and fixes, switch to io{read,write}

Dale Farnsworth:
  o This patch simplifies the mv64340_eth_set_rx_mode function without changing its behavior.
  o This patch makes the use of the MV64340_RX_QUEUE_FILL_ON_TASK config macro more consistent, though the macro remains undefined, since the feature still does not work properly.
  o This patch adds support for passing additional parameters via the platform_device interface.  These additional parameters are:
  o This patch adds device driver model support to the mv643xx_eth driver
  o This patch replaces the use of the pci_map_* functions with the corresponding dma_map_* functions.
  o This patch fixes the code that enables hardware checksum generation
  o This patch removes spin delays (count to 1000000, ugh) and instead waits with udelay or msleep for hardware flags to change.
  o This patch removes code that is redundant or useless

Daniele Venzano:
  o sis900: chiprev i/o cleanups
  o sis900: debugging output update
  o sis900 printk audit
  o sis900: version bump; remove broken URL
  o sis900: add infrastructure needed for standard netif messages

David Dillow:
  o Bump version and release date
  o Version 03.001.008 of the Typhoon firmware, courtesy of 3Com
  o Fixup the version reporting to match 3Com
  o Use module_param() and add descriptions
  o Teach typhoon to use port IO on machines that need it. It will attempt to use MMIO, but if that fails (or the user asks), it will fallback to port IO.
  o Enable bus mastering before saving our state, or we'll only be able to load the modules one time.

David T. Hollis:
  o Move MII-related constants from b44/tg3 drivers to linux/mii.h

Domen Puncer:
  o net/ewrk3: replace schedule_timeout() with msleep_interruptible()
  o net/tekram-sir: replace schedule_timeout() with msleep()
  o net/ns83820: replace schedule_timeout() with msleep()
  o net/ni65: replace schedule_timeout() with msleep()
  o net/sir_dev: replace schedule_timeout() with msleep()
  o net/xirc2ps_cs: replace Wait() with msleep()
  o net/ma600-sir: replace schedule_timeout() with msleep()
  o net/irtty-sir: replace schedule_timeout() with msleep()
  o net/act2001-sir: replace schedule_timeout() with msleep()
  o arcnet: remove casts

Don Fry:
  o pcnet32: 79c976 with fiber optic fix

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o r8169: synchronization and balancing when the device is closed
  o r8169: screaming irq when the device is closed
  o r8169: typo in debugging code
  o r8169: merge of Realtek's code
  o r8169: endianness fixes
  o dscc4: removal of unneeded variable
  o dscc4: removal of unneeded casts
  o dscc4: error status checking and pci janitoring
  o dscc4: code factorisation
  o dscc4: use of uncompletely initialized struct
  o 8139cp: SG support fixes

Ganesh Venkatesan:
  o ixgb: Documentation/networking/ixgb.txt

Ian Campbell:
  o use datacs in smc91x driver
  o smc91x: power down PHY on suspend

Jay Vosburgh:
  o bonding: Update/rewrite bonding.txt
  o bonding: Update kconfig description
  o bonding: change misleading warning
  o bonding: use wrappers to change mtu and MAC
  o net/core: move set MAC into separate function

Jeff Garzik:
  o [wireless hostap] update for new pci_save_state()
  o [netdrvr 8139cp] TSO support

Joshua Kwan:
  o hostap: fix Kconfig typos and missing select CRYPTO

Jouni Malinen:
  o Host AP: Replaced MODULE_PARM with module_param*
  o Host AP: Replaced direct dev->priv references with netdev_priv(dev)
  o Host AP: Updated to use Linux wireless extensions v17
  o Host AP: pci_register_driver() return value changes
  o Host AP: Fix netif_carrier_off() in non-client modes
  o Host AP: Fix PRISM2_IO_DEBUG
  o Host AP: Use void __iomem * with {read,write}{b,w}
  o Host AP: Fix card enabling after firmware download
  o Host AP: Do not bridge packets to unauthorized ports
  o Host AP: Fix compilation with PRISM2_NO_STATION_MODES defined
  o Host AP: Prevent STAs from associating using AP address
  o Host AP: Fix hw address changing for wifi# interface
  o Host AP: Remove ioctl debug messages
  o Host AP: Ignore (Re)AssocResp messages silently
  o Host AP: Fix interface packet counters
  o Host AP: Disable EAPOL TX/RX debug messages
  o fix hostap crypto bugs
  o Add HostAP wireless driver

JustMan:
  o atmel_cs: Add support LG LW2100N WLAN PCMCIA card

Matt Porter:
  o Add PPC440SP support to IBM EMAC driver

Nicolas Pitre:
  o smc91x: allow RX of VLAN packets

Nishanth Aravamudan:
  o net/cosa: replace schedule_timeout() with msleep()
  o net/airo: replace schedule_timeout() with msleep()/ssleep()
  o net/cs89x0: replace schedule_timeout() with msleep()

Paul Mackerras:
  o remove bogus exports in ppp

Pavel Machek:
  o eepro100 kill obsolete ifdefs

Pekka Enberg:
  o 8139too: use iomap for pio/mmio

Ralf Bächle:
  o Reformat DMASCC driver
  o Use netdev_priv in baycom_epp driver
  o Use netdev_priv in baycom_ser_fdx driver
  o Use netdev_priv in hdlcdrv driver
  o Use netdev_priv in baycom_ser_hdx driver
  o Use netdev_priv in baycom_par driver
  o Use netdev_priv in bpqether driver
  o Use netdev_priv in mkiss driver
  o Use netdev_priv in YAM driver
  o SGI Seeq updates
  o SB1250 driver updates
  o S2IO syntax fixes
  o Meth driver updates
  o Marvell MV-64340 driver upda
  o Jazzsonic driver updates
  o IOC3 driver updates
  o Remove Baget network driver
  o Au1000 driver updates

Randy Dunlap:
  o ray_cs: reduce stack usage (sockaddr)
  o prism54: use NULL for pointer
  o (v2) arlan: remove gcc warning with CONFIG_PROC_FS=n

Rene Herman:
  o 8139too Interframe Gap Time

Scott Feldman:
  o e100: remove reference to NAPI config option

Steffen Klassert:
  o Add MODULE_VERSION to the 3c515 driver
  o Use netdev_priv in the 3c515 driver
  o 8139cp - add netpoll support

Stephen Hemminger:
  o skge driver (0.5)
  o 8139too: use netdev_priv
  o 8139cp - module_param

Thomas Gleixner:
  o rtl8139too.c: Fix missing pci_disable_dev
  o rtl8139too.c: Fix missing pci_disable_dev

Tony Lindgren:
  o Add OMAP support to smc91x Ethernet driver


--------------020904010101080409030203--
