Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVCWDfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVCWDfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVCWDfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:35:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:749 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262615AbVCWDc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:32:57 -0500
Message-ID: <4240E35C.2090203@pobox.com>
Date: Tue, 22 Mar 2005 22:32:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: netdev-2.6 queue updated
Content-Type: multipart/mixed;
 boundary="------------070301080309020608040309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301080309020608040309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wireless update, and various minor fixes.

BK URL, patch URL, and changelog attached.

	Jeff



--------------070301080309020608040309
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.12-rc1-bk1-netdev1.patch.bz2

This will update the following files:

 drivers/net/fmv18x.c                            |  689 ----
 drivers/net/sk_g16.c                            | 2045 -----------
 drivers/net/sk_g16.h                            |  164 
 drivers/net/wireless/ieee802_11.h               |   78 
 Documentation/networking/multicast.txt          |    1 
 Documentation/networking/net-modules.txt        |    3 
 MAINTAINERS                                     |   14 
 drivers/net/3c505.c                             |    6 
 drivers/net/8139cp.c                            |  109 
 drivers/net/8139too.c                           |  202 -
 drivers/net/Kconfig                             |   40 
 drivers/net/Makefile                            |    3 
 drivers/net/Space.c                             |    6 
 drivers/net/arcnet/arcnet.c                     |    4 
 drivers/net/b44.c                               |   36 
 drivers/net/b44.h                               |    3 
 drivers/net/bonding/bond_alb.c                  |    4 
 drivers/net/depca.c                             |    2 
 drivers/net/e100.c                              |   69 
 drivers/net/eql.c                               |    4 
 drivers/net/mii.c                               |    9 
 drivers/net/myri_code.h                         | 1283 -------
 drivers/net/natsemi.c                           |   11 
 drivers/net/r8169.c                             |   31 
 drivers/net/sis900.c                            |   54 
 drivers/net/sk98lin/skethtool.c                 |    3 
 drivers/net/skge.c                              | 3385 +++++++++++++++++++
 drivers/net/skge.h                              | 3005 +++++++++++++++++
 drivers/net/smc91x.c                            |  161 
 drivers/net/smc91x.h                            |   15 
 drivers/net/starfire.c                          |  142 
 drivers/net/starfire_firmware.h                 |  346 ++
 drivers/net/tulip/dmfe.c                        |    3 
 drivers/net/tulip/winbond-840.c                 |    3 
 drivers/net/via-velocity.c                      |    6 
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/Makefile                   |    2 
 drivers/net/wireless/atmel.c                    |   62 
 drivers/net/wireless/hostap/Kconfig             |  104 
 drivers/net/wireless/hostap/Makefile            |    8 
 drivers/net/wireless/hostap/hostap.c            | 1205 +++++++
 drivers/net/wireless/hostap/hostap.h            |   57 
 drivers/net/wireless/hostap/hostap_80211.h      |  107 
 drivers/net/wireless/hostap/hostap_80211_rx.c   | 1084 ++++++
 drivers/net/wireless/hostap/hostap_80211_tx.c   |  522 +++
 drivers/net/wireless/hostap/hostap_ap.c         | 3286 +++++++++++++++++++
 drivers/net/wireless/hostap/hostap_ap.h         |  272 +
 drivers/net/wireless/hostap/hostap_common.h     |  557 +++
 drivers/net/wireless/hostap/hostap_config.h     |   86 
 drivers/net/wireless/hostap/hostap_crypt.c      |  167 
 drivers/net/wireless/hostap/hostap_crypt.h      |   50 
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |  486 ++
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |  696 ++++
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |  281 +
 drivers/net/wireless/hostap/hostap_cs.c         |  929 +++++
 drivers/net/wireless/hostap/hostap_download.c   |  766 ++++
 drivers/net/wireless/hostap/hostap_hw.c         | 3631 +++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_info.c       |  478 ++
 drivers/net/wireless/hostap/hostap_ioctl.c      | 4116 ++++++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_pci.c        |  453 ++
 drivers/net/wireless/hostap/hostap_plx.c        |  612 +++
 drivers/net/wireless/hostap/hostap_proc.c       |  466 ++
 drivers/net/wireless/hostap/hostap_wlan.h       | 1075 ++++++
 drivers/net/wireless/orinoco.c                  |   11 
 drivers/net/wireless/wl3501.h                   |    4 
 include/linux/pci_ids.h                         |    3 
 include/linux/wireless.h                        |  283 +
 include/net/ieee80211.h                         |  887 +++++
 include/net/ieee80211_crypt.h                   |   86 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/core/wireless.c                             |   74 
 net/ieee80211/Kconfig                           |   67 
 net/ieee80211/Makefile                          |   11 
 net/ieee80211/ieee80211_crypt.c                 |  259 +
 net/ieee80211/ieee80211_crypt_ccmp.c            |  470 ++
 net/ieee80211/ieee80211_crypt_tkip.c            |  708 ++++
 net/ieee80211/ieee80211_crypt_wep.c             |  272 +
 net/ieee80211/ieee80211_module.c                |  268 +
 net/ieee80211/ieee80211_rx.c                    | 1206 +++++++
 net/ieee80211/ieee80211_tx.c                    |  448 ++
 net/ieee80211/ieee80211_wx.c                    |  471 ++
 82 files changed, 34377 insertions(+), 4653 deletions(-)

