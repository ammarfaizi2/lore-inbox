Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTKQAhi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTKQAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 19:37:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32957 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263244AbTKQAhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 19:37:02 -0500
Message-ID: <3FB81811.9090508@pobox.com>
Date: Sun, 16 Nov 2003 19:36:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [BK PATCHES] 2.6.x experimental net driver queue
Content-Type: multipart/mixed;
 boundary="------------070909080505000701050604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909080505000701050604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yet more updates.  Syncing with Andrew Morton, and more syncing with Al 
Viro.

No users of init_etherdev remain in the tree.  (yay!)

--------------070909080505000701050604
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5-exp

Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test9-bk21-netdrvr-exp2.patch.bz2

This will update the following files:

 drivers/net/68360enet.c                 |  951 --------------------------------
 Documentation/networking/netconsole.txt |   57 +
 drivers/net/3c501.c                     |  116 +--
 drivers/net/3c501.h                     |    1 
 drivers/net/3c503.c                     |  117 ++-
 drivers/net/3c505.c                     |  128 ++--
 drivers/net/3c507.c                     |  120 ++--
 drivers/net/3c515.c                     |  328 ++++-------
 drivers/net/3c523.c                     |  108 +--
 drivers/net/3c527.c                     |  682 ++++++++++------------
 drivers/net/3c527.h                     |    6 
 drivers/net/3c59x.c                     |   17 
 drivers/net/8139too.c                   |   51 +
 drivers/net/82596.c                     |   83 +-
 drivers/net/Kconfig                     |    9 
 drivers/net/Makefile                    |    2 
 drivers/net/Space.c                     |  583 +++++++++----------
 drivers/net/a2065.c                     |   19 
 drivers/net/ac3200.c                    |   91 ++-
 drivers/net/amd8111e.c                  |   14 
 drivers/net/apne.c                      |   77 +-
 drivers/net/appletalk/ltpc.c            |    2 
 drivers/net/ariadne.c                   |   10 
 drivers/net/arm/am79c961a.c             |    2 
 drivers/net/arm/ether00.c               |    4 
 drivers/net/arm/ether1.c                |    2 
 drivers/net/arm/ether3.c                |    2 
 drivers/net/arm/etherh.c                |    2 
 drivers/net/at1700.c                    |  166 ++---
 drivers/net/atari_bionet.c              |   62 +-
 drivers/net/atari_pamsnet.c             |   65 +-
 drivers/net/atarilance.c                |   58 +
 drivers/net/atp.c                       |   40 -
 drivers/net/au1000_eth.c                |   61 --
 drivers/net/bagetlance.c                |   77 +-
 drivers/net/cs89x0.c                    |  132 ++--
 drivers/net/de600.c                     |   59 +
 drivers/net/de600.h                     |    1 
 drivers/net/de620.c                     |   63 +-
 drivers/net/declance.c                  |   17 
 drivers/net/defxx.c                     |    2 
 drivers/net/depca.c                     |   20 
 drivers/net/dummy.c                     |    2 
 drivers/net/e100/e100_config.c          |    8 
 drivers/net/e100/e100_main.c            |   41 -
 drivers/net/e100/e100_phy.c             |   14 
 drivers/net/e1000/e1000.h               |   10 
 drivers/net/e1000/e1000_ethtool.c       |   94 ++-
 drivers/net/e1000/e1000_hw.c            |   65 +-
 drivers/net/e1000/e1000_hw.h            |    9 
 drivers/net/e1000/e1000_main.c          |  143 ++--
 drivers/net/e1000/e1000_param.c         |   45 -
 drivers/net/e2100.c                     |   88 ++
 drivers/net/eepro.c                     |  256 ++++----
 drivers/net/eepro100.c                  |   21 
 drivers/net/eexpress.c                  |   91 ++-
 drivers/net/eql.c                       |    2 
 drivers/net/es3210.c                    |   87 ++
 drivers/net/eth16i.c                    |  119 ++--
 drivers/net/ethertap.c                  |    3 
 drivers/net/ewrk3.c                     |  684 +++++++++--------------
 drivers/net/fc/iph5526.c                |    3 
 drivers/net/fc/iph5526_scsi.h           |    2 
 drivers/net/fmv18x.c                    |  111 ++-
 drivers/net/gt96100eth.c                |   49 -
 drivers/net/hamradio/baycom_epp.c       |    2 
 drivers/net/hamradio/bpqether.c         |    2 
 drivers/net/hamradio/hdlcdrv.c          |    2 
 drivers/net/hamradio/yam.c              |    2 
 drivers/net/hp-plus.c                   |   84 ++
 drivers/net/hp.c                        |   84 ++
 drivers/net/hp100.c                     |  743 +++++++++++++------------
 drivers/net/hplance.c                   |   85 +-
 drivers/net/hydra.c                     |   19 
 drivers/net/jazzsonic.c                 |   88 ++
 drivers/net/lance.c                     |  129 ++--
 drivers/net/lasi_82596.c                |   17 
 drivers/net/lne390.c                    |   88 ++
 drivers/net/mac8390.c                   |   97 +--
 drivers/net/mac89x0.c                   |   77 +-
 drivers/net/mace.c                      |   50 +
 drivers/net/macmace.c                   |   28 
 drivers/net/macsonic.c                  |  102 +--
 drivers/net/mvme147.c                   |   59 -
 drivers/net/natsemi.c                   |   39 -
 drivers/net/ne.c                        |   83 ++
 drivers/net/ne2.c                       |   82 ++
 drivers/net/ne2k_cbus.c                 |  107 ++-
 drivers/net/ne2k_cbus.h                 |    2 
 drivers/net/netconsole.c                |  120 ++++
 drivers/net/ni5010.c                    |  184 +++---
 drivers/net/ni52.c                      |  118 ++-
 drivers/net/ni65.c                      |  101 ++-
 drivers/net/ns83820.c                   |    2 
 drivers/net/oaknet.c                    |   61 --
 drivers/net/pci-skeleton.c              |    2 
 drivers/net/pcmcia/3c574_cs.c           |    7 
 drivers/net/pcmcia/3c589_cs.c           |    7 
 drivers/net/pcmcia/fmvj18x_cs.c         |    7 
 drivers/net/pcmcia/nmclan_cs.c          |    7 
 drivers/net/pcmcia/smc91c92_cs.c        |    7 
 drivers/net/pcmcia/xirc2ps_cs.c         |    7 
 drivers/net/pcnet32.c                   |   11 
 drivers/net/plip.c                      |   18 
 drivers/net/saa9730.c                   |   63 +-
 drivers/net/sb1250-mac.c                |   49 -
 drivers/net/seeq8005.c                  |   97 +--
 drivers/net/sgiseeq.c                   |   29 
 drivers/net/shaper.c                    |   11 
 drivers/net/sk_g16.c                    |  182 ++----
 drivers/net/sk_mca.c                    |  119 +---
 drivers/net/sk_mca.h                    |    3 
 drivers/net/skfp/skfddi.c               |   32 -
 drivers/net/smc-ultra.c                 |   96 ++-
 drivers/net/smc-ultra32.c               |   85 +-
 drivers/net/smc9194.c                   |  110 +--
 drivers/net/stnic.c                     |   42 -
 drivers/net/sun3_82586.c                |   72 +-
 drivers/net/sun3lance.c                 |   79 +-
 drivers/net/tc35815.c                   |  194 ++----
 drivers/net/tg3.c                       |   16 
 drivers/net/tokenring/3c359.c           |    4 
 drivers/net/tokenring/abyss.c           |    2 
 drivers/net/tokenring/madgemc.c         |    6 
 drivers/net/tokenring/proteon.c         |  184 ++----
 drivers/net/tokenring/skisa.c           |  182 ++----
 drivers/net/tokenring/smctr.c           |  194 +++---
 drivers/net/tokenring/tmspci.c          |    2 
 drivers/net/tulip/Kconfig               |   20 
 drivers/net/tulip/de2104x.c             |    2 
 drivers/net/tulip/dmfe.c                |    2 
 drivers/net/tulip/interrupt.c           |  417 ++++++++++----
 drivers/net/tulip/tulip.h               |   18 
 drivers/net/tulip/tulip_core.c          |   78 +-
 drivers/net/tulip/winbond-840.c         |    2 
 drivers/net/tulip/xircom_tulip_cb.c     |    3 
 drivers/net/tun.c                       |   18 
 drivers/net/wan/lmc/lmc_main.c          |  375 ++++--------
 drivers/net/wan/lmc/lmc_var.h           |   15 
 drivers/net/wan/x25_asy.c               |    2 
 drivers/net/wd.c                        |   89 ++
 drivers/net/wireless/arlan-main.c       |  283 +++------
 drivers/net/wireless/arlan.h            |    6 
 drivers/net/wireless/atmel.c            |    2 
 drivers/net/wireless/strip.c            |    2 
 drivers/net/wireless/wavelan.c          |  251 +++-----
 drivers/net/wireless/wavelan.p.h        |   58 -
 drivers/net/wireless/wavelan_cs.c       |  113 +--
 drivers/net/wireless/wavelan_cs.p.h     |   49 -
 drivers/net/znet.c                      |   36 -
 drivers/net/zorro8390.c                 |   19 
 drivers/usb/gadget/ether.c              |    2 
 include/linux/netdevice.h               |   18 
 include/linux/netpoll.h                 |   38 +
 include/linux/pci_ids.h                 |    2 
 net/Kconfig                             |   20 
 net/core/Makefile                       |    1 
 net/core/dev.c                          |   39 +
 net/core/netpoll.c                      |  636 +++++++++++++++++++++
 net/wanrouter/wanmain.c                 |    2 
 160 files changed, 7103 insertions(+), 6452 deletions(-)

