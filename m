Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUJOQ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUJOQ2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUJOQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:26:45 -0400
Received: from havoc.gtf.org ([69.28.190.101]:47035 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268144AbUJOQWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:22:07 -0400
Date: Fri, 15 Oct 2004 12:22:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ganesh.venkatesan@intel.com
Subject: [BK PATCHES] netdev-2.6 queue updated
Message-ID: <20041015162205.GA30722@havoc.gtf.org>
Reply-To: netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For anybody submitting netdev patches, it is preferred to diff against
the patch below, or akpm's -mm tree, as quite a pile of patches has
appeared...

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.9-rc4-bk3-netdev1.patch.bz2

This will update the following files:

 arch/cris/arch-v10/drivers/ethernet.c         |  140 ++--
 drivers/ieee1394/eth1394.c                    |   95 +--
 drivers/media/dvb/dvb-core/dvb_net.c          |    9 
 drivers/net/3c509.c                           |  151 +----
 drivers/net/8139cp.c                          |  100 ++-
 drivers/net/8139too.c                         |   14 
 drivers/net/Kconfig                           |   45 -
 drivers/net/acenic.c                          |  171 ++---
 drivers/net/acenic.h                          |   23 
 drivers/net/acenic_firmware.h                 |    2 
 drivers/net/amd8111e.c                        |  248 +++-----
 drivers/net/atp.c                             |    2 
 drivers/net/b44.c                             |  102 ++-
 drivers/net/b44.h                             |  113 ---
 drivers/net/defxx.c                           |  144 ++--
 drivers/net/defxx.h                           |    2 
 drivers/net/dl2k.c                            |  267 ++++-----
 drivers/net/e100.c                            |   38 -
 drivers/net/e1000/e1000.h                     |    2 
 drivers/net/e1000/e1000_ethtool.c             |    6 
 drivers/net/e1000/e1000_hw.c                  |  115 +++
 drivers/net/e1000/e1000_main.c                |   41 -
 drivers/net/e1000/e1000_osdep.h               |    6 
 drivers/net/e1000/e1000_param.c               |  167 +++--
 drivers/net/eepro100.c                        |  425 ++++++--------
 drivers/net/ewrk3.c                           |  326 +++++------
 drivers/net/forcedeth.c                       |  142 ++--
 drivers/net/hamachi.c                         |  157 ++---
 drivers/net/hamradio/hdlcdrv.c                |    2 
 drivers/net/ibmlana.c                         |    9 
 drivers/net/iseries_veth.c                    |   81 +-
 drivers/net/ixgb/ixgb_ethtool.c               |  494 +++++------------
 drivers/net/ixgb/ixgb_main.c                  |   34 -
 drivers/net/mac8390.c                         |    4 
 drivers/net/meth.c                            |   26 
 drivers/net/natsemi.c                         |  273 ++++-----
 drivers/net/ne2k-pci.c                        |   31 +
 drivers/net/ns83820.c                         |  173 ++++-
 drivers/net/pcmcia/smc91c92_cs.c              |  181 +++---
 drivers/net/r8169.c                           |  752 +++++++++++++++++++-------
 drivers/net/sis900.c                          |  276 +++++----
 drivers/net/sk_mca.c                          |    9 
 drivers/net/smc91x.c                          |  484 ++++++++--------
 drivers/net/smc91x.h                          |   76 ++
 drivers/net/starfire.c                        |  191 +++---
 drivers/net/sundance.c                        |  187 ++----
 drivers/net/tulip/de2104x.c                   |    3 
 drivers/net/tulip/de4x5.c                     |    2 
 drivers/net/tulip/tulip_core.c                |   55 -
 drivers/net/tulip/winbond-840.c               |    2 
 drivers/net/tulip/xircom_cb.c                 |   14 
 drivers/net/tulip/xircom_tulip_cb.c           |  194 +++---
 drivers/net/typhoon.c                         |  232 +++-----
 drivers/net/wan/lmc/lmc_main.c                |    9 
 drivers/net/wireless/airo.c                   |   45 +
 drivers/net/wireless/netwave_cs.c             |   12 
 drivers/net/wireless/prism54/isl_38xx.c       |   15 
 drivers/net/wireless/prism54/isl_38xx.h       |    4 
 drivers/net/wireless/prism54/isl_ioctl.c      |  639 +++++++++++++++++++---
 drivers/net/wireless/prism54/isl_ioctl.h      |    2 
 drivers/net/wireless/prism54/isl_oid.h        |    9 
 drivers/net/wireless/prism54/islpci_dev.c     |   49 +
 drivers/net/wireless/prism54/islpci_dev.h     |    4 
 drivers/net/wireless/prism54/islpci_eth.c     |    5 
 drivers/net/wireless/prism54/islpci_hotplug.c |    3 
 drivers/net/wireless/prism54/islpci_mgt.c     |    1 
 drivers/net/wireless/prism54/islpci_mgt.h     |    2 
 drivers/net/wireless/prism54/oid_mgt.c        |  126 +++-
 drivers/net/wireless/prism54/oid_mgt.h        |    5 
 drivers/net/wireless/wavelan.c                |   19 
 drivers/net/wireless/wavelan.p.h              |    3 
 drivers/net/wireless/wavelan_cs.c             |  181 ++----
 drivers/net/wireless/wavelan_cs.p.h           |    3 
 drivers/net/wireless/wl3501_cs.c              |   53 -
 drivers/net/yellowfin.c                       |   62 --
 drivers/usb/gadget/ether.c                    |   73 --
 drivers/usb/net/catc.c                        |  122 +---
 drivers/usb/net/kaweth.c                      |   34 -
 drivers/usb/net/pegasus.c                     |  297 ++++------
 drivers/usb/net/rtl8150.c                     |  186 ++----
 include/linux/netdevice.h                     |    4 
 include/linux/wireless.h                      |   64 +-
 include/net/iw_handler.h                      |   60 +-
 net/core/dev.c                                |    2 
 net/core/wireless.c                           |  210 +++++--
 net/irda/irlan/irlan_client.c                 |    2 
 86 files changed, 4818 insertions(+), 4325 deletions(-)

through these ChangeSets:

<jolt:tuxbox.org>:
  o [netdrvr b44] clean up SiliconBackplane definitions/functions
  o [netdrvr b44] ignore carrier lost errors

<pekon:fi.muni.cz>:
  o netpoll with xircom_cb

<sfeldma:pobox.com>:
  o janitor: net/tulip: pci_find_device to pci_dev_present
  o janitor: net/sis900: pci_find_device to pci_get_device

Alexander Viro:
  o (27/27) catc ethtool conversion
  o (26/27) kaweth ethtool conversion
  o (25/27) pegasus ethtool conversion
  o (24/27) rtl8150 ethtool conversion
  o (23/27) gadget ethtool conversion
  o (22/27) amd8111e ethtool conversion
  o (21/27) dl2k ethtool conversion
  o (20/27) eepro100 ethtool conversion
  o (19/27) ewrk3 ethtool conversion
  o (18/27) forcedeth ethtool conversion
  o (17/27) hamachi ethtool conversion
  o (16/27) veth ethtool conversion
  o (15/27) natsemi ethtool conversion
  o (14/27) ns83820 ethtool conversion
  o (13/27) starfire ethtool conversion
  o (12/27) sundance ethtool conversion
  o (11/27) typhoon ethtool conversion
  o (10/27) yellowfin ethtool conversion
  o (9/27) wl3501_cs ethtool conversion
  o (8/27) wavelan ethtool conversion
  o (7/27) xircom ethtool conversion
  o (6/27) tulip ethtool conversion
  o (5/27) smc91c92_cs ethtool conversion
  o (4/27) 3c509 ethtool conversion
  o (3/27) ixgb ethtool conversion
  o (2/27) cris ethtool conversion
  o (1/27) eth1394 ethtool conversion
  o [netdrvr starfire] use netdev_priv
  o [netdrvr starfire] fix unregister_netdev call site
  o [netdrvr] use netdev_priv in dl2k, hamachi
  o [netdrvr] netdev_priv for sundance, typhoon, yellowfin
  o [netdrvr] netdev_priv for ewrk3, xircom_tulip_cb, wavelan_cs
  o [netdrvr usb] use netdev_priv
  o [netdrvr eth1394] use netdev_priv

Andrew Morton:
  o e1000 sparc64 dma_mapping build fix
  o igxb speedup
  o pegasus.c fixes
  o de4x5 warning fix

Anton Blanchard:
  o fix acenic hotplug

Daniele Venzano:
  o [netdrvr sis900] whitespace and codingstyle updates

David Dillow:
  o PCI cleanups and convert to ethtool_ops

David S. Miller:
  o eepro100.c iomap conversion

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o r8169: cleanup
  o r8169: rtl8169_close() races
  o r8169: automatic pci dac step down
  o r8169: wrong advertisement of VLAN features
  o r8169: Tx timeout rework
  o via-velocity: wrong module name in Kconfig documentation
  o r8169: default on disabling PCIDAC
  o r8169: Mac identifier extracted from Realtek's driver v2.2
  o r8169: TSO support
  o r8169: hint for Tx flow control
  o r8169: miscalculation of available Tx descriptors
  o 8139cp: SG support fixes
  o r8169: vlan support
  o r8169: Rx checksum support
  o r8169: advertise DMA to high memory
  o r8169: Tx checksum offload
  o r8169: comment a gcc 2.95.x bug
  o r8169: sync the names of a few bits with the 8139cp driver
  o r8169: bump version number
  o r8169: enable MWI
  o r8169: code cleanup
  o r8169: per device receive buffer size
  o r8169: add ethtool_ops.{get_regs_len/get_regs}

Ganesh Venkatesan:
  o e1000 update -- fix MODULE_PARM, module_param, module_param_array
  o e1000 - Ethtool -- 82545 do not support WoL
  o e1000 - Polarity reversal workaround for 10F/10H links
  o e1000 - Fix VLAN filter setup errors (while running on PPC)
  o e1000 Check value returned by from pci_enable_device
  o e1000 - Removed support for advanced TCO features
  o e1000 - use pci_device_name for syslog messages till registering netdevice.
  o e100 driver version number update
  o e100 - use NET_IP_ALIGN to set rx data buffer alignment
  o e100 - Use pci_device_name for syslog messages till registering netdevice

Hirokazu Takata:
  o m32r: trivial fix of smc91x.h

Jean Tourrilhes:
  o WE-17 typo fix
  o wireless-drivers-update-for-we-17.patch
  o wireless-extension-v17-for-linus.patch

Jeff Garzik:
  o Hand-merge typhoon conflicts
  o [netdrvr eepro100] fix pci_iomap() args and info msg that follows
  o [netdrvr b44] update MODULE_AUTHORS
  o [netdrvr 8139cp] TSO support
  o [netdev] Remove no-op in-driver implementations of ->set_config()

Jesse Brandeburg:
  o e100: whitespace and DPRINTKS
  o e100: fix NAPI race with watchdog
  o ixgb: fix endianness issue for tx cleanup

Kenji Kaneshige:
  o add missing pci_disable_device for e1000

Maciej W. Rozycki:
  o defxx device name fixes
  o defxx trivial updates

Manfred Spraul:
  o rx checksum support for gige nForce ethernet

Marc Singer:
  o adding smc91x ethernet to lpd7a40x

Margit Schubert-While:
  o prism54 bug initialization/mgt_commit
  o prism54 print firmware version
  o prism54 Bug in timeout scheduling
  o prism54 remove TRACE
  o prism54 fix wpa_supplicant frequency parsing
  o prism54 initial WPA support
  o prism54 add WE17 support
  o prism54 remove module params
  o prism54 Code cleanup

Mika Kukkonen:
  o sparse: fix warnings in net/irda/*

Neil Horman:
  o ns83820: add vlan tag hardware acceleration support

Nicolas Pitre:
  o smc91x: release on-chip RX packet memory ASAP
  o smc91x: receives two bytes too many
  o smc91x: fix compilation with DMA on PXA2xx
  o smc91x: more SMP locking fixes
  o smc91x: fix SMP lock usage
  o smc91x: cosmetics
  o smc91x: straighten SMP locking
  o smc91x: display pertinent register values from the  timeout function
  o smc91x: fix possible leak of the skb waiting for mem  allocation
  o smc91x: use a work queue to reconfigure the phy from  smc_timeout()
  o smc91x: move TX processing out of IRQ context entirely
  o smc91x: simplify register bank usage
  o smc91x: fold smc_setmulticast() into smc_set_multicast_list()
  o smc91x: set the MAC addr from the smc_enable function
  o smc91x: Assorted minor cleanups
  o smc91x: Revert 1.1923.3.58: "m32r: modify drivers/net/smc91x.c for m32r"

Nishanth Aravamudan:
  o net/de2104x: replace schedule_timeout() with msleep()

Olaf Hering:
  o remove old version check from mac8390

Pavel Machek:
  o swsuspend for ne2k-pci cards

Pekka Pietikäinen:
  o b44: use bounce buffers to workaround chip DMA bug/limitations

Ralf Bächle:
  o Stop queue on close in hdlcdrv

Rene Herman:
  o 8139too Interframe Gap Time

Roger Luethi:
  o mc_filter on big-endian arch

Steffen Klassert:
  o 8139cp - add netpoll support

Stephen Hemminger:
  o 8139cp - module_param
  o (4/4) acenic - don't spin forever in hard_start_xmit
  o (3/4) acenic - __iomem warnings cleanup
  o (2/4) acenic - eliminate MAX_SKB_FRAGS #if
  o (1/4) acenic - use netdev_priv

