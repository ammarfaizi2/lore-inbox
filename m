Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTFLTgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTFLTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:36:36 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:47597
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264961AbTFLTfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:35:41 -0400
Date: Thu, 12 Jun 2003 15:49:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [PATCHES] 2.4.x net driver updates
Message-ID: <20030612194926.GA7653@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users may issue a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-rc8-netdrvr2.patch.bz2

This will update the following files:

 drivers/net/bonding.c                | 3434 -------------------------
 Documentation/Configure.help         |    9 
 Documentation/networking/bonding.txt |  537 ++-
 Documentation/networking/ifenslave.c |  496 ++-
 drivers/net/8139cp.c                 |    9 
 drivers/net/8139too.c                |    6 
 drivers/net/Config.in                |    3 
 drivers/net/Makefile                 |    8 
 drivers/net/amd8111e.c               | 1075 +++++--
 drivers/net/amd8111e.h               |  968 +++----
 drivers/net/arcnet/arcnet.c          |    2 
 drivers/net/arcnet/rfc1201.c         |    6 
 drivers/net/bonding.c                |  266 +
 drivers/net/bonding/Makefile         |   18 
 drivers/net/bonding/bond_3ad.c       | 2667 ++++++++++++++++++-
 drivers/net/bonding/bond_3ad.h       |  342 ++
 drivers/net/bonding/bond_alb.c       | 1585 +++++++++++
 drivers/net/bonding/bond_alb.h       |  129 
 drivers/net/bonding/bond_main.c      | 4795 ++++++++++++++++++++++++++++++++---
 drivers/net/bonding/bonding.h        |  209 +
 drivers/net/dl2k.h                   |    1 
 drivers/net/e100/e100.h              |   30 
 drivers/net/e100/e100_main.c         |  389 ++
 drivers/net/e100/e100_phy.c          |    7 
 drivers/net/e100/e100_test.c         |  155 -
 drivers/net/e1000/Makefile           |    2 
 drivers/net/e1000/e1000.h            |    8 
 drivers/net/e1000/e1000_ethtool.c    |  959 ++++++-
 drivers/net/e1000/e1000_hw.c         |   23 
 drivers/net/e1000/e1000_hw.h         |    8 
 drivers/net/e1000/e1000_main.c       |  312 +-
 drivers/net/e1000/e1000_osdep.h      |    2 
 drivers/net/eepro.c                  |    2 
 drivers/net/ns83820.c                |    2 
 drivers/net/pci-skeleton.c           |    4 
 drivers/net/pcnet32.c                |    7 
 drivers/net/r8169.c                  |   52 
 drivers/net/sk98lin/skge.c           |    2 
 drivers/net/sundance.c               |  144 -
 drivers/net/tg3.c                    |    2 
 drivers/net/tlan.c                   |  258 +
 drivers/net/tlan.h                   |    7 
 drivers/net/tokenring/olympic.c      |    3 
 drivers/net/tulip/tulip_core.c       |    7 
 drivers/net/typhoon.c                |    4 
 drivers/net/via-rhine.c              |    2 
 drivers/net/wireless/airo.c          |    2 
 include/linux/ethtool.h              |   27 
 include/linux/if_arcnet.h            |    4 
 include/linux/if_bonding.h           |  101 
 include/linux/if_vlan.h              |    1 
 include/linux/skbuff.h               |    4 
 include/net/if_inet6.h               |    5 
 include/net/irda/irlan_common.h      |    2 
 net/core/dev.c                       |    4 
 net/core/skbuff.c                    |    3 
 net/ipv6/addrconf.c                  |   13 
 net/ipv6/ndisc.c                     |    3 
 net/irda/irlan/irlan_eth.c           |    6 
 59 files changed, 13293 insertions(+), 5838 deletions(-)

through these ChangeSets:

<reeja.john@amd.com> (03/06/08 1.1226)
   [netdrvr amd8111e] bug fix: move stats update after irq free

<cramerj@intel.com> (03/06/08 1.1225)
   [e1000] Whitespace cleanup
   
   * Whitespace cleanup