through these ChangeSets:

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1522)
   [netdrvr lasi_82596] remove ether_setup() call, fix leak in probe

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1521)
   [netdrvr] alloc_etherdev-related cleanups
   
   Mostly removing unneeded calls to ether_setup(), which alloc_etherdev()
   already does for us.

<jgarzik@redhat.com> (03/11/16 1.1520)
   [netdrvr 3c527] applied missing pieces of Richard Proctor's 3c527 SMP update
   
   Minor stuff... remove unused constants, and mark non-experimental
   and non-broken in Kconfig.

<jgarzik@redhat.com> (03/11/16 1.1519)
   [netdrvr tulip] clean up tulip NAPI poll disable
   
   Looks like the same patch was applied multiple times.  No negative
   effects except ugliness and a redundant test.

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1518)
   [netdrvr xircom_tulip_cb] remove bogus unregister_netdev call; use free_netdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1517)
   [netdrvr stnic] fix typo from last stnic cset

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1516)
   [netdrvr iph5526] use SET_MODULE_OWNER; small typedef cleanup

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1515)
   [netdrvr pcmcia] s/kfree/free_netdev/

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1514)
   [netdrvr ether00] s/kfree/free_netdev/ ; remove redundant memset() calls

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1513)
   [netdrvr] s/kfree/free_netdev/ where appropriate

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1512)
   [wireless wavelan{_cs}] use alloc_etherdev; remove useless net_device* typedef

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1511)
   [netdrvr de600] use alloc_etherdev; request_region fixes

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1510)
   [netdrvr atp] use alloc_etherdev, clean up probing

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1509)
   [netdrvr depca] fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1508)
   [netdrvr saa9730] use alloc_etherdev, annotate bugs found but not fixed

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1507)
   [netdrvr stnic] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1506)
   [netdrvr sgiseeq] alloc_etherdev, SET_MODULE_OWNER, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1505)
   [netdrvr sb1250-mac] alloc_etherdev, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1504)
   [netdrvr au1000_eth] alloc_etherdev, SET_MODULE_OWNER, fix leaks/small bugs

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1503)
   [netdrvr zorro8390] alloc_etherdev, SET_MODULE_OWNER

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1502)
   [netdrvr mace] alloc_etherdev, fix leaks on error

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1501)
   [netdrvr znet] alloc_etherdev, SET_MODULE_OWNER, remove #ifdef MODULE

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1500)
   [netdrvr oaknet] use alloc_etherdev, fix leaks

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1499)
   [netdrvr hydra] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1498)
   [netdrvr gt96100eth] use alloc_etherdev, fix leaks

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1497)
   [netdrvr declance] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1496)
   [netdrvr ariadne] use alloc_etherdev

