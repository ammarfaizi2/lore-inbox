Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVAGLeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVAGLeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAGLen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:34:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261343AbVAGLeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:34:21 -0500
Message-ID: <41DE73B5.6080303@pobox.com>
Date: Fri, 07 Jan 2005 06:34:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: Netdev <netdev@oss.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: netdev-2.6 queue updated
Content-Type: multipart/mixed;
 boundary="------------080005030005030704040103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005030005030704040103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A bunch of stuff was merged upstream, and a bunch of new stuff was 
merged into netdev-2.6.  See attached changelog for details, BK and 
patch URLs.

BK NOTE:  BK users should re-clone netdev-2.6, do not simply 'bk pull'.


--------------080005030005030704040103
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.10-bk10-netdev1.patch.bz2

This will update the following files:

 Documentation/networking/e100.txt               |   12 
 Documentation/networking/e1000.txt              |   40 
 MAINTAINERS                                     |    7 
 drivers/net/3c509.c                             |   19 
 drivers/net/8139cp.c                            |  102 
 drivers/net/8139too.c                           |  291 -
 drivers/net/arcnet/arc-rawmode.c                |    4 
 drivers/net/arcnet/arc-rimi.c                   |   14 
 drivers/net/arcnet/arcnet.c                     |   30 
 drivers/net/arcnet/com20020.c                   |    6 
 drivers/net/arcnet/com90io.c                    |    4 
 drivers/net/arcnet/com90xx.c                    |    8 
 drivers/net/arcnet/rfc1051.c                    |    8 
 drivers/net/arcnet/rfc1201.c                    |   12 
 drivers/net/atp.c                               |    2 
 drivers/net/bmac.c                              |   68 
 drivers/net/e100.c                              |   19 
 drivers/net/e1000/e1000_ethtool.c               |   68 
 drivers/net/e1000/e1000_hw.c                    |  125 
 drivers/net/e1000/e1000_hw.h                    |    8 
 drivers/net/e1000/e1000_main.c                  |  220 
 drivers/net/e1000/e1000_osdep.h                 |    9 
 drivers/net/e1000/e1000_param.c                 |    8 
 drivers/net/es3210.c                            |   32 
 drivers/net/ewrk3.c                             |   84 
 drivers/net/fealnx.c                            |  275 -
 drivers/net/forcedeth.c                         |  305 +
 drivers/net/hamachi.c                           |   81 
 drivers/net/ibm_emac/ibm_emac.h                 |    2 
 drivers/net/ibm_emac/ibm_emac_core.c            |   15 
 drivers/net/ibm_emac/ibm_emac_phy.c             |   19 
 drivers/net/myri_sbus.c                         |   10 
 drivers/net/pcmcia/ibmtr_cs.c                   |    7 
 drivers/net/r8169.c                             |  100 
 drivers/net/s2io.c                              |  126 
 drivers/net/s2io.h                              |   19 
 drivers/net/smc-mca.c                           |   37 
 drivers/net/smc-ultra.c                         |   34 
 drivers/net/smc-ultra32.c                       |   30 
 drivers/net/smc91x.c                            |   16 
 drivers/net/tokenring/ibmtr.c                   |  158 
 drivers/net/tulip/media.c                       |   37 
 drivers/net/tulip/timer.c                       |    1 
 drivers/net/tulip/tulip.h                       |    8 
 drivers/net/tulip/tulip_core.c                  |   42 
 drivers/net/tulip/winbond-840.c                 |    2 
 drivers/net/tulip/xircom_tulip_cb.c             |   19 
 drivers/net/tun.c                               |  151 
 drivers/net/typhoon-firmware.h                  | 5568 ++++++++++--------------
 drivers/net/typhoon.c                           |  244 -
 drivers/net/via-rhine.c                         |    2 
 drivers/net/via-velocity.c                      |    6 
 drivers/net/wd.c                                |   36 
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/Makefile                   |    2 
 drivers/net/wireless/airport.c                  |    5 
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
 drivers/net/wireless/orinoco.c                  |  203 
 drivers/net/wireless/orinoco_cs.c               |   10 
 drivers/net/wireless/orinoco_pci.c              |    7 
 drivers/net/wireless/orinoco_plx.c              |   82 
 drivers/net/wireless/orinoco_tmd.c              |   51 
 include/linux/ibmtr.h                           |   15 
 include/linux/if_tun.h                          |    5 
 include/linux/pci_ids.h                         |    6 
 91 files changed, 25371 insertions(+), 4454 deletions(-)

