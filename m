Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTICVvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTICVvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:51:21 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:16901 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261533AbTICVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:51:08 -0400
Date: Wed, 3 Sep 2003 18:53:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre3
Message-ID: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, here goes -pre3. Most changes are network and network driver
updates. We also have DRM supporting XFree 4.3 now.

As one may have noticed from my email address I got a new job: Cyclades is 
now sponsoring my kernel work.


Detailed changelog below


Summary of changes from v2.4.23-pre2 to v2.4.23-pre3
============================================

<adam:os.inf.tu-dresden.de>:
  o Add kmap_types.h to include/asm-alpha

<cw:sgi.com>:
  o Remove kdb hooks from SGI Altix Console driver
  o SGI fetchop driver

<javier:tudela.mad.ttd.net>:
  o [wireless airo] Build fixes when MIC disabled
  o [wireless airo] PCI detection code fixes
  o [wireless airo] MIC support using CryptoAPI

<marcelo:logos.cnet>:
  o Updated my contact information
  o Change contact information, again
  o Cset exclude: agruen@suse.de|ChangeSet|20030902115108|61891
  o Adrian & Chantal: Unused variable in ip2main.c
  o Changed EXTRAVERSION to -pre3

<ntfs:flatcap.org>:
  o Fix NTFS build warnings

<purna:jcom.home.ne.jp>:
  o [netdrvr] fix skb_padto bugs introduced when skb_padto was introduced

<xose:wanadoo.es>:
  o [TG3]: More missing PCI ids
  o [TG3]: ICH2 needs MBOX write reorder bug workaround too
  o [netdrvr 3c59x] update pci ids

Adrian Bunk:
  o Fix IRQ_NONE clash in SCSI drivers
  o [wireless airo] fix build with gcc 2.95

Andrew Morton:
  o inodes_stat.nr_inodes race fix

David S. Miller:
  o [SPARC]: Fix uniprocessor build
  o [SPARC64]: In sysv IPC translation, mask out IPC_64 as appropriate
  o [IPV6]: Do not BUG() on icmp6 socket contention, just drop
  o [IPV4]: Do not BUG() on icmp_xmit_lock() contention, just drop

Harald Welte:
  o [NETFILTER]: Fix routing key in ipt_MASQUERADE.c

Hirofumi Ogawa:
  o [netdrvr 8139too] remove driver-based poisoning of net_device
  o [netdrvr 8139too] don't start thread when it's not needed

Ivan Kokshaysky:
  o [PCI] update Memory-Write-Invalidate (MWI) transaction support

Jeff Garzik:
  o [TG3]: Remove pci-set-dma-mask casts
  o [netdrvr 8139cp] build TX checksumming code, but default OFF
  o [netdrvr 8139cp] support NAPI on RX path; Ditch RX frag handling
  o [netdrvr 8139cp] update todo list in header
  o [netdrvr 8139cp] remove mentions of RTL8169 (now handled by "r8169")
  o [netdrvr 8139cp] small cleanups
  o [netdrvr 8139cp] fix NAPI bug; remove board_type distinction, not needed
  o [netdrvr 8139cp] bump version
  o [netdrvr 8139cp] stats improvements and fixes
  o [netdrvr 8139too] make features more persistent; fix PCI DAC mode
  o [netdrvr pcmcia] support SIOC[GS]MII{PHY,REG} ioctls
  o [netdrvr 8139too] remove useless board names
  o [ia32] add PCI id for VIA irq router
  o [PCI] fix export of pdev_set_mwi/pci_generic_prep_mwi
  o [BK] ignore auto-generated files lib/{crc32table.h,gen_crc32table}
  o [netdrvr 8139cp] must call NAPI-specific vlan hook
  o [netdrvr 8139cp] PCI MWI cleanup; remove unneeded workaround
  o [netdrvr 8390] new function alloc_ei_netdev()
  o [netdrvr ne2k-pci] allocate netdev+8390 struct using new alloc_ei_netdev()
  o [netdrvr ne2k-pci] sync with 2.5 (100% minor cleanups)
  o [netdrvr ne2k-pci] ethtool_ops support
  o [NET] move netif_* helpers from tg3 driver to linux/netdevice.h
  o [NET] s/blog_dev/backlog_dev/ in process_backlog, net/core/dev.c
  o [netdrvr] ethtool_ops for epic100, fealnx, winbond-840, via-rhine
  o [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840
  o [NET] move ethtool_op_set_tx_csum from 8139cp drvr to net/core/ethtool.c, where it belongs.
  o [PCI, ia32] don't assume "c->x86 > 6" applies to non-Intel CPUs when programming PCI cache line size.
  o [netdrvr] add MV-64340 gigabit ethernet driver (MIPS only)
  o [netdrvr 3c515] fix non-modular build
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030826234629|07076

John Stultz:
  o Convert /proc/interrupts to use seq_file

Krzysztof Halasa:
  o generic HDLC update

Manuel Estrada Sainz:
  o request_firmware() backport to 2.4 kernels

Marc-Christian Petersen:
  o aty128fb: find the video bios on a Latitude C600 (M3) Inspiron 8000 (M4)
  o Update DRI/DRM so XFree v4.3.0 and above works
  o Disable alpha S3 Savage/VIACLE266 DRM support
  o Add missing IRQ_NONE clash fix hunk

Marcel Holtmann:
  o Make request_firmware() compile if hotplug support is disabled
  o Firmware loading depends on hotplug support
  o [Bluetooth] Make use of request_firmware() for the BlueFRITZ! USB driver
  o Make request_firmware() compile cleanly
  o PCI quirk for SMBus bridge on Asus P4 boards

Matthew Wilcox:
  o [ethtool] fix ethtool_get_strings counting bug
  o [netdrvr 8139too] ethtool_ops support

Mirko Lindner:
  o [netdrvr sk98lin] update to driver version 6.17

Paul Mundt:
  o [netdrvr 8139too] fix and pci ids needed for SH platform

Paulo Ornati:
  o small config fix for ISDN

Rob Radez:
  o [SPARC]: gcc-3.3 compile fixes, part 1
  o [SPARC]: gcc-3.3 compile fixes, part 2
  o [SPARC]: gcc-3.3 compile fixes, part 3

Shmulik Hen:
  o [list] backport list_for_each_entry_safe macro from 2.6
  o [netdrvr bonding] fix /proc read function
  o [netdrvr bonding] use linked list to handle multiple bond devices
  o [netdrvr bonding] update credits/version
  o [netdrvr bonding] add another ifenslave.c include
  o [netdrvr bonding] update slave setting propagation
  o [netdrvr bonding] Change monitoring function to use new slave setting propagation
  o [netdrvr bonding] Modes that don't use primary don't use the new prop. code
  o [netdrvr bonding] Decouple promiscuous handling from the multicast mode setting
  o [netdrvr bonding] support for changing HW address and MTU
  o [netdrvr bonding] support for changing MAC addr, MTU in ALB/TLB modes
  o [netdrvr bonding] Consolidate /proc code, add CHANGENAME handler
  o [netdrvr bonding] Enhance netdev notification handling

Stelian Pop:
  o reenable CAPTURE button in sonypi
  o meye driver update