<viro@parcelfarce.linux.theplanet.co.uk> (03/11/16 1.1495)
   [netdrvr a2065] convert to alloc_etherdev

<jgarzik@redhat.com> (03/11/16 1.1494)
   [netdrvr tc35815] switch to using alloc_etherdev
   
   Also handle ioremap failure.

<jgarzik@redhat.com> (03/11/16 1.1493)
   [netdrvr tc35815] many fixes, major and minor
   
   * s/int/unsigned long/ for 'flags' arg passed to spin_lock_irqsave
   * s/unsigned int/unsigned long/ for I/O port addresses
   * no need to prevent tc35815_probe from being called multiple times...
     PCI layer will do things properly for us.
   * call pci_enable_device before accessing hardware, before obtaining
     irq number, and before obtaining I/O port addresses.
   * remove bogus 'if (pdev)' check in PCI API ->probe function
   * call SET_M0DULE_OWNER, remove MOD_{INC,DEC}_USE_COUNT
   * (cleanup) don't bother casting from a void*
   * (cleanup) mark debugging function with #if 0, just like the caller
   * Fix many printk statements to indicate that tc_readl() returns
     a long, not an int.
   * (cleanup) remove unused tc35815_proc_info function

<scott.feldman@intel.com> (03/11/16 1.1492)
   [e100] missed a kfree -> free_netdev
   
   * missed a kfree -> free_netdev

<scott.feldman@intel.com> (03/11/16 1.1491)
   [e100] add extended device-specific ethtool stats
   
   * Add extended device-specific ethtool stats

<scott.feldman@intel.com> (03/11/16 1.1490)
   [e100] remove __devinit from mis-marked funcs
   
   * Remove __devinit from mis-marked functions that are needed
     after init for things like ethtool.  (anton@samba.org)

<scott.feldman@intel.com> (03/11/16 1.1489)
   [e1000] Internal SERDES link detect; delay after SPI
   
   * Internal SERDES designs must use indirect method to sample
     link status based on sampling MAC sync bits.
   * Need 10 msec delay after SPI eeprom write, otherwise back-to-
     back writes can get corrupted.
   * Allow for setup of multiple MAC addresses (not used for
     Linux - shared code change).
   * Updated comment block.

