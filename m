Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCJF4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCJF4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVCJFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:43:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33956 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261685AbVCJFhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:37:34 -0500
Message-ID: <422FDD07.9060808@pobox.com>
Date: Thu, 10 Mar 2005 00:37:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: netdev-2.6 queue updated
Content-Type: multipart/mixed;
 boundary="------------020605000903000002010804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605000903000002010804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All the stuff that was waiting for Linus has been sent.  Here's what's 
sitting around in the netdev-2.6 to "stew" for a bit:

* wireless-2.6 tree (bk://gkernel.bkbits.net/wireless-2.6)
* 8139cp updates
* starfire update
* 8139too iomap conversion
* natsemi long/short cable option (no longer needed?)
* new skge driver from Stephen Hemminger

BK URL, Patch URL, and changelog attached.

Note that the patch is diff'd against 2.6.11-bk6, which will not exist 
until four hours after this email is sent.

	Jeff



--------------020605000903000002010804
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.11-bk6-netdev1.patch.bz2

This will update the following files:

 drivers/net/wireless/ieee802_11.h               |   78 
 MAINTAINERS                                     |    7 
 drivers/net/8139cp.c                            |  100 
 drivers/net/8139too.c                           |  194 -
 drivers/net/Kconfig                             |   12 
 drivers/net/Makefile                            |    1 
 drivers/net/natsemi.c                           |   11 
 drivers/net/skge.c                              | 3385 ++++++++++++++++++++++
 drivers/net/skge.h                              | 3005 +++++++++++++++++++
 drivers/net/starfire.c                          |  142 
 drivers/net/starfire_firmware.h                 |  346 ++
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/Makefile                   |    2 
 drivers/net/wireless/atmel.c                    |   62 
 drivers/net/wireless/hostap/Kconfig             |  104 
 drivers/net/wireless/hostap/Makefile            |    8 
 drivers/net/wireless/hostap/hostap.c            | 1205 +++++++
 drivers/net/wireless/hostap/hostap.h            |   57 
 drivers/net/wireless/hostap/hostap_80211.h      |  107 
 drivers/net/wireless/hostap/hostap_80211_rx.c   | 1080 +++++++
 drivers/net/wireless/hostap/hostap_80211_tx.c   |  522 +++
 drivers/net/wireless/hostap/hostap_ap.c         | 3259 +++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_ap.h         |  272 +
 drivers/net/wireless/hostap/hostap_common.h     |  556 +++
 drivers/net/wireless/hostap/hostap_config.h     |   86 
 drivers/net/wireless/hostap/hostap_crypt.c      |  167 +
 drivers/net/wireless/hostap/hostap_crypt.h      |   50 
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |  486 +++
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |  696 ++++
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |  281 +
 drivers/net/wireless/hostap/hostap_cs.c         |  785 +++++
 drivers/net/wireless/hostap/hostap_download.c   |  761 +++++
 drivers/net/wireless/hostap/hostap_hw.c         | 3607 +++++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_info.c       |  469 +++
 drivers/net/wireless/hostap/hostap_ioctl.c      | 3624 ++++++++++++++++++++++++
 drivers/net/wireless/hostap/hostap_pci.c        |  452 ++
 drivers/net/wireless/hostap/hostap_plx.c        |  611 ++++
 drivers/net/wireless/hostap/hostap_proc.c       |  466 +++
 drivers/net/wireless/hostap/hostap_wlan.h       | 1071 +++++++
 drivers/net/wireless/orinoco.c                  |   11 
 drivers/net/wireless/wl3501.h                   |    4 
 include/linux/pci_ids.h                         |    3 
 include/net/ieee80211.h                         |  887 +++++
 include/net/ieee80211_crypt.h                   |   86 
 net/Kconfig                                     |    2 
 net/Makefile                                    |    1 
 net/ieee80211/Kconfig                           |   67 
 net/ieee80211/Makefile                          |   11 
 net/ieee80211/ieee80211_crypt.c                 |  259 +
 net/ieee80211/ieee80211_crypt_ccmp.c            |  470 +++
 net/ieee80211/ieee80211_crypt_tkip.c            |  708 ++++
 net/ieee80211/ieee80211_crypt_wep.c             |  272 +
 net/ieee80211/ieee80211_module.c                |  268 +
 net/ieee80211/ieee80211_rx.c                    | 1206 +++++++
 net/ieee80211/ieee80211_tx.c                    |  448 ++
 net/ieee80211/ieee80211_wx.c                    |  471 +++
 56 files changed, 32947 insertions(+), 356 deletions(-)

through these ChangeSets:

<jketreno:linux.intel.com>:
  o ieee80211 subsystem

<mgalgoci:parcelfarce.linux.theplanet.co.uk>:
  o wireless-2.6 cleanup

<philipp.gortan:tttech.com>:
  o [netdrvr 8139cp] add PCI ID

Adrian Bunk:
  o net/ieee80211/Kconfig: don't describe what gets selected

Alexander Viro:
  o hostap __user annotations

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o ieee80211: offset_in_page() removal
  o ieee80211: C99 initialization for eap_types
  o ieee80211: failure of ieee80211_crypto_init()
  o 8139cp: SG support fixes

Greg Kroah-Hartman:
  o net drivers: convert pci_dev->slot_name usage to pci_name()

Jeff Garzik:
  o [netdrvr starfire] Add GPL'd firmware, remove compat code
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

Olaf Kirch:
  o natsemi: long cable, short cable

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


--------------020605000903000002010804--