<cramerj@intel.com> (03/06/08 1.1224)
   [e1000] Miscellaneous code cleanup
   
   * Added Change Log entries
   * Miscellaneous code cleanup

<cramerj@intel.com> (03/06/08 1.1223)
   [e1000] Fixed LED coloring on 82541/82547 controllers
   
   * LED colors on 82541 and 82547 controllers were incorrect.
     The LED mode register didn't have the proper configuration.

<cramerj@intel.com> (03/06/08 1.1222)
   [e1000] Removed strong branded device ids
   
   * Removed strong branded device ids from teh device id table
     along with the associated branding strings.

<cramerj@intel.com> (03/06/08 1.1221)
   [e1000] Added support for 82546 Quad-port adapter
   
   * Added support for 82546 Quad-port adapter

<cramerj@intel.com> (03/06/08 1.1220)
   [e1000] Added ethtool test ioctl
   
   * Added routines for the Ethtool Test ioctl.
   * Added more statistics for the Ethtool statistics dump.
   * Added more registers for the register dump.

<cramerj@intel.com> (03/06/08 1.1219)
   [e1000] TSO fix
   
   * Premature write-back of descriptors during TSO causing
     resources to be returned too early on ppc64.  Fix is to
     wait until last descriptor of frame is written back,
     then return resources back to OS.
   * 82544 hang caused by setting RS bit in context descriptor.
     Exposes known hang in 82544.  Fix is same as above - set
     RS bit only in last descriptor.

<scott.feldman@intel.com> (03/06/08 1.1218)
   [e100] misc
   
   * Removed leftovers from removal of /proc support and IDIAG support
   * Cleaned up reporting of h/w init failure messages
   * Add 1/2 second delay after PHY reset to allow link partner to
     see and respond to reset, per IEEE 802.3.

<scott.feldman@intel.com> (03/06/08 1.1217)
   [e100] set netdev members before registration
   
   * Bug fix: setndev members before netdev registration to avoid races.

<scott.feldman@intel.com> (03/06/08 1.1216)
   [e100] use skb_headlen() rather than rolling own.
   
   * Cleanup: use skb_headlen() rather than rolling own.  Sync w/ 2.5 driver.

<scott.feldman@intel.com> (03/06/08 1.1215)
   [e100] VLAN configuration was lost after ethtool diags run
   
   * Bug fix: ethtool diags would call e100_up/e100_down, which overwrite
     current VLAN settings.  Move initialization of config regs out of
     up/down.

<scott.feldman@intel.com> (03/06/08 1.1214)
   [e100] fixed stalled stats collection
   
   * Bug fix: In the rare event of a failed command to dump stats,
     stat collection would stop, giving the illusion that traffic
     had stopped.  Fixed by issuing stat dump in watchdog
     regardless of the status of previous attempt to dump stats.

<scott.feldman@intel.com> (03/06/08 1.1213)
   [e100] full stop/start on ethtool set speed/duplex/autoneg
   
   * Cleanup ethtool/mii_ioctl sets of speed/duplex/autoneg by
     stop/set/start driver to ensure sets stick.  Must hold
     xmit_lock around stop/start.

<scott.feldman@intel.com> (03/06/08 1.1212)
   [e100] cleanup Tx resources before running ethtool diags
   
   * Bug fix: clean up Tx resources before runnig ethtool diags.

<scott.feldman@intel.com> (03/06/08 1.1211)
   [e100] Add MDI/MDI-X status to ethtool reg dump
   
   * Add MDI/MDI-X (crossover cable) status to ethtool reg dump.

<scott.feldman@intel.com> (03/06/08 1.1210)
   [e100] Add ethtool cable diag test
   
   * Feature add: ethtool cable diag test.
   * Some cleanup of the ethtool diags.
   * Fixed bug in return code for ethtool diag results.

<scott.feldman@intel.com> (03/06/08 1.1209)
   [e100] Add ethtool parameter support
   
   * Feature add: ethtool parameter support: Tx/Rx ring size, Rx xsum
     offloading, flow control.

