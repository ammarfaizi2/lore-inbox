Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTFZVxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTFZVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:53:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49338 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263084AbTFZVvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:51:36 -0400
Date: Thu, 26 Jun 2003 19:03:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre2
Message-ID: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here goes -pre2 with a big number of changes, including the new aic7xxx
driver.

I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
short.

Have fun


Summary of changes from v2.4.22-pre1 to v2.4.22-pre2
============================================

<bernie@develer.com>:
  o fix bug in drivers/net/cs89x0.c:set_mac_address()
  o [IPV4]: Trim the includes used in util.c

<cramerj@intel.com>:
  o [e1000] TSO fix
  o [e1000] Added ethtool test ioctl
  o [e1000] Added support for 82546 Quad-port adapter
  o [e1000] Removed strong branded device ids
  o [e1000] Fixed LED coloring on 82541/82547 controllers
  o [e1000] Miscellaneous code cleanup
  o [e1000] Whitespace cleanup

<dean@arctic.org>:
  o [netdrvr tulip] support DM910x chip from ALi

<dlstevens@us.ibm.com>:
  o [IPV{4,6}]: Fix "slow multicast on 2.5.69" bug

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Really search _backwards_ to find the oldest unreplied connection to evict

<green@linuxhacker.ru>:
  o current bk ipmi build fix

<hadi@shell.cyberus.ca>:
  o [NET]: Fix OOPSes with RSVP

<hall@vdata.com>:
  o [NETFILTER]: Fix two issues in the newnat core, with help from laforge@netfilter.org

<heiko.carstens@de.ibm.com>:
  o sd.c: set data direction to SCSI_DATA_NONE for START_STOP

<jejb@raven.il.steeleye.com>:
  o Add XRAYTEX to SCSI whitelist
  o sd.c: Backport wild spin loop mitigation from 2.5
  o Backport from 2.5: scsi allow devices to restrict start on add

<laforge@netfilter.org>:
  o [NETFILTER]: Cosmetic changes
  o [NETFILTER]: ip{,6}tables enhancement, add new /proc/net files
  o [NETFILTER]: Fix conntrack master_ct refcounting

<linux-kernel@vger.kernel.org>:
  o new eepro100 PDI ID

<marcel@holtmann.org[holtmann]>:
  o [Bluetooth] Add CAPI message transport protocol support

<mgreer@mivsta.com>:
  o PPC32: Fix /proc/sys/kernel/l2cr on newer CPUs

<mort@wildopensource.com>:
  o [NETFILTER]: Fix processor shifts in lockhelp.h

<mulix@mulix.org>:
  o ISDN: [PATCH] memory leak in tpam_queues.c

<oliver@vermuden.neukum.org>:
  o hfs-readonly-fix.diff

<qboosh@pld.org.pl>:
  o [NETFILTER]: Fix ip6tables alignment (64bit archs)
  o [NETFILTER]: Fix endianness bugs in conntrack
  o [NETFILTER]: Fix endianness bugs in ipt_nat

<reeja.john@amd.com>:
  o [netdrvr amd8111e] interrupt coalescing, libmii, bug fixes
  o [netdrvr amd8111e] link against mii lib
  o [netdrvr amd8111e] bug fix: move stats update after irq free

<riel@redhat.com>:
  o [wireless airo] fix end-of-array test

<sfrost@snowman.net>:
  o [NETFILTER]: Add iptables "recent" module

<shmulik.hen@intel.com>:
  o [bonding] ABI versioning
  o [bonding] better 802.3ad mode control, some cleanup
  o [bonding] much improved locking
  o [bonding] support xmit load balancing mode
  o [bonding] add rcv load balancing mode
  o [netdrvr bonding] fix long failover in 802.3ad mode
  o [netdrvr bonding] fix ABI version control problem

<solt@dns.toxicfilms.tv>:
  o [IPV4]: Be more verbose about invalid ICMPs sent to broadcast

<tonyb@cybernetics.com>:
  o make sym53c8xx_2 not reject autosense IWR

