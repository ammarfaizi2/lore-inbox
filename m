Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbUKEKCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbUKEKCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUKEKCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:02:44 -0500
Received: from havoc.gtf.org ([69.28.190.101]:29827 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262417AbUKEKCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:02:01 -0500
Date: Fri, 5 Nov 2004 05:02:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: netdev-2.6 queue updated
Message-ID: <20041105100200.GA31755@havoc.gtf.org>
Reply-To: netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NOTE:  you will need to re-clone the netdev-2.6 tree.

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.10-rc1-bk14-netdev1.patch.bz2

This will update the following files:

 drivers/net/3c505.c                           |   10 
 drivers/net/3c507.c                           |  148 ++--
 drivers/net/3c59x.c                           |    1 
 drivers/net/8139cp.c                          |  102 ++-
 drivers/net/8139too.c                         |   98 +-
 drivers/net/8390.c                            |    1 
 drivers/net/8390.h                            |    1 
 drivers/net/Kconfig                           |   62 -
 drivers/net/ac3200.c                          |   64 -
 drivers/net/atp.c                             |    2 
 drivers/net/bonding/bond_3ad.c                |   10 
 drivers/net/depca.c                           |   24 
 drivers/net/e100.c                            |    1 
 drivers/net/e2100.c                           |   18 
 drivers/net/eepro100.c                        |  293 +++-----
 drivers/net/fealnx.c                          |  275 +++-----
 drivers/net/hp100.c                           |   65 +
 drivers/net/ixgb/ixgb_main.c                  |   33 -
 drivers/net/lne390.c                          |   64 -
 drivers/net/mace.c                            |   66 --
 drivers/net/ne3210.c                          |   34 -
 drivers/net/pcmcia/fmvj18x_cs.c               |    4 
 drivers/net/pcmcia/ibmtr_cs.c                 |    7 
 drivers/net/pcmcia/pcnet_cs.c                 |   39 -
 drivers/net/pcmcia/smc91c92_cs.c              |    2 
 drivers/net/pcmcia/xirc2ps_cs.c               |    2 
 drivers/net/r8169.c                           |  855 +++++++++++++++++++-------
 drivers/net/sb1000.c                          |   14 
 drivers/net/sis900.c                          |    1 
 drivers/net/skfp/h/fplustm.h                  |    6 
 drivers/net/skfp/h/targethw.h                 |    6 
 drivers/net/skfp/h/targetos.h                 |    2 
 drivers/net/skfp/h/types.h                    |   21 
 drivers/net/skfp/skfddi.c                     |   25 
 drivers/net/skfp/smt.c                        |    7 
 drivers/net/starfire.c                        |   79 +-
 drivers/net/sundance.c                        |  259 +++----
 drivers/net/tlan.c                            |   72 +-
 drivers/net/tlan.h                            |   88 --
 drivers/net/tokenring/3c359.c                 |   36 -
 drivers/net/tokenring/3c359.h                 |    2 
 drivers/net/tokenring/ibmtr.c                 |  158 ++--
 drivers/net/tokenring/lanstreamer.c           |   24 
 drivers/net/tokenring/lanstreamer.h           |    2 
 drivers/net/tokenring/olympic.c               |   94 +-
 drivers/net/tulip/de2104x.c                   |    1 
 drivers/net/tulip/dmfe.c                      |    1 
 drivers/net/tulip/tulip_core.c                |    3 
 drivers/net/tulip/winbond-840.c               |    3 
 drivers/net/tulip/xircom_tulip_cb.c           |   16 
 drivers/net/typhoon.c                         |    3 
 drivers/net/via-rhine.c                       |  276 ++++----
 drivers/net/via-velocity.h                    |    4 
 drivers/net/wan/c101.c                        |    3 
 drivers/net/wan/cycx_drv.c                    |   22 
 drivers/net/wan/n2.c                          |    5 
 drivers/net/wireless/airo.c                   |   69 --
 drivers/net/wireless/airport.c                |    5 
 drivers/net/wireless/arlan-main.c             |   90 +-
 drivers/net/wireless/arlan-proc.c             |   15 
 drivers/net/wireless/arlan.h                  |   26 
 drivers/net/wireless/hermes.c                 |   43 -
 drivers/net/wireless/hermes.h                 |   62 -
 drivers/net/wireless/netwave_cs.c             |   75 +-
 drivers/net/wireless/orinoco_cs.c             |   10 
 drivers/net/wireless/orinoco_pci.c            |    7 
 drivers/net/wireless/orinoco_plx.c            |   82 +-
 drivers/net/wireless/orinoco_tmd.c            |   51 -
 drivers/net/wireless/prism54/isl_ioctl.c      |   24 
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 
 drivers/net/wireless/prism54/prismcompat.h    |    4 
 drivers/net/wireless/ray_cs.c                 |    4 
 drivers/net/wireless/wavelan_cs.c             |   25 
 drivers/net/wireless/wavelan_cs.p.h           |    1 
 include/linux/delay.h                         |    5 
 include/linux/ibmtr.h                         |   15 
 include/linux/pci_ids.h                       |    3 
 include/pcmcia/mem_op.h                       |   89 +-
 78 files changed, 2239 insertions(+), 1982 deletions(-)

through these ChangeSets:

<philipp.gortan:tttech.com>:
  o [netdrvr 8139cp] add PCI ID

Adrian Bunk:
  o net/skfp/smt.c: remove an unused function
  o net/3c505.c: remove unused functions
  o bonding: remove an unused function
  o net/wan/n2.c: remove an unused function

Alexander Viro:
  o mace iomem annotations - trivial part
  o airo iomem annotations
  o wavelan_cs iomem annotations
  o lne390 iomem annotations and fixes
  o fealnx iomem annotations, switch to io{read,write}
  o wireless iomem annotations and fixes, switch to io{read,write}
  o ibmtr annotations - the rest
  o skfp iomem annotations, switch to io{read,write}
  o olympic_open() cleanup and fixes
  o sundance iomem annotations, switch to io{read,write}
  o via-rhine iomem annotations, switch to io{read,write}
  o net/pcmcia iomem annotations
  o netwave iomem annotations
  o arlan iomem annotations and cleanups
  o netdev_priv() in netwave_cs
  o netdev_priv() in arlan
  o (25/32) lanstreamer iomem annotations
  o beginning of ibmtr iomem annotations
  o e2100 iomem annotations and fixes
  o 3c359 iomem annotations
  o depca iomem annotations
  o killed isa_... in 3c507
  o starfire iomem annotations
  o ne3210 iomem annotations
  o ac3200 iomem annotations and fixes
  o iomem annotations in r8169

Andrew Morton:
  o r8169 module_param build fix

Arjan van de Ven:
  o ray_cs export cleanup

Christoph Hellwig:
  o unexport ei_tx_timeout

Daniele Venzano:
  o Add Altimata PHY to sis900 driver

David Dillow:
  o net/typhoon.c: use previously-unused function

David S. Miller:
  o eepro100.c iomap conversion

Felipe Damasio:
  o 8139cp net driver: add MODULE_VERSION

François Romieu:
  o r8169: netconsole support
  o r8169: unneeded synchronize_irq()
  o r8169: always clean Tx desc
  o r8169: cleanup
  o r8169: rtl8169_close() races
  o r8169: automatic pci dac step down
  o r8169: wrong advertisement of VLAN features
  o r8169: Tx timeout rework
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
  o ixgb: Condition that determines when to quit polling
  o ixgb: Fix memory leak in NAPI mode. Avoid unnecessary
  o ixgb: Fix VLAN filter setup errors (while running

Jeff Garzik:
  o [netdrvr eepro100] fix pci_iomap() args and info msg that follows
  o [netdrvr 8139cp] TSO support

John W. Linville:
  o tulip: Add MODULE_VERSION
  o e100: Add MODULE_VERSION
  o r8169: Add MODULE_VERSION
  o 8139too: Add MODULE_VERSION
  o 3c59x: Add MODULE_VERSION
  o r8169: simplify trick if() expression
  o r8169: fix RxVlan bit manipulation
  o r8169: endian-swap return of rtl8169_tx_vlan_tag()

Krzysztof Halasa:
  o net/wan/n2.c: remove an unused function

Margit Schubert-While:
  o prism54 sparse fixes
  o prism54 fix resume processing

Nishanth Aravamudan:
  o net/sb1000: replace nicedelay() with ssleep_interruptible()
  o net/cycx_drv: replace delay_cycx() with ssleep_interruptible()
  o net/airo: replace schedule_timeout() with *sleep() variants
  o Add ssleep_interruptible()

Rene Herman:
  o 8139too Interframe Gap Time

Roger Luethi:
  o mc_filter on big-endian arch

Steffen Klassert:
  o 8139cp - add netpoll support

Stephen Hemminger:
  o xircom_tulip_cb: convert to using module_param
  o tlan: enable faster hash function
  o tlan: make inline's static (rev2)
  o tlan: get rid of unneeded global vars (rev 2)
  o tlan: use netdev_priv (rev 2)
  o hp100: use inline for comple usage of dev->priv
  o hp100: use netdev_priv (rev 2)
  o via-velocity: get rid of unused global
  o via-rhine: free_ring should be static
  o via-rhine: use module_param
  o 8139too: use netdev_priv
  o r8169: use netdev_priv
  o r8169: use module_param
  o 8139cp - module_param

Thomas Gleixner:
  o rtl8139too.c: Fix missing pci_disable_dev
  o rtl8139too.c: Fix missing pci_disable_dev

Tom Rini:
  o IBM EMAC Kconfig changes: Add 'select CRC32'
  o IBM EMAC Kconfig changes