<scott.feldman@intel.com> (03/11/16 1.1488)
   [e1000] exit polling loop if interface is brought down
   
   * Exit polling loop if interface is brought down.

<scott.feldman@intel.com> (03/11/16 1.1487)
   [e1000] improve Tx flush method
   
   * Flush queued in-flight Tx descriptors when link is lost.  8254x stops
     processing Tx descriptors when link is lost, so outstanding Tx
     buffers will not be returned to OS unless we flush the Tx descriptor
     ring.  This patch move the flush from the watchdog timer callback
     to process context to work around some issue with holding xmit_lock
     in timer callback.

<scott.feldman@intel.com> (03/11/16 1.1486)
   [e1000] print message if user overrides default ITR
   
   * Print message if user overrides default setting of ITR.

<scott.feldman@intel.com> (03/11/16 1.1485)
   [e1000] 82547 interrupt assert/de-assert re-ordering
   
   * 82547 needs interrupt disable/enable to keep interrupt assertion
     state synced between 82547 and APIC.  82547 will re-order
     assert and de-assert messages if hub link bus is busy (heavy
     traffic).  Disabling interrupt on device works around re-
     order issue.

<scott.feldman@intel.com> (03/11/16 1.1484)
   [e1000] use unsigned long for I/O base addr
   
   * Use unsigned long for I/O base addr; can be 64-bit on some archs.

<scott.feldman@intel.com> (03/11/16 1.1483)
   [e1000] loopback diag test failing on big-endian
   
   * ethtool diag loopback test was failing on ppc because of
     endianness issue.

<scott.feldman@intel.com> (03/11/16 1.1482)
   [e1000] use pdev->irq rather than netdev->irq for
   
   * Use pdev->irq rather than netdev->irq for interrupt
     registration in anticipation of MSI interrupt API support.

<scott.feldman@intel.com> (03/11/16 1.1481)
   [e1000] add ethtool ring param support
   
   * Add ethtool ring param support

<jgarzik@redhat.com> (03/11/16 1.1480)
   [netdrvr] Remove never-referenced 68360enet.c

<jgarzik@redhat.com> (03/11/12 1.1479)
   [netdrvr 3c515] fix non-modular build

<shemminger@osdl.org> (03/11/12 1.1478)
   [PATCH] (42/42) atari_lance
   
   NE68-atarilance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits
   	* also kill off last usage of probe_list

<shemminger@osdl.org> (03/11/12 1.1477)
   [PATCH] (41/42) sun3_lance
   
   NE67-sun3lance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1476)
   [PATCH] (40/42) sun3_82586
   
   NE66-sun3_82586
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1475)
   [PATCH] (39/42) apne
   
   NE64-apne
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1474)
   [PATCH] (38/42) bionet
   
   NE63-bionet
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1473)
   [PATCH] (37/42) pamsnet
   
   NE62-pamsnet
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1472)
   [PATCH] (36/42) hplance
   
   NE61-hplance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1471)
   [PATCH] (35/42) mvme147
   
   NE60-mvme147lance
   	* switched to dynamic allocation
   	* fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1470)
   [PATCH] (34/42) mac_mace
   
   NE59-mace
   	* switched mace to dynamic allocation
   	* mace: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1469)
   [PATCH] (33/42) macsonic
   
   NE58-macsonic
   	* switched macsonic to dynamic allocation
   	* macsonic: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1468)
   [PATCH] (32/42) mac8390
   
   NE57-mac8390
   	* switched mac8390 to dynamic allocation
   	* mac8390: fixed resource leaks on failure exits
   	* get rid of MOD_INC/DEC

<shemminger@osdl.org> (03/11/12 1.1467)
   [PATCH] (31/42) mac89x0
   
   NE56-mac8390
   	* switched mac8390 to dynamic allocation
   	* mac8390: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1466)
   [PATCH] (30/42) jazzsonic
   
   NE55-jazzsonic
   	* switched jazzsonic to dynamic allocation
   	* jazzsonic: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1465)
   [PATCH] (29/42) bagetlance
   
   NE54-bagetlance
   	* switched bagetlance to dynamic allocation
   	* bagetlance: embedded ->priv
   	* bagetlance: fixed resource leaks on failure exits
   	* bagetlance: fixed resource leaks on rmmod