<valdis.kletnieks@vt.edu>:
  o [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

Adrian Bunk <bunk@fs.tum.de>:
  o fix .text.exit error in drivers/net/r8169.c
  o add three ACPI Configure.help entries

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o [netdrvr tlan] fix 64-bit issues

Andi Kleen <ak@muc.de>:
  o Remove copied inet_aton code in bond_main.c
  o ACPI compile fixes for 2.4.22pre1
  o Don't enable I2O for AMD64

Andrew Morton <akpm@digeo.com>:
  o Additional 3c980 device support

Andy Grover <agrover@groveronline.com>:
  o ACPI: Fix config.in (Jeff Garzik)
  o ACPI: make it so acpismp=force works (reported by Andrew Morton)

Anton Blanchard <anton@samba.org>:
  o [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually

Dave Engebretsen <engebret@us.ibm.com>:
  o [netdrvr pcnet32] bug fixes

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o Update JFS team members in jfs.txt
  o JFS: resize fixes

Douglas Gilbert <dougg@torque.net>:
  o sg driver version 3.1.25

Edward Peng <edward_peng@dlink.com.tw>:
  o [netdrvr via-rhine] fix promisc mode
  o [netdrvr sundance] bug fixes, VLAN support
  o [netdrvr sundance] fix flow control bug
  o [netdrvr sundance] fix another flow control bug

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o IPv6 over ARCnet (RFC2497) support, driver part
  o IPv6 over ARCnet (RFC2497) support, IPv6 part

Hugh Dickins <hugh@veritas.com>:
  o remove unsafe BUG() in __remove_inode_page()

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: Lynx platform support (Jay Estabrook)
  o alpha: initrd fix (Wiedemeier, Jeff)
  o alpha: nautilus poweroff

Jay Vosburgh <fubar@us.ibm.com>:
  o [bonding] small cleanups
  o Bonding 2.4 update patch 1
  o Bonding 2.4 update patch 2
  o Bonding 2.4 update patch 3
  o Bonding 2.4 update patch 4
  o Bonding 2.4 update patch 5
  o Bonding 2.4 update patch 6

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o irda: static init fixes
  o irda: Export CRC routine to drivers
  o irda: Mask C/R bit from connection
  o irda-usb driver fixes
  o IrCOMM chat fixes
  o QoS interoperability fixes
  o IrLMP timer race fix
  o Fix IrIAP skb leak
  o irda: Secondary nack code fixes

Jeff Garzik <jgarzik@redhat.com>:
  o [net] store physical device a packet arrives in on
  o [bonding] fix comment to prevent future merge difficulties
  o [bonding] add support for getting slave's speed and duplex via ethtool
  o [bonding] Moved setting slave mac addr, and open, from app to the driver
  o [bonding] move driver into new drivers/net/bonding directory
  o [bonding] move private decls into new drv/net/bonding/bonding.h file
  o [bonding] add support for IEEE 802.3ad Dynamic link aggregation
  o [netdrvr sundance] small cleanups from 2.5
  o Remove duplicate CONFIG_TULIP_MWI entry in Configure.help
  o [netdrvr eepro] update MODULE_AUTHOR per old-author request
  o [netdrvr tlan] backport fixes and cleanups from 2.5
  o [netdrvr] s/init_etherdev/alloc_etherdev/ in code comments, in 8139too and pci-skeleton drivers.
  o [netdrvr 8139too] add comment, whitespace cleanup
  o [netdrvr olympic] fix build with gcc 3.3
  o [netdrvr r8169] use alloc_etherdev (fix race), pci_disable_device
  o [netdrvr r8169] sync with 2.5 (backport whitespace cleanups)
  o [netdrvr amd8111e] remove out-of-tree feature that snuck in
  o [netdrvr] gcc 3.3 cleanups
  o [netdrvr sis900] minor fixes from 2.5

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Update the aic7xxx driver to 6.2.10 and add the aic79xx driver version 1.1.1
  o Correct building of aicasm
  o Update to aic7xxx version 6.2.22 and aic79xx 1.3.0_ALPHA2
  o Integrate 2.5.X aic7xxx and aic79xx changes
  o Misc driver updates
  o Integrate changes from Christoph Hellwig <hch@infradead.org>
  o Update to aic7xxx version 6.2.24 and aic79xx version 1.3.0_ALPHA5
  o Preface the "asserting atn" diagnostic with controller/target information
  o aic7xxx Driver
  o Aic7xxx Driver
  o Aic7xxx & Aic79xx Drivers Correct 2.5.X declaration for aic_sector_div().
  o Aic7XXX Firmware Assembler
  o Aic7XXX and Aic79XX drivers Use down_interruptable() rather than down() to avoid having our DV threads counted toward the load average.
  o Aic7XXX and Aic79XX drivers
  o Aic79XX and Aic7xxx Drivers
  o Aic7XXX and Aic79XX Drivers
  o Aic7XXX and Aic79xx Drivers
  o aic7xxx/aic79xx firmware assembler
  o aic7xx and aic79xx drivers - Correct several DV issues
  o aic7xxx and aic79xx driver updates
  o Aic7xxx and Aic79xx DV fix
  o Aic79xx Driver Update Enable abort and bus device reset handlers for both legacy and packetized connections.
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Update Force an SDTR after a rejected WDTR if the syncrate is unkonwn.
  o Aic7xxx Driver Update 6.2.28
  o Update Aic7xxx and Aic79xx Driver Documentation
  o Bump aic79xx version number to 1.3.0 now that it has passed functional testing.
  o Aic7xxx Driver Update to verstion 6.2.29
  o Update aic7xxx/Makefile
  o Update aicasm/Makefile so that link specifications are specified after all object files.  This seems to be required in order to link correctly in some cases.
  o Aic79xx Driver Update to 1.3.2
  o Update Aic7xxx to version 6.2.29
  o AICLIB Update
  o Update Aic7xxx driver [Rev 6.2.31]
  o Aic79XX Driver Update [Rev 1.3.5]
  o Change the callback argument for aic brace option parsing to u_long to avoid casting problems with different architectures.
  o Aic7xxx Driver Update (version 6.2.32)
  o Aic79xx Driver Update (version 1.3.6)
  o Complete merge of AC aic7xxx and aic79xx bits
  o Remove the CONFIG_AIC7XXX_ALLOW_MEMIO option.  It has been supplanted by the MEMIO probe/test code.
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver updates
  o Aic7xxx and Aic79xx driver updates
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Use absolute path to drivers/scsi in the aic7xxx Makefile
  o Aic79xx Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Upate
  o Remove pre-2.2.X kernel support.  Pre-2.2.X support requires
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Update Aic79xx and Aic7xxx Documenation
  o Aic79xx Driver Update (version 1.3.8)
  o Aic7xxx Driver Update (6.2.33)
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic79XX Driver Update
  o Aic7xxx Driver Update
  o Aic7xxx Driver README update
  o Aic79xx and Aic7xxx Driver Updates
  o Cset exclude: ak@muc.de|ChangeSet|20030508192559|45150 Cset exclude: marcelo@freak.distro.conectiva|ChangeSet|20030507201543|47130 Cset exclude: marcelo@freak.distro.conectiva|ChangeSet|20030507200707|47153
  o Aic7xxx and Aic79xx Updates
  o Aic79xx Update
  o Aic79xx Driver Update
  o Aic7xxx Driver version 6.2.35
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Updated
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Bump aic79xx driver version to 1.3.9
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Update Aic79xx Readme

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix Fritz!PCI v2 xmit irq underrun recovery
  o ISDN: Fix bug in ST5481 D-Channel state machine

Karsten Keil <kkeil@suse.de>:
  o ISDN: [PATCH] Fix problem with external hisax drivers

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o L2CAP config req/rsp handling fixes
  o [Bluetooth] Detect and log error condition when first L2CAP fragment is too long
  o [Bluetooth] RFCOMM must wait for MSC exchange to complete before sending the data
  o [Bluetooth] L2CAP sockets can now set LM_RELIABLE flag and get notification when we detect reliablity problem with the ACL connection.
  o [Bluetooth] Add support for SO_LINGER option to all Bluetooth protocols
  o Bluetooth: RFCOMM must send MSC when DLC was opened by SABM
  o [Bluetooth] Fix RFCOMM C/R and Direction bit handling
  o [Bluetooth] L2CAP qualification spec mandates sending additional config request if we receive config response with unacceptable parameters error code.

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Send the correct values in RPN response
  o [Bluetooth] Handle priority bits in parameter negotiation
  o [Bluetooth] Implement rfcomm_tty_put_char() function
  o [Bluetooth] Send correct RPN response for accepted values
  o [Bluetooth] Set EA bit for V.24 signals parameter
  o [Bluetooth] Handle bit rate in remote port negotiation
  o [Bluetooth] Quirk for devices with no ISOC endpoints

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre2
  o Cset exclude: jamagallon@able.es|ChangeSet|20030620200318|50799

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix the gen550 infrastructure for baud rates other than 9600

Olaf Hering <olh@suse.de>:
  o remove TIOCGDEV from asm/ioctls.h
  o RAID_AUTORUN is a compatible ioctl

Patrick McHardy <kaber@trash.net>:
  o ISDN: [PATCH]  missing cli() in isdn_net.c
  o ISDN: [PATCH] don't unlock lp if there is nothing to unlock
  o ISDN: Add CONFIG_IPPP_FILTER
  o [NETFILTER]: Dont call helpers expectfn() for unconfirmed connections

Paul Mackerras <paulus@samba.org>:
  o PPC32: Update for PPC 4xx TLB and exception handling
  o PPC32: Add a new framework for on-chip peripherals for the IBM 4xx embedded processors.
  o PPC32: Introduce a new config symbol, CONFIG_40x, used for PPC 40x cpus
  o PPC32: Add generic IBM PPC405GP support and use it on the walnut platform
  o PPC32: Update the support for the "Walnut" 405GP platform
  o PPC32: Make debug exceptions usable on 4xx-class processors, and improve trap handling.
  o PPC32: Add support for PPC 405GP interrupt controller
  o PPC32: Extra register and other definitions for the PPC 405GP processor
  o PPC32: Move PC-style serial port definitions out to asm/pc_serial.h
  o PPC32: remove ppc4xx_serial.h, it is no longer used
  o PPC32: Cleanups for PPC 405GP-based systems; add file of OCP ids
  o PPC32: Don't run `checks' program on make zImage
  o PPC32: Add definitions for the UIC interrupt controller on the 405GP processor
  o PPC32: Add support for PCI and time-of-day clock on 405GP-based systems
  o PPC32: Allow for PCI host bridges that need explicit type 1 cycle indication

Randy Dunlap <rddunlap@osdl.org>:
  o unexpected IO-APIC code update

Rusty Russell <rusty@rustcorp.com.au>:
  o [irda] module refcounts for irlan
  o [patch, 2.5] dgrs doesn't free on error path
  o namespace pollution in cosa driver
  o [2.4 patch] fix wavelan_cs compile warning
  o Clear up GFP confusion in rcpci45.c
  o [patch, 2.5] fix errorpath in apne.c
  o Remove naked GFP_DMA from drivers_net_macmace.c
  o namespace pollution in skfddi driver
  o improve signal-to-noise ratio in atm code
  o 2.4.20 wait.h doc typo
  o fs_autofs4_root.c unused variable
  o [TRIVIAL PATCH 2.4] update README file to current
  o fix documentation in include_asm-i386_bitops.h
  o missing headers in i82092.c
  o fix linewrap in Documentation_power_pci.txt
  o include_asm-ia64_sal.h, typo: the the
  o Typos in drivers_s390_net_iucv.h
  o [TRIVIAL PATCH] include_asm-i386_dma.h: wrong lowest DMA
  o redundant declarations (#1_15)
  o add some missing init.h inclusions
  o remove superflous if in wait_kio
  o Squash warning in ppc64 addnote tool
  o fix linewrap in Documentation_filesystems_sysv-fs.txt
  o set b_page to null in fake buffer_head for O_DIRECT
  o fix linewrap in Documentation_pci.txt
  o misc_register audit fix of wdt_pci
  o misc register fix on ds1286
  o reorganize for unreachable code

Sam Ravnborg <sam@mars.ravnborg.org>:
  o [netdrvr sis900] make function headers readable by kernel-doc tool

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e1000] add support for NAPI
  o [netdrvr e1000] add TSO support -- disabled
  o 10GbE ethtool support
  o remove ethtool privileged references
  o [e100] Remove "Freeing alive device" warning
  o [e100] move e100_asf_enable under CONFIG_PM to avoid warning
  o [e100] Add ethtool parameter support
  o [e100] Add ethtool cable diag test
  o [e100] Add MDI/MDI-X status to ethtool reg dump
  o [e100] cleanup Tx resources before running ethtool diags
  o [e100] full stop/start on ethtool set speed/duplex/autoneg
  o [e100] fixed stalled stats collection
  o [e100] VLAN configuration was lost after ethtool diags run
  o [e100] use skb_headlen() rather than rolling own
  o [e100] set netdev members before registration
  o [e100] misc

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Clean up the cpu_idle() code a bit
  o PPC32: Fix a multicast bug in the MPC 8xx / 8260 enet drivers
  o PPC32: Correct the DTLB miss handler on MPC8xx
  o PPC32: Fix a problem with MDIO requests on reset in MPC 8xx enet
  o PPC32: Minor cleanups to the MPC 8xx FEC driver
  o PPC32: Fix a small problem in the 8xx / 8260 uart code
  o PPC32: Important fixes in the MPC8xx FEC and MPC826x enet driver
  o PPC32: Describe when we want to do a CPM reset on MPC8xx
  o Add /proc/sys/kernel/l3cr

Zwane Mwaikambo <zwane@linuxpower.ca>:
  o Remove warning due to comparison in drivers/net/pcnet32.c

