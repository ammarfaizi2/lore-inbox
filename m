Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWACQl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWACQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWACQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:41:26 -0500
Received: from havoc.gtf.org ([69.61.125.42]:30594 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751455AbWACQlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:41:25 -0500
Date: Tue, 3 Jan 2006 11:41:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20060103164122.GA316@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just sent this to Andrew and Linus:

Please pull from 'upstream' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/sk98lin/skproc.c              |  265 --
 drivers/net/wan/lmc/lmc_prot.h            |   15 
 Documentation/networking/gianfar.txt      |   72 
 drivers/net/8139too.c                     |   86 
 drivers/net/Kconfig                       |   17 
 drivers/net/Makefile                      |    7 
 drivers/net/bonding/Makefile              |    2 
 drivers/net/bonding/bond_3ad.c            |  106 
 drivers/net/bonding/bond_3ad.h            |   13 
 drivers/net/bonding/bond_alb.c            |   75 
 drivers/net/bonding/bond_alb.h            |    9 
 drivers/net/bonding/bond_main.c           |  781 +------
 drivers/net/bonding/bond_sysfs.c          | 1358 ++++++++++++
 drivers/net/bonding/bonding.h             |   52 
 drivers/net/chelsio/sge.c                 |   19 
 drivers/net/chelsio/sge.h                 |    2 
 drivers/net/e1000/e1000.h                 |    4 
 drivers/net/e1000/e1000_ethtool.c         |  111 -
 drivers/net/e1000/e1000_hw.c              |   67 
 drivers/net/e1000/e1000_hw.h              |    4 
 drivers/net/e1000/e1000_main.c            |   64 
 drivers/net/gianfar.c                     |  233 +-
 drivers/net/gianfar.h                     |   69 
 drivers/net/gianfar_ethtool.c             |    2 
 drivers/net/gianfar_mii.h                 |    1 
 drivers/net/gianfar_sysfs.c               |  311 ++
 drivers/net/ixp2000/Kconfig               |    6 
 drivers/net/ixp2000/Makefile              |    3 
 drivers/net/ixp2000/caleb.c               |  137 +
 drivers/net/ixp2000/caleb.h               |   22 
 drivers/net/ixp2000/enp2611.c             |  245 ++
 drivers/net/ixp2000/ixp2400-msf.c         |  213 +
 drivers/net/ixp2000/ixp2400-msf.h         |  115 +
 drivers/net/ixp2000/ixp2400_rx.uc         |  408 +++
 drivers/net/ixp2000/ixp2400_rx.ucode      |  130 +
 drivers/net/ixp2000/ixp2400_tx.uc         |  272 ++
 drivers/net/ixp2000/ixp2400_tx.ucode      |   98 
 drivers/net/ixp2000/ixpdev.c              |  421 +++
 drivers/net/ixp2000/ixpdev.h              |   27 
 drivers/net/ixp2000/ixpdev_priv.h         |   57 
 drivers/net/ixp2000/pm3386.c              |  334 +++
 drivers/net/ixp2000/pm3386.h              |   28 
 drivers/net/s2io.c                        |  200 +
 drivers/net/s2io.h                        |    3 
 drivers/net/sis900.c                      |   73 
 drivers/net/sis900.h                      |   45 
 drivers/net/sk98lin/Makefile              |    3 
 drivers/net/sk98lin/h/skdrv2nd.h          |    9 
 drivers/net/sk98lin/h/skvpd.h             |    8 
 drivers/net/sk98lin/skethtool.c           |   48 
 drivers/net/sk98lin/skge.c                |  212 -
 drivers/net/skge.c                        |   80 
 drivers/net/skge.h                        |   73 
 drivers/net/sky2.c                        | 3262 ++++++++++++++++++++++++++++++
 drivers/net/sky2.h                        | 1922 +++++++++++++++++
 drivers/net/wireless/Kconfig              |    6 
 drivers/net/wireless/airo.c               |   15 
 drivers/net/wireless/atmel.c              | 1490 +++++++------
 drivers/net/wireless/hostap/Makefile      |    1 
 drivers/net/wireless/hostap/hostap_main.c |    0 
 drivers/net/wireless/ipw2100.c            |   40 
 drivers/net/wireless/ipw2100.h            |    2 
 drivers/net/wireless/ipw2200.c            |   21 
 drivers/net/wireless/ipw2200.h            |    6 
 include/linux/netdevice.h                 |   11 
 net/core/dev.c                            |    3 
 net/core/utils.c                          |    2 
 67 files changed, 11405 insertions(+), 2391 deletions(-)

Adrian Bunk:
      drivers/net/sk98lin/skge.c: make SkPciWriteCfgDWord() a static inline
      hostap: rename hostap.c to hostap_main.c

Ananda Raju:
      s2io: UFO support

Andrew Morton:
      sky2 needs dma_mapping.h
      git-netdev-all: s2io warning fix

Andy Fleming:
      Gianfar update and sysfs support

Brice Goglin:
      Duplicate IPW_DEBUG option for ipw2100 and 2200

Carlo Perassi:
      atmel: CodingStyle cleanup

Christophe Lucas:
      atmel: audit return code of create_proc_read_entry

Dan Streetman:
      airo.c: add support for IW_ENCODE_TEMP (i.e. xsupplicant)

Daniele Venzano:
      Add Wake on LAN support to sis900 (2)

Jeff Garzik:
      [netdrvr 8139too] replace hand-crafted kernel thread with workqueue
      [netdrvr 8139too] use cancel_rearming_delayed_work() to cancel thread
      [netdrvr 8139too] use rtnl_shlock_nowait() rather than rtnl_lock_interruptible()
      [netdrvr 8139too] fast poll for thread, if an unlikely race occurs
      [bonding] Remove superfluous changelog.

Jeff Kirsher:
      e1000: Fixes for 8357x

Jens Osterkamp:
      spidernet: fix Kconfig after BPA->CELL rename

John W. Linville:
      skge: fix warning from inlining SkPciWriteCfgDWord()
      e1000: avoid leak when e1000_setup_loopback_test fails
      e1000: zero-out pointers in e1000_free_desc_rings

Lennert Buytenhek:
      intel ixp2000 network driver
      ixp2000: register netdevices last
      pm3386: zero stats properly
      pm3386: remove unnecessary udelays
      caleb/pm3386: include proper header files
      ixp2000: use netif_rx_schedule_test
      enp2611: don't check netif_running() in link status timer
      enp2611: use 'dev' in link status timer
      enp2611: report link up/down events
      ixp2000: report MAC addresses for each port on init
      pm3386: add hook for setting MAC address
      pm3386: add hook for setting carrier
      pm3386: implement reset
      enp2611: disable/enable SERDES carrier on interface down/up
      ixp2000: add netpoll support
      ixp2000: add driver version, bump version to 0.2

Mitch Williams:
      net: allow newline terminated IP addresses in in_aton
      net: make dev_valid_name public
      bonding: add bond name to all error messages
      bonding: expand module param descriptions
      bonding: Add transmit policy to /proc
      bonding: get slave name from actual slave instead of param list
      bonding: move kmalloc out of spinlock in ALB init
      bonding: explicitly clear RLB flag during ALB init
      bonding: expose some structs
      bonding: make functions not static
      bonding: move bond creation into separate function
      bonding: make bond_init not __init
      bonding: Allow ARP target table to have empty entries
      bonding: add ARP entries to /proc
      bonding: add sysfs functionality to bonding (large)
      bonding: version update
      bonding: spelling and whitespace corrections
      bonding: comments and changelog

shemminger@osdl.org:
      sky2: changing mtu doesn't have to reset link
      sky2: cleanup interrupt processing
      sky2: add hardware VLAN acceleration support
      sky2: explicit set power state
      sky2: version 0.6
      sky2: remove unused definitions
      sky2: use kzalloc
      sky2: spelling fixes
      sky2: fix NAPI and receive handling
      sky2: version 0.7
      sky2: eliminate special case for EC-A1
      sky2: add MII support
      sky2: fix receive flush/pause issues
      sky2: improve receive performance
      sky2: add Yukon-EC ultra support
      sky2: handle DMA boundary crossing
      sky2: change netif_rx_schedule_test to __netif_schedule_prep
      sky2: race with MTU change
      sky2: dual port tx completion
      sky2: byteorder annotation
      sky2: remove pci-express hacks
      sky2: use pci_register_driver
      sky2: update version number
      sk98lin: allow ethtool checksum on/off per port
      sk98lin: remove redundant fields in device info
      sk98lin: remove /proc interface

Stephen Hemminger:
      sky2: new experimental Marvell Yukon2 driver
      sky2: driver update.
      sky2: fix FIFO DMA alignment problems
      sky2: allow ethtool debug access to all of PCI space
      sky2: version 0.5
      sky2: nway reset (BONUS FEATURE)
      sky2: add permanent address support.
      ixp2000: change netif_schedule_test to __netif_schedule_prep
      sky2: interrupt not cleared.
      sky2: don't die if we see chip rev 0xb5
      sky2: device structure alignment
      sky2: copy threshold as module parameter
      sky2: ethtool get/set interrupt coalescing
      sky2: phy processing in workqueue rather than tasklet
      sky2: no irq disable needed during tx
      sky2: ring distance optimization
      sky2: map length optimization
      sky2: tx/rx ring data structure split
      sky2: transmit logic fixes
      sky2: transmit complete index optimization
      sky2: transmit complete routine optimization
      sky2: interrupt/poll optimization
      sky2: interrupt coalescing tuning
      sky2: handle tx timeout
      sky2: quiet ring full message in case of race
      sky2: prefetch tuning
      sky2: turn on tx flow control
      sky2: disable rx checksum on Yukon XL
      sky2: version 0.10
      chelsio: transmit routine return values
      skge: avoid up/down on speed changes
      skge: avoid up/down on pause param changes
      skge: handle out of memory on MTU size changes
      skge: get rid of Yukon2 defines
      skge: handle out of memory on ring parameter change
      skge: version number (1.3)
      skge: error handling on resume
      sky2: handle out of memory on admin changes
      sky2: don't lose multicast addresses
      sky2: handle hardware packet overrun
      sky2: version 0.11

Takis:
      ipw2200: kzalloc conversion and Kconfig dependency fix

Tobias Klauser:
      Remove drivers/net/wan/lmc/lmc_prot.h