through these ChangeSets:

<alex.kern:gmx.de>:
  o new PCI_ID for tulip

<gortan:tttech.com>:
  o 8139cp: support for TTTech MC322

<philipp.gortan:tttech.com>:
  o [netdrvr 8139cp] add PCI ID

<raghavendra.koushik:s2io.com>:
  o S2io: fixes in free_shared_mem function

Alan Cox:
  o ULi support for 526X tulip variants

Alexander Viro:
  o s2io iomem annotations and cleanups
  o bmac iomem annotations
  o hamachi iomem annotations
  o miri_sbus iomem annotations
  o es3210 iomem annotions and isa-ectomy
  o ewrk3 iomem annotations + isa-ectomy
  o wd iomem annotations + isa-ectomy
  o smc-ultra32 iomem annotations + isa-ectomy
  o smc-ultra iomem annotations + isa-ectomy
  o smc-mca iomem annotations and isa-ectomy
  o fealnx iomem annotations, switch to io{read,write}
  o wireless iomem annotations and fixes, switch to io{read,write}
  o ibmtr annotations - the rest
  o beginning of ibmtr iomem annotations

Andi Kleen:
  o Fix ADMtek Comet on x86-64

Andrew Morton:
  o xircom_tulip_cb.c build fix
  o via-rhine warning fix

Con Kolivas:
  o net: Netconsole poll support for 3c509

David Dillow:
  o Bump version and release date
  o Version 03.001.008 of the Typhoon firmware, courtesy of 3Com
  o Fixup the version reporting to match 3Com
  o Use module_param() and add descriptions
  o Teach typhoon to use port IO on machines that need it. It will attempt to use MMIO, but if that fails (or the user asks), it will fallback to port IO.
  o Enable bus mastering before saving our state, or we'll only be able to load the modules one time.

David Gibson:
  o Another trivial orinoco update

Domen Puncer:
  o arcnet: remove casts

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o r8169: oversized driver field for ethtool
  o r8169: reduce max MTU for large frames
  o r8169: Large Send enablement
  o r8169: C 101
  o r8169: missing netif_poll_enable and irq ack
  o 8139cp: SG support fixes

Ganesh Venkatesan:
  o e100: Documentation/networking/e100.txt update
  o e1000: Documentation/networking/e1000.txt update
  o e1000: Driver version number, white spaces, comments, device id & other changes
  o e1000: Applied smart speed fix where the code was forcing smart speed on all the time.  Now it will honor the setting defined in the eeprom.
  o e1000: Applied eeprom fix where it was possible to read/write
  o e1000:  Added workaround to prevent inadvertent gigabit waveform to be sent out on the wire due to init-time operations on the IGP phy.
  o e1000: Kernel API change for Module_param_array_named
  o e1000: {set, get}_wol is now symmetric for 82545EM adapters
  o e1000: Fix tx resource cleanup logic
  o e1000:  Replace schedule_timeout() with msleep()/msleep_interruptible() nacc@us.ibm.com
  o e1000: remove a redundant assignment to a local nr_frags in e1000_xmit_frame
  o e1000: Avoid filling tx_ring completely - shemminger@osdl.org
  o e1000: Enabling NETIF_F_SG without checksum offload is illegal
  o e1000: Fix ethtool diagnostics -- specifically for blade server implementations
  o e1000: Fix kernel panic when the interface is brought down while the NAPI enabled driver is under stress
  o e1000: ITR does not default correctly on 2.6.x kernels
  o e100: Update driver version number
  o e100: Sort Device IDs
  o e100: Replace locally implemented delay routines

Hirokazu Takata:
  o net: netconsole support for smc91x

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

Manfred Spraul:
  o forcedeth: add ethtool get/set_settings support

Matt Porter:
  o Add netpoll support
  o allow rx of the maximum sized VLAN tagged packets
  o EMAC: fix ibm_emac autonegotiation result parsing

Pekka Enberg:
  o 8139too: use iomap for pio/mmio

Rene Herman:
  o 8139too Interframe Gap Time

Roger Luethi:
  o mc_filter on big-endian arch

Shaun Jackman:
  o Multicast filtering for tun.c

Steffen Klassert:
  o 8139cp - add netpoll support

Stephen Hemminger:
  o via-velocity: convert to module_param
  o 8139too: use netdev_priv
  o 8139cp - module_param

Thomas Gleixner:
  o rtl8139too.c: Fix missing pci_disable_dev
  o rtl8139too.c: Fix missing pci_disable_dev


--------------080005030005030704040103--