<scott.feldman@intel.com> (03/06/08 1.1208)
   [e100] move e100_asf_enable under CONFIG_PM to avoid warning
   
   * Bug fix: move e100_asf_enable under CONFIG_PM to avoid compile warning.
     [Stephen Rothwell (sfr@canb.auug.org.ua)]

<scott.feldman@intel.com> (03/06/08 1.1207)
   [e100] Remove "Freeing alive device" warning
   
   * Bug fix: don't call any netif_carrier_* until netdev is registered.
     [Andrew Morton (akpm@dideo.com)]

<fubar@us.ibm.com> (03/06/06 1.1205)
   [PATCH] Bonding 2.4 update patch 6
   
   	Fix to the ifenslave -c fix, fix to version control (plus
   change log update).  I've got an additional fix for version control
   that I'll send you on Monday.
   
   Index: linux-2.4.21-rc6-netdrvr1/Documentation/networking/ifenslave.c

<fubar@us.ibm.com> (03/06/06 1.1204)
   [PATCH] Bonding 2.4 update patch 5
   
   	Fix to prevent routes on the bonding device from being lost
   during enslavement processing.
   
   Index: linux-2.4.21-rc6-netdrvr1/Documentation/networking/ifenslave.c

<fubar@us.ibm.com> (03/06/06 1.1203)
   [PATCH] Bonding 2.4 update patch 4
   
   	A fix for ifenslave -c.  Later patches have fixes for this fix.
   
   Index: linux-2.4.21-rc6-netdrvr1/Documentation/networking/ifenslave.c

<fubar@us.ibm.com> (03/06/06 1.1202)
   [PATCH] Bonding 2.4 update patch 3
   
   	A patch with some miscellaneous little stuff (comments, mode
   names, fix a printk).
   
   Index: linux-2.4.21-rc6-netdrvr1/drivers/net/bonding/bond_main.c

<fubar@us.ibm.com> (03/06/06 1.1201)
   [PATCH] Bonding 2.4 update patch 2
   
   	Small patch to fix endless failover problem in the ARP monitor.
   
   Index: linux-2.4.21-rc6-netdrvr1/drivers/net/bonding/bond_main.c

<fubar@us.ibm.com> (03/06/06 1.1200)
   [PATCH] Bonding 2.4 update patch 1
   
   	Documentation.
   
   Index: linux-2.4.21-rc6-netdrvr1/Documentation/networking/bonding.txt

<scott.feldman@intel.com> (03/06/06 1.1199)
   [PATCH] remove ethtool privileged references
   
   dev_ioctl already checks capable(CAP_NET_ADMIN) for SOICETHTOOL, so
   privileged reference are not necessary.

<scott.feldman@intel.com> (03/06/06 1.1198)
   [PATCH] 10GbE ethtool support
   
   Add 10GbE support for ethtool.

<reeja.john@amd.com> (03/06/05 1.1197)
   [netdrvr amd8111e] link against mii lib

<jgarzik@redhat.com> (03/06/04 1.1196)
   [netdrvr] gcc 3.3 cleanups
   
   Mostly marking 64-bit constants as ULL.

<jgarzik@redhat.com> (03/05/29 1.1185.1.52)
   [netdrvr amd8111e] remove out-of-tree feature that snuck in

<reeja.john@amd.com> (03/05/29 1.1185.1.51)
   [netdrvr amd8111e] interrupt coalescing, libmii, bug fixes
   
   * Dynamic interrupt coalescing
   * mii lib support
   * dynamic IPG support (disabled by default)
   * jumbo frame fix
   * vlan fix
   * rx irq coalescing fix

<alan@lxorguk.ukuu.org.uk> (03/05/29 1.1185.1.50)
   [netdrvr tlan] fix 64-bit issues

<jgarzik@redhat.com> (03/05/29 1.1185.1.49)
   [netdrvr r8169] sync with 2.5 (backport whitespace cleanups)