<shemminger@osdl.org> (03/11/12 1.1464)
   [PATCH] (28/42) ultra32
   
   NE52-ultra32
   	* switched smc-ultra32 to dynamic allocation
   	* smc-ultra32: fixed order of freeing bugs
   	* smc-ultra32: fixed clobbering on autoprobe
   	* smc-ultra32: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1463)
   [PATCH] (27/42) ac3200
   
   NE51-ac3200
   	* switched ac3200 to dynamic allocation
   	* ac3200: fixed order of freeing bugs
   	* ac3200: fixed clobbering on autoprobe
   	* ac3200: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1462)
   [PATCH] (26/42) es3210
   
   NE50-es3210
   	* switched es3210 to dynamic allocation
   	* es3210: fixed order of freeing bugs
   	* es3210: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1461)
   [PATCH] (25/42) lne390
   
   NE49-lne390
   	* switched lne390 to dynamic allocation
   	* lne390: fixed order of freeing bugs
   	* lne390: fixed clobbering on autoprobe
   	* lne390: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1460)
   [PATCH] (24/42) ne2
   
   NE48-ne2 from viro
   	* switched ne2 to dynamic allocation
   	* ne2: fixed order of freeing bugs
   	* ne2: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1459)
   [PATCH] (23/42) 3c523
   
   NE47-3c523 from viro
   	* switched 3c523 to dynamic allocation
   	* 3c523: switched to embedded ->priv
   	* 3c523: fixed order of freeing bugs
   	* 3c523: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1458)
   [PATCH] (22/42) 3c527
   
   NE46-3c527
   	* switched 3c527 to dynamic allocation
   	* 3c527: switched to embedded ->priv
   	* 3c527: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1457)
   [PATCH] (21/42) sk_mca
   
   NE45-sk_mca
   	* switched sk-mca to dynamic allocation
   	* sk-mca: switched to embedded ->priv
   	* sk-mca: fixed order of freeing bugs
   	* sk-mca: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1456)
   [PATCH] (20/42) hp100-T10
   
   NE44-hp100
   	* convert to dynamic allocation
   	* use device model for PCI and EISA
   	* use pci id's to find PCI devices
   	* fix missing id's for 10 Mbit only PCI boards

<shemminger@osdl.org> (03/11/12 1.1455)
   [PATCH] (19/42) 3c515-T10
   
   NE43-3c515
   	* convert to dynamic allocation
   	* fixed up device list handling

<shemminger@osdl.org> (03/11/12 1.1454)
   [PATCH] (18/42) ultra
   
   Based on viro NE42-ultra
   	* switched smc-ultra to dynamic allocation
   	* smc-ultra: fixed order of freeing bugs
   	* smc-ultra: fixed resource leaks on failure exits
   	* smc-ultra: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1453)
   [PATCH] (17/42) wd
   
   Based on viro NE41-wd
   	* switched wd to dynamic allocation
   	* wd: fixed order of freeing bugs
   	* wd: fixed resource leaks on failure exits
   	* wd: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1452)
   [PATCH] (16/42) 3c503
   
   Based on viro NE40-3c503
   	* switched 3c503 to dynamic allocation
   	* 3c503: fixed order of freeing bugs
   	* 3c503: fixed IO without request_region
   	* 3c503: fixed resource leaks on failure exits
   	* 3c503: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1451)
   [PATCH] (15/42) hp
   
   Based on viro NE39-hp
   	* switched hp to dynamic allocation
   	* hp: fixed order of freeing bugs
   	* hp: fixed resource leaks on failure exits
   	* hp: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1450)
   [PATCH] (14/42) hpplus
   
   Based on NE38-hpplus
   	* switched hp-plus to dynamic allocation
   	* hp-plus: fixed order of freeing bugs
   	* hp-plus: fixed resource leaks on failure exits
   	* hp-plus: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1449)
   [PATCH] (13/42) e2100
   
   Based on viro NE37-e2100
   	* switched e2100 to dynamic allocation
   	* e2100: fixed order of freeing bugs
   	* e2100: fixed resource leaks on failure exits
   	* e2100: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1448)
   [PATCH] (12/42) ne
   
   Based on NE36-ne
   	* switched ne/ne2k_cbus to dynamic allocation
   	* ne/ne2k_cbus: fixed order of freeing bugs
   	* ne/ne2k_cbus: fixed resource leaks on failure exits
   	* ne/ne2k_cbus: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1447)
   [PATCH] (11/42) lance
   
   Based on viro NE35-lance
   	* switched lance to dynamic allocation
   	* lance: fixed init_etherdev races
   	* lance: fixed resource leaks on failure exits
   	* NB: probing code is, to put it mildly, odd.  It _always_ does
   	  autoprobe, modular or not.  WTF is going on there?

<shemminger@osdl.org> (03/11/12 1.1446)
   [PATCH] (10/42) smc
   
   Based on viro NE34-smc
   	* switched smc to dynamic allocation
   	* smc: embedded ->priv
   	* smc: fixed resource leaks on failure exits
   	* smc: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1445)
   [PATCH] (9/42) seeq8005
   
   Based on viro NE33-seeq8005
   	* switched seeq8005 to dynamic allocation
   	* seeq8005: embedded ->priv
   	* seeq8005: fixed resource leaks on failure exits
   	* seeq8005: fixed clobbering on autoprobe
   	* seeq8005: fixed jiffies truncation
   	* seeq8005: fixed a typo in Kconfig - module is _not_ called ewrk3

