Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJDBnU>; Thu, 3 Oct 2002 21:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJDBnU>; Thu, 3 Oct 2002 21:43:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31637 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261434AbSJDBnS>; Thu, 3 Oct 2002 21:43:18 -0400
Date: Thu, 3 Oct 2002 22:11:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre9
Message-ID: <Pine.LNX.4.44L.0210032203570.6478-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Athlon problems introduced in pre3 should be gone now.

pre9 has some JFS/ext3 fixes, USB fixes and several network drivers fixes.

There are still some pending issues to be solved for 2.4.20 which I hope
get worked out on the next -pre's...


Summary of changes from v2.4.20-pre8 to v2.4.20-pre9
============================================

<alex_williamson@attbi.com>:
  o fs/partitions/sun.c: raid autodetect for sun disk labels

<brihall@pcisys.net>:
  o Update for JMTek USBDrive

<devik@cdi.cz>:
  o net/sched/sch_htb.c: Verify classid and direct_qlen properly

<felipewd@terra.com.br>:
  o Support get-MII-data ioctls in 8139cp net driver

<hch@sgi.com>:
  o fix drm ioctl ABI default

<helgaas@fc.hp.com>:
  o pc_keyb.c: hook for keybd controller detection
  o Configure.help update (1/2)
  o AGPGART 2/5: size AGP mem correctly when memory is
  o ati_pcigart: support 16K and 64K page size
  o Configure.help update (2/2)
  o PCI ID database update

<jes@trained-monkey.org>:
  o acenic net drvr fix: remove '=' typo in intr mask writel()

<marcelo@freak.distro.conectiva>:
  o Place buffer dirtied in truncate() on inode's  dirty data list (Eric Sandeen)
  o Enable CONFIG_DRM_I810_XFREE_41 so we are compatible with XFree 4.1 as default
  o Changed EXTRAVERSION to -pre9

<rgcrettol@datacomm.ch>:
  o USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix

<schoenfr@gaaertner.de>:
  o net/ipv4/proc.c: Dont print dummy member of icmp_mib

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Bump ext3 version number
  o 2.4.20-pre4/ext3: Fix LVM snapshot deadlock
  o 2.4.20-pre4/ext3: jbd commit interval tuning
  o Sanity check for Intermezzo/ext3
  o ext3 commit notification for Intermezzo
  o Fix the order of inodes being marked dirty in a couple of corner cases

<thiel@ksan.de>:
  o Kernel TUN/TAP Documentation rework

<yoshfuji@linux-ipv6.org>:
  o [IPv6]: Verify ND options properly
  o net/ipv6/addrconf.c: Refine IPv6 Address Validation Timer
  o net/ipv6/ndisc.c: Add missing credits
  o net/ipv6/ip6_fib.c: Default route support on router

Adrian Bunk <bunk@fs.tum.de>:
  o add "If unsure, say N" to CONFIG_X86_TSC_DISABLE
  o Configure.help entry for the e100 driver (fwd)

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o security - various bits in iee1394
  o Fix config.in breakage from mips people
  o resend maestro3 update

Andi Kleen <ak@muc.de>:
  o Fix disabling of x86 capabilities from command line
  o Fix pageattr with mem=nopentium

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix problems with NFS
  o JFS: detect and fix invalid directory index values
  o JFS: Remove assert(i < MAX_ACTIVE)

David S. Miller <davem@nuts.ninka.net>:
  o net/ipv4/netfilter/ip_conntrack_proto_tcp.c: Include linux/string.h
  o drivers/block/ll_rw_blk.c: u64 is not necessarily long long
  o init/do_mounts.c: Protect cramfs stuff with CONFIG_BLK_DEV_RAM too
  o drivers/net/acenic.h: readl is not an lvalue
  o drivers/net/ppp_generic.c:ppp_receive_frame Kill unused local label

Edward Peng <edward_peng@dlink.com.tw>:
  o update sundance driver to support building on older kernel

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added Palm Zire support to the visor driver

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: Trivial fixes

James Morris <jmorris@intercode.com.au>:
  o net/ipv4/netfilter/ipchains_core.c: Use GFP_ATOMIC under ip_fw_lock

Javier Achirica <achirica@ttd.net>:
  o sync airo wireless driver with 2.5
  o airo wireless: use ETH_ALEN constant where appropriate
  o airo wireless: disable access to card while prom flashing in progress [note: more work needs to be done here, but this is better than nothing -jgarzik]
  o airo wireless: more verbose MAC-enable errors
  o airo wireless: power down on if down. add local 'ai' to fix build
  o airo wireless: fix "non-probe mode" setup
  o airo wireless: Fixes signal level retrieval in SPY mode (releases memory block after read out)
  o airo wireless net drvr: add Cisco MIC support Conditionally enabled when out-of-tree, but open source, crypto lib is present.

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o irtty MODEM_BITS additional fix

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Update eepro100 net driver's mdio_{read,write} functions to take 'struct net_device *' not 'long' as their first argument.  This makes eepro100 compatible with the standard MII ethtool API, preparing it for that support.
  o update eepro100 net driver to use standard MII phy API/lib, when implementing ethtool media ioctls.
  o Add new MII lib functions mii_check_link, mii_check_media
  o sundance net drvr: fix reset_tx logic (contributed by Edward Peng @ D-Link, cleaned up by me)
  o sundance net drvr: fix DFE-580TX packet drop issue, further reset_tx fixes (contributed by Edward Peng @ D-Link)
  o sundance net drvr: bump version to LK1.05
  o [net drivers] fix MII lib force-media ethtool path (contributed by Edward Peng @ D-Link)
  o sis900 net driver update
  o [net drivers] MII lib update
  o [net drivers] Rename MII lib API member, s/duplex_lock/force_media/, and update all drivers that reference this struct member.
  o Add MII lib helper func generic_mii_ioctl, use it in 8139cp net drvr
  o Use new MII lib helper generic_mii_ioctl in several net drivers
  o [net drivers] Remove 'dev' argument from generic_mii_ioctl helper
  o [net drivers] add optional duplex-changed arg to generic_mii_ioctl helper

Oliver Neukum <oliver@neukum.name>:
  o USB: update of hpusbscsi
  o USB: fixes for kaweth

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o [NCPFS]: 32->64bit sparc64 conversions

Richard Henderson <rth@twiddle.net>:
  o alpha strncpy fix

Rusty Russell <rusty@rustcorp.com.au>:
  o Remove list_head typedef

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o Fix sb1000 jiffies usage: kill float constant, use time_after_eq()
  o fix compares of jiffies