<jgarzik@redhat.com> (03/05/29 1.1185.1.48)
   [netdrvr r8169] use alloc_etherdev (fix race), pci_disable_device

<jgarzik@redhat.com> (03/05/29 1.1185.1.47)
   [netdrvr olympic] fix build with gcc 3.3

<jgarzik@redhat.com> (03/05/29 1.1185.6.3)
   [netdrvr 8139too] add comment, whitespace cleanup

<jgarzik@redhat.com> (03/05/28 1.1185.6.2)
   [netdrvr] s/init_etherdev/alloc_etherdev/ in code comments,
   in 8139too and pci-skeleton drivers.

<jgarzik@redhat.com> (03/05/28 1.1185.6.1)
   [netdrvr tlan] backport fixes and cleanups from 2.5
   
   * alloc_etherdev (fixes race)
   * PCI DMA API
   * C99 initializers
   * speling fixes
   * use pci_{request,release}_regions for PCI devices
   * propagate error returns back from pci_xxx functions
   * call pci_set_dma_mask
   * use keventd for adapter error reset (2.5 uses workqueue)

<engebret@us.ibm.com> (03/05/27 1.1185.1.45)
   [netdrvr pcnet32] bug fixes
   
   I would like to see a couple of the pcnet32 changes that I think we can
   agree on be put into the trees so a couple of the potential defects can be
   avoided.  The following patch contains just these pieces.  The only
   controversial one is an arbitrary change in the number of iterations in a
   while loop spinning on hardware state.   No matter how this is done, I am
   not especially fond of this bit of code as it has no reasonable error
   recovery path -- however, as a half-way, incremental solution, increasing
   the polling time should help as the 100 value was certainly found to be
   insufficient.  1000 may not be sufficient either, but it is certainly no
   worse.
   
   Both of the other changes were hit in testing (and I belive the wmb() at a
   customer even), so it would help reduce some debug if these go in.  Any
   feedback is appreciated - thanks.

<jgarzik@redhat.com> (03/05/27 1.1185.1.44)
   [netdrvr eepro] update MODULE_AUTHOR per old-author request

<edward_peng@dlink.com.tw> (03/05/27 1.1185.1.43)
   [netdrvr sundance] fix another flow control bug

<edward_peng@dlink.com.tw> (03/05/27 1.1185.1.42)
   [netdrvr sundance] fix flow control bug

<shmulik.hen@intel.com> (03/05/27 1.1185.1.41)
   [netdrvr bonding] fix ABI version control problem
   
   This fix makes bonding not commit to a specific ABI version if the ioctl
   command is not supported by bonding.
   
   (It also removes the '\n' in the continuous printk reporting the link down
   event in bond_mii_monitor - it got in there by mistake in our previous
   patch set and caused log messages to appear funny in some situations).

<shmulik.hen@intel.com> (03/05/27 1.1185.1.40)
   [netdrvr bonding] fix long failover in 802.3ad mode
   
   This patch fixes the bug reported by Jay on April 3rd regarding long
   failover time when releasing the last slave in the active aggregator. The
   fix, as suggested by Jay, is to follow the spec recommendation and send a
   LACPDU to the partner saying this port is no longer aggregatable and
   therefore trigger an immediate re-selection of a new aggregator instead of
   waiting the entire expiration timeout.

<yoshfuji@linux-ipv6.org> (03/05/25 1.1185.1.39)
   IPv6 over ARCnet (RFC2497) support, IPv6 part.

<yoshfuji@linux-ipv6.org> (03/05/25 1.1185.1.38)
   IPv6 over ARCnet (RFC2497) support, driver part

<rusty@rustcorp.com.au> (03/05/25 1.1185.1.37)
   [irda] module refcounts for irlan

<fubar@us.ibm.com> (03/05/23 1.1185.3.7)
   [bonding] small cleanups