<shemminger@osdl.org> (03/11/12 1.1444)
   [PATCH] (8/42) at1500
   
   Based on viro NE32-at1500
   	ROTFL.  The last remnants of CONFIG_AT1500 removed - that was a hell
   	of an ancient bug (at1500_probe() was never defined, AFAICS - all
   	way back to 0.99.15).

<shemminger@osdl.org> (03/11/12 1.1443)
   [PATCH] (7/42) cs89x0
   
   Based on viro NE31-cs89x0
   	* switched cs89x0 to dynamic allocation
   	* cs89x0: embedded ->priv
   	* cs89x0: fixed resource leaks on failure exits
   	* cs89x0: fixed clobbering on autoprobe
   	* NB: cs89x0 calls request_region() with very odd arguments.  Somebody
   	  ought to check WTF is going on there.

<shemminger@osdl.org> (03/11/12 1.1442)
   [PATCH] (6/42) at1700
   
   Based on viro NE30-at1700
   	* switched at1700 to dynamic allocation
   	* at1700: embedded ->priv
   	* at1700: fixed resource leaks on failure exits
   	* at1700: fixed clobbering on autoprobe

<shemminger@osdl.org> (03/11/12 1.1441)
   [PATCH] (5/42) fmv18
   
   Based on viro, NE29-fmv18
   	* switched fmv18x to dynamic allocation
   	* fmv18x: embedded ->priv
   	* fmv18x: fixed resource leaks on failure exits
   	* fmv18x: fixed clobbering on autoprobe
   	* fmv18x: compile fix - comment is _not_ an empty statement.  The thing
   	  had been b0rken since 2.4.3-pre2, BTW...

<shemminger@osdl.org> (03/11/12 1.1440)
   [PATCH] (4/42) eth16i
   
   NE28-eth16i
   	* switched eth16i to dynamic allocation
   	* eth16i: embedded ->priv
   	* eth16i: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1439)
   [PATCH] (3/42) eexpress
   
   Based on viro NE27-eexpress
   	* switched eexpress to dynamic allocation
   	* eexpress: embedded ->priv
   	* eexpress: fixed clobbering on autoprobe
   	* eexpress: fixed IO without request_region()
   	* eexpress: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1438)
   [PATCH] (2/42) eepro
   
   Patch from viro: NE26-eepro
   	* switched eepro to dynamic allocation
   	* eepro: embedded ->priv
   	* eepro: fixed clobbering on autoprobe
   	* eepro: fixed IO before request_region()
   	* eepro: fixed resource leaks on failure exits

<shemminger@osdl.org> (03/11/12 1.1437)
   [PATCH] (1/42) ewrk3
   
   Convert ewrk3 to dynamic allocation
   	* get rid of private device allocation method
   	* fix deeply nested function

<shemminger@osdl.org> (03/11/11 1.1428.1.5)
   [PATCH] sk_g16 missing declaration
   
   The new probe code in net-drivers-2.5-exp lost a declaration for the
   module case (thanks al).

<shemminger@osdl.org> (03/11/11 1.1428.1.4)
   [PATCH] arlan new probe code needs to register
   
   Fix arlan registration in the net-drivers-2.5-exp repo.
   Need to call register_netdev. Found by viro.

<shemminger@osdl.org> (03/11/11 1.1428.1.3)
   [PATCH] 3c59x netpoll typo
   
   Poll code (in net-drivers-2.5-exp) was calling undefined function.

<shemminger@osdl.org> (03/11/11 1.1428.1.2)
   [PATCH] typo in net-drivers-2.5-exp 3c507
   
   Fix auto-probing loop in new probing code for 3c507.
   This patch is against net-drivers-2.5-exp repository.
   Found by viro.

<ak@muc.de> (03/10/29 1.1380.2.24)
   [PATCH] netpoll for eepro100
   
   netpoll for eepro100
   
   This was in Ingo's old original netconsole patches.

<ak@muc.de> (03/10/29 1.1380.2.23)
   [PATCH] fix tg3 netpoll
   
   No need to use disable_irq because tg3 is properly spinlocked.
   Can just call the interrupt handler directly.

<ak@muc.de> (03/10/29 1.1380.2.22)
   [PATCH] Netpoll for pcnet32
   
   netpoll for pcnet32

<ak@muc.de> (03/10/29 1.1380.2.21)
   [PATCH] netpoll for amd8111e
   
   netpoll for amd8111e

<ak@muc.de> (03/10/29 1.1380.2.20)
   [PATCH] netpoll for tulip
   
   Netpoll for tulip. Uses disable_irq() because tulip is unfortunately
   still lockless.

<ak@muc.de> (03/10/29 1.1380.2.19)
   [PATCH] netpoll for 3c59x
   
   >From the old -aa tree with minor changes. Orginally done
   by Andrea I think.

<mpm@selenic.com> (03/10/29 1.1380.5.3)
   [NET] use the netpoll API to transmit kernel printks over UDP

<mpm@selenic.com> (03/10/29 1.1380.5.2)
   [NET] Add netpoll support for tg3