through these ChangeSets:

<jketreno:linux.intel.com>:
  o ieee80211 subsystem

<komurojun-mbn:nifty.com>:
  o net/Kconfig: remove unsupported network adapter names

<mgalgoci:parcelfarce.linux.theplanet.co.uk>:
  o wireless-2.6 cleanup

<philipp.gortan:tttech.com>:
  o [netdrvr 8139cp] add PCI ID

Adrian Bunk:
  o remove two obsolete net drivers
  o drivers/net/sis900.c: fix a warning
  o drivers/net/eql.c: kill dead code
  o net/ieee80211/Kconfig: don't describe what gets selected

Alexander Viro:
  o hostap __user annotations

Andres Salomon:
  o fix pci_disable_device in 8139too

Andrew Morton:
  o bonding needs inet

Dale Farnsworth:
  o mii: GigE support bug fixes

Daniele Venzano:
  o More ethtool support for sis900 and warning fix
  o Maintainer change for the sis900 driver

Domen Puncer:
  o drivers/net/myri_code.h cleanup
  o net/sk98lin: remove duplicate delay
  o net/3c505: replace schedule_timeout() with msleep()

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o r8169: incoming frame length check
  o ieee80211: offset_in_page() removal
  o ieee80211: C99 initialization for eap_types
  o ieee80211: failure of ieee80211_crypto_init()
  o 8139cp: SG support fixes

Greg Kroah-Hartman:
  o net drivers: convert pci_dev->slot_name usage to pci_name()

Jean Tourrilhes:
  o Wireless Extensions 18 (aka WPA)

Jeff Garzik:
  o [netdrvr smc91x] use __iomem addresses in eeprom read/write changes
  o [netdrvr starfire] Add GPL'd firmware, remove compat code
  o [wireless hostap] update for new pci_save_state()
  o [netdrvr 8139cp] TSO support

John W. Linville:
  o e100: NAPI state machine fix
  o bonding: avoid tx balance for IGMP (alb/tlb mode)
  o b44: allocate tx bounce bufs as needed

Joshua Kwan:
  o hostap: fix Kconfig typos and missing select CRYPTO

Jouni Malinen:
  o hostap: Update to use the new WE18 proposal
  o hostap: Filter disconnect events
  o hostap: Improved suspend
  o hostap: Rate limiting for debug messages
  o hostap: Clear station statistic on accounting start
  o hostap: Fix procfs rmdir after ifname change
  o hostap: Add support for multi-func SanDisk ConnectPlus
  o hostap: Disable interrupts before Genesis mode
  o hostap: Include asm/io.h
  o hostap: Clear station statistic on accounting start
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

Ladislav Michl:
  o smc91x: get/set eeprom

Mikael Pettersson:
  o drivers/net/depca.c gcc4 fix
  o drivers/net/arcnet/arcnet.c gcc4 fixes

Nicolas Pitre:
  o smc91x warning fix
  o smc91x addr config check

Olaf Kirch:
  o natsemi: long cable, short cable

Pavel Machek:
  o Fix suspend/resume on via-velocity

Pekka Enberg:
  o 8139too: use iomap for pio/mmio

Steffen Klassert:
  o 8139cp - add netpoll support

Stephen Hemminger:
  o skge: change driver version
  o skge: fix race with receive interrupt and NAPI
  o skge: use lockless transmit
  o skge: interrupt coalecsing related fixes
  o skge: only allow tx/rx csum on Yukon chipset
  o skge: use array for port irq masks
  o skge: use chip MIB stats for packet and byte counts
  o skge: simplify definition of wake on lan support
  o skge: suspend/resume related state management
  o skge: remove unneeded include's
  o skge: spelling and whitespace
  o skge: use PFX string
  o skge driver (0.5)
  o 8139cp - module_param

Tobias Klauser:
  o drivers/net/tulip/winbond-840: Use the DMA_32BIT_MASK constant
  o drivers/net/tulip/dmfe: Use the DMA_32BIT_MASK constant
  o drivers/net/8139cp: Use the DMA_{64, 32}BIT_MASK constants


--------------070301080309020608040309--