<shmulik.hen@intel.com> (03/05/23 1.1185.3.6)
   [bonding] add rcv load balancing mode
   
   This patch adds a new mode that enables receive load balancing for IPv4
   traffic on top of the transmit load balancing mode. This capability is
   achieved by intercepting and manipulating the ARP negotiation to teach
   clients several MAC addresses for the bond and thus distribute incoming
   traffic among all slaves with the highest link speed.
   
   In order to function properly, slaves are required to be able to have
   their MAC address set even while the interface is up since once the
   primary slave looses its link, the new primary slave (and only it) must be
   able to take over and receive the incoming traffic instead. If a
   non-primary slave looses its link, ARP packets will be sent to all clients
   communicating through it in order to teach them a replacement MAC address,
   and the primary slave will be put in promiscuous mode for 10 seconds for
   fault tolerance reasons.
   
   This patch is against bonding-20030415, but must come only after the
   locking scheme changing patch since it uses dev_set_promiscuity() that
   would otherwise cause a system hang.

<shmulik.hen@intel.com> (03/05/23 1.1185.3.5)
   [bonding] support xmit load balancing mode

<shmulik.hen@intel.com> (03/05/23 1.1185.3.4)
   [bonding] much improved locking
   
   This patch replaces the use of lock_irqsave/unlock_irqrestore in bonding
   with lock/unlock or lock_bh/unlock_bh as appropriate according to context.
   This change is based on a previous discussion regarding the fact that
   holding a lock_irqsave doesn't prevent softirqs from running which can
   cause deadlocks in certain situations. This new locking scheme has already
   undergone massive testing cycle by our QA group and we feel it is ready
   for release (some new modes and enhancements will not work properly
   without it).

<shmulik.hen@intel.com> (03/05/23 1.1185.3.3)
   [bonding] better 802.3ad mode control, some cleanup
   
   This patch adds the lacp_rate module param to enable better control over
   the IEEE 802.3ad mode. This param controls the rate at which the partner
   system is asked to send LACPDUs to bonding.
   Two options exist:
   - slow (or 0) - LACPDUs are 30 seconds apart
   - fast (or 1) - LACPDUs are 1 second apart
   The default is slow (like most switches around).
   
   There are also some code beautifications (mainly converting comments to C
   style in code segments we added in the past).
   

<shmulik.hen@intel.com> (03/05/23 1.1185.3.2)
   [bonding] ABI versioning
   
   This patch adds user-land to kernel ABI version control in bonding to
   restore backward compatibility between different versions of ifenslave and
   the bonding module. It uses ethtool's GDRVINFO ioctl to pass the ABI
   version number between ifenslave and the bonding module in both directions
   so both the driver and the application can tell which partner they're
   working against and take the appropriate measures when enslaving/releasing
   an interface. The bonding module remembers the ABI version received from
   the application, and from that moment on will deny enslave and release
   commands from an application using a different ABI version, which means
   that if you want to switch to an ifenslave with a different ABI version
   (or with non at all), you'll first have to re-load the bonding module.
   
   This patch also changes the driver/application versioning scheme to
   contain 3 fields X.Y.Z with the follows meaning:
   X - Major version - big behavior changes
   Y - Minor version - addition of features
   Z - Extra version - minor changes and bug fixes
   
   There are also three minor bug fixes:
   1. Prevent enslaving an interface that is already a slave.
   2. Prevent enslaving if the bond is down.
   3. In bond_release_all, save old value of current_slave before assigning
      NULL to it to enable using it's original value later on.
   
   This patch is against bonding-20030415.
   

<scott.feldman@intel.com> (03/04/27 1.1137.1.6)
   [netdrvr e1000] add TSO support -- disabled
   
   * Copy TSO support for 2.5 e1000.  Wrapped with NETIF_F_TSO, so
     not currently enabled in 2.4.  Done to keep 2.4 and 2.5 drivers
     in-sync as much as possible.
   

<scott.feldman@intel.com> (03/04/27 1.1137.1.5)
   [netdrvr e1000] add support for NAPI
   
   * Copy NAPI support from 2.5 e1000 driver
   * Add CONFIG_E1000_NAPI option
   