<mpm@selenic.com> (03/10/29 1.1380.5.1)
   [NET] add netpoll API

<shemminger@osdl.org> (03/10/29 1.1380.2.17)
   [PATCH] trivial -- skfp_probe should be static
   
   skfp_probe used to be called from Space.c but isn't any more.
   Therefore it no longer needs to be global.  All the calls to insert_device()
   pass skfp_probe as a second arg, so just use it directly.
   
   Jeff, this also is janitor type stuff, so just put it in net-2.5-exp

<shemminger@osdl.org> (03/10/29 1.1380.2.16)
   [PATCH] (4/6) skisa -- probe2
   
   Convert the SK-NET TMS380 ISA card to the new probe2 format.

<shemminger@osdl.org> (03/10/29 1.1380.2.15)
   [PATCH] (3/6) proteon -- probe2
   
   Convert proteon token ring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1380.2.14)
   [PATCH] (2/6) smctr -- probe2
   
   Convert the SMC tokenring driver to new probing.

<shemminger@osdl.org> (03/10/29 1.1380.2.13)
   [PATCH] (1/6) tokenring probing change
   
   Ugh, two patches got crossed. This is the correct first one.

<rnp@paradise.net.nz> (03/10/29 1.1380.2.12)
   [netdrvr 3c527] fix race

<rnp@paradise.net.nz> (03/10/29 1.1380.2.11)
   [netdrvr 3c527] whitespace changes (sync up with maintainer)

<shemminger@osdl.org> (03/10/14 1.1337.26.21)
   [PATCH] (12/12) Probe2 -- 82596
   
   Originally by Al Viro (NE23-82596)
   	* switched 82596 to dynamic allocation
   	* 82596: fixed resource leaks on failure exits
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.20)
   [PATCH] (11/12) Probe2 -- 3c501
   
   >From viro NE22-3c501
   	* switched 3c501 to dynamic allocation
   	* 3c501: embedded ->priv
   	* 3c501: fixed clobbering on autoprobe
   	* 3c501: fixed resource leaks on failure exits
   Additional:
   	* probe correctly when no device present
   	* fix loop forever bug in probing
   	* free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.19)
   [PATCH] (10/12) Probe2 -- wavelan
   
   Original by Al Viro (NE21-wavelan)
   	* switched wavelan to dynamic allocation
   	* wavelan: embedded ->priv
   	* wavelan: fixed clobbering on autoprobe
   	* wavelan: fixed IO before request_region()
   	* wavelan: fixed resource leaks on failure exits
   	* wavelan: fixed order of freeing bugs
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.18)
   [PATCH] (09/12) Probe2 -- arlan
   
   Convert arlan driver to new probing.  This meant a rather large
   rework of the probing code for this driver since it did a lot ofnon
   standard things.

<shemminger@osdl.org> (03/10/14 1.1337.26.17)
   [PATCH] (08/12) Probe2 -- 3c507
   
   Originally by Al Viro (NE19-3c507)
   	* switched 3c507 to dynamic allocation
   	* 3c507: embedded ->priv
   	* 3c507: fixed clobbering on autoprobe
   	* NB: 3c507.c buggers port 0x100 without claiming it.  Most likely it
   	  should be doing request_region() there.
   Updated to apply agains jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.16)
   [PATCH] (07/12) Probe2 -- 3c505
   
   from viro NE18-3c505
   	* switched 3c505 to dynamic allocation
   	* 3c505: embedded ->priv
   	* 3c505: fixed use of uninitialized variable
   	* 3c505: fixed resource leaks on failure exits
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.15)
   [PATCH] (06/12) Probe2 -- sk16
   
   from viro NE17-sk16
   	* switched sk_g16 to dynamic allocation
   	* sk_g16: embedded ->priv
   	* sk_g16: fixed buggy check for signature (|| instead of &&, somebody
   	  forgot to replace it when inverting the test).
   	* sk_g16: fixed use after kfree()
   	* sk_g16: fixed init_etherdev() race
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.14)
   [PATCH] (05/12) Probe2 -- ni5010
   
   from viro NE16-ni5010
   	* switched ni5010 to dynamic allocation
   	* ni5010: embedded ->priv
   	* ni5010: fixed clobbering ->irq
   	* ni5010: fixed IO before request_region()
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.13)
   [PATCH] (04/12) Probe2 -- ni52
   
   >From viro NE15-ni52
   	* switched ni52 to dynamic allocation
   	* ni52: embedded ->priv
   	* ni52: fixed clobbering of everything on autoprobe
   Additional:
   	* add free_netdev

<shemminger@osdl.org> (03/10/14 1.1337.26.12)
   [PATCH] (03/12) Probe2 -- ni65
   
   Convert ni65 driver to new probing; patch sequence goes bottom
   up on the probe list.
   
   	* switched ni65 to dynamic allocation
   	* ni65: fixed ->irq and ->dma clobbering on autoprobe

<shemminger@osdl.org> (03/10/14 1.1337.26.11)
   [PATCH] (2/12) Probe2 -- de620
   
   Rework de620 driver to new dynamic allocation
   Originally by Al Viro.
   	* switched de620 to dynamic allocation
   	* de620: embedded ->priv
   	* de620: fixed IO before request_region()
   
   Updated to ~jgarzik/net-drivers-2.5-exp

<shemminger@osdl.org> (03/10/14 1.1337.26.10)
   [PATCH] (1/12) Probe2 infrastructure for 2.6 experimental
   
   New infrastructure to allow probing older builtin drivers (like ISA)
   Originally by Al Viro, updated to apply agains jgarzik/net-drivers-2.5-exp

<jgarzik@redhat.com> (03/10/14 1.1337.26.9)
   [netdrvr tulip] support NAPI
   
   Contributed by Robert Ollsson.

<shemminger@osdl.org> (03/10/14 1.1337.26.8)
   [PATCH] smctr - get rid of MOD_INC/DEC
   
   Get rid of warning now that module refcounting now done by network code not drivers.
   
   Not tested on real hardware.

<rddunlap@osdl.org> (03/10/14 1.1337.26.7)
   [PATCH] janitor: insert missing iounmap(), add error handling
   
   Hi,
   Please apply to 2.6.0-test6-current.
   
   Thanks,
   --
   ~Randy
   
   
   
   From: Leann Ogasawara <ogasawara@osdl.org>
   Subject: Re: [Kernel-janitors] [PATCH] insert missing iounmap()
   
   > > Patch inserts a missing iounmap().  Implements a cleanup path
   > > for error handling as well.  Feedback is much appreciated.  Thanks :)
   
   
   
   ===== drivers/net/natsemi.c 1.55 vs edited =====
   
   
    linux-260-test6-kj1-rddunlap/drivers/net/natsemi.c |   39 ++++++++++-----------
    1 files changed, 20 insertions(+), 19 deletions(-)

<felipewd@terra.com.br> (03/10/14 1.1337.26.6)
   [PATCH] release region in skfddi driver
   
   This is a multi-part message in MIME format.

<felipewd@terra.com.br> (03/10/14 1.1337.26.5)
   [netdrvr 3c527] remove cli/sti
   
   
       Richard Procter and I worked to remove cli/sti to add proper SMP support (I did the original stuff and Richard did the actual current code :)).
   
       Besides that, Richard did a great jog improving the perfomance of the driver quite a bit:
   
       - Improve mc32_command by 770% (438% non-inlined) over the semaphore version (at a cost of 1 sem + 2 completions per driver).
   
       - Removed mutex covering mc32_send_packet (hard_start_xmit). This lets the interrupt handler operate concurrently and removes unnecessary locking. It makes the code only slightly more brittle
   
       Original post:
   
   http://marc.theaimsgroup.com/?l=linux-netdev&m=106438449315202&w=2
   
       Since it didn't apply cleanly against 2.6.0-test6, I forward ported it. Patch attached.
   
       Jeff, please consider applying,
   
       Thanks.

<shemminger@osdl.org> (03/10/14 1.1337.26.4)
   [PATCH] remove dev_get from wanrouter
   
   The call to dev_get() in wanrouter_device_new_if is racy and redundant and should
   be removed.  The later 'register_netdev()' does the same test internally and will
   return the appropriate error if the name already exists.
   
   This patch is against 2.6.0-test6.
   Resend of earlier patch because it was ignored, or missed.

<romieu@fr.zoreil.com> (03/10/14 1.1337.26.3)
   [PATCH] 2.6.0-test6 - more free_netdev() conversion
   
   Compiles ok (with true .o generated, yeah). Please review.
   
   free_netdev() of devices allocated through use of alloc_netdev().
   Though baroque, drivers/net/3c515.c now uses alloc_etherdev().
   
   
    drivers/net/3c515.c   |   23 ++++++++++++-----------
    drivers/net/defxx.c   |    2 +-
    drivers/net/dummy.c   |    2 +-
    drivers/net/eql.c     |    2 +-
    drivers/net/ns83820.c |    2 +-
    drivers/net/plip.c    |   14 ++++++++++----
    drivers/net/shaper.c  |   11 ++++++++---
    drivers/net/tun.c     |   18 +++++++++---------
    9 files changed, 43 insertions(+), 31 deletions(-)

<shemminger@osdl.org> (03/10/14 1.1337.26.2)
   [PATCH] wan/lmc -- convert to new network device model
   
   Resend of LMC driver patch for 2.6.0-test6
     * do proper probing
     * allocate network device with alloc_netdev
     * use standard pci_id's instead of local defines
     * use standard PCI device interface to find and remove devices.

<krishnakumar@naturesoft.net> (03/10/14 1.1337.26.1)
   [netdrvr 8139too] support netif_msg_* interface


--------------070909080505000701050604--