<dean@arctic.org> (03/04/27 1.1137.1.4)
   [netdrvr tulip] support DM910x chip from ALi

<jgarzik@redhat.com> (03/04/27 1.1137.1.3)
   Remove duplicate CONFIG_TULIP_MWI entry in Configure.help
   
   Noticed by Geert Uytterhoeven

<anton@samba.org> (03/04/27 1.1137.1.2)
   [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually

<Valdis.Kletnieks@vt.edu> (03/04/26 1.1131.2.6)
   [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

<jgarzik@redhat.com> (03/04/25 1.1131.2.5)
   [netdrvr sundance] small cleanups from 2.5
   
   - s/long flag/unsigned long flag/
   - C99 initializers

<edward_peng@dlink.com.tw> (03/04/25 1.1131.2.4)
   [netdrvr sundance] bug fixes, VLAN support
   
       - Fix tx bugs in big-endian machines
       - Remove unused max_interrupt_work module parameter, the new 
         NAPI-like rx scheme doesn't need it.
       - Remove redundancy get_stats() in intr_handler(), those 
         I/O access could affect performance in ARM-based system
       - Add Linux software VLAN support
       - Fix bug of custom mac address 
       (StationAddr register only accept word write) 

<edward_peng@dlink.com.tw> (03/04/25 1.1131.2.3)
   [netdrvr via-rhine] fix promisc mode
   
   I found a via-rhine bug, it can't receive BPDU (mac: 0180c2000000)
   in promiscuous mode. 
   Fill all "1" in hash table to fix this problem in promiscuous mode.
   (RCR remain 0x1c, write it as 0x1f don't work)

<riel@redhat.com> (03/04/25 1.1131.2.2)
   [wireless airo] fix end-of-array test
   
   FYI statsLabels[] is an array of char*, so the fix below
   is pretty obvious.

<bunk@fs.tum.de> (03/04/25 1.1131.2.1)
   [PATCH] fix .text.exit error in drivers/net/r8169.c
   
   In drivers/net/r8169.c the function rtl8169_remove_one is __devexit but
   the pointer to it didn't use __devexit_p resulting in a.text.exit
   compile error when !CONFIG_HOTPLUG.
   
   The fix is simple:

<jgarzik@redhat.com> (03/04/17 1.1101.8.7)
   [bonding] add support for IEEE 802.3ad Dynamic link aggregation
   
   Contributed by Shmulik Hen @ Intel, merge by Jay Vosburgh @ IBM

<jgarzik@redhat.com> (03/04/17 1.1101.8.6)
   [bonding] move private decls into new drv/net/bonding/bonding.h file

<jgarzik@redhat.com> (03/04/17 1.1101.8.5)
   [bonding] move driver into new drivers/net/bonding directory

<jgarzik@redhat.com> (03/04/17 1.1101.8.4)
   [bonding] Moved setting slave mac addr, and open, from app to the driver
   
   This patch enables support of modes that need to use the unique mac 
   address of each slave. It moves setting the slave's mac address and 
   opening it from the application to the driver.
   This breaks backward compatibility between the new driver and older 
   applications !
   It also blocks possibility of enslaving before the master is up (to 
   prevent putting the system in an unstable state), and removes the code 
   that unconditionally restores all base driver's flags (flags are 
   automatically restored once all undo stages are done in proper order).
   
   Contributed by Shmulik Hen @ Intel

<jgarzik@redhat.com> (03/04/17 1.1101.8.3)
   [bonding] add support for getting slave's speed and duplex via ethtool
   
   Contributed by Shmulik Hen @ Intel

<jgarzik@redhat.com> (03/04/17 1.1101.8.2)
   [bonding] fix comment to prevent future merge difficulties
   
   Contributed by Jay Vosburgh @ IBM

<jgarzik@redhat.com> (03/04/17 1.1101.8.1)
   [net] store physical device a packet arrives in on
   
   (Needed for bonding)
   
   Contributed by Jay Vosburgh @ IBM, Shmulik Hen @ Intel, and others.

