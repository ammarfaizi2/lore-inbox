Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTH0R51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTH0R51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:57:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28066 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262050AbTH0R5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:57:09 -0400
Date: Wed, 27 Aug 2003 14:52:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.23-pre1
Message-ID: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here goes the first -pre of 2.4.23. It contains a bunch of updates spread
all over, most notably networking.

There are still pending patches in my queue, but I though "Ok, enough
patches for a -pre. "


Detailed changelog below


Summary of changes from v2.4.22 to v2.4.23-pre1
============================================

<achirica:telefonica.net>:
  o [netdrvr airo] Missing defines (only for documentation)
  o [netdrvr airo] MAC type changed to unsigned
  o Missing lines for Wireless Extensions 16
  o MIC support with newer firmware
  o Safer unload code
  o Fix adhoc config

<amir.noam:intel.com>:
  o [net] export alloc_netdev
  o [netdrvr bonding] embed stats struct inside bonding private struct

<davej:redhat.com>:
  o [IPV6]: Missing break in switch statement of rawv6_getsockopt()
  o [IPV4]: /proc/net/pnp dumps items marked initdata

<emann:mrv.com>:
  o [VLAN]: Fix OOPS on module removal

<jan.oravec:6com.sk>:
  o [NET]: Set NLM_F_MULTI in answer of RTM_GETADDR dump answer

<jan:zuchhold.com>:
  o [TG3]: Recognize Altima AC1001 device IDs

<javier:tudela.mad.ttd.net>:
  o [wireless airo] Fixes unregistering of PCI cards
  o [wireless airo] Replaces task queues by simpler kernel_thread

<jdewand:redhat.com>:
  o [SPARC64]: Fix cdrom ioctl32 translations

<kambo77:hotmail.com>:
  o [NET]: Fix hang/memleak in pktgen

<kartik_me:hotmail.com>:
  o [CRYPTO]: Add cast5, integration by jmorris@intercode.com.au

<marcelo:logos.cnet>:
  o pcwd.c: fix oops on unload
  o Cset exclude: m.c.p@wolk-project.de|ChangeSet|20030825183254|28555
  o Cset exclude: m.c.p@wolk-project.de|ChangeSet|20030825194257|34486
  o Fix possible IRQ handling SMP race: Kudos to TeJun Huh
  o Changed EXTRAVERSION to -pre1

<matthewn:snapgear.com>:
  o [netdrvr 8139cp] fix h/w vlan offload

<michel:daenzer.net>:
  o [NET]: Make sure interval member of struct tc_estimator is signed

<mmagallo:debian.org>:
  o AGPGART support for Intel 7x05 chipsets (backported from 2.6)

<skewer:terra.com.br>:
  o [NET]: Remove dead comment from dummy.c driver

<sziwan:hell.org.pl>:
  o [netdrvr 8139too] fix resume behavior, by correctly saving/restoring pci state.

<tv:debian.org>:
  o [NET]: Flush hw header caches on NETDEV_CHANGEADDR events

<wensong:linux-vs.org>:
  o [IPV4]: Add IP Virtual Server to 2.4.x

Alexey Kuznetsov:
  o [IPV4]: IP options were not updated while forwarding multicasts
  o [PKT_SCHED]: More reasonable PSCHED_JSCALE for various values of HZ
  o [IPV4]: Fix rt_score() and usage when purging rtcache hash chains

Andi Kleen:
  o Compile fix for ACPI in 2.4.22/x86-64

Anton Blanchard:
  o [NET]: Add missing memory barriors for __LINK_STATE_RX_SCHED handling

Arjan van de Ven:
  o Fix asm constraint bug in arch/i386/kernel/pci-pc.c

Arnaldo Carvalho de Melo:
  o irqreturn_t compatibility with 2.6

Ben Collins:
  o [SPARC64]: In pci_common.c:find_device_prom_node() recognize PCI_DEVICE_ID_SUN_TOMATILLO
  o [SPARC64]: In clock_probe(), treat m5819p just like m5819

Benjamin Herrenschmidt:
  o [NET]: Do not call request_irq with spinlock held in sungem.c

Chas Williams:
  o [ATM]: export try_atm_clip_ops not atm_clip_ops_mutex

Christoph Hellwig:
  o fix copy_namespace()
  o use list_add_tail in buffer_insert_list
  o reserve a sysctl number for XFS (pagebuf)

Dave Kleikamp:
  o JFS: If unicode conversion fails, operation should fail
  o JFS: Make error return codes negative
  o JFS: K&R to ANSI conversions for fs/jfs/jfs_dmap.c and jfs_xtree.c
  o JFS: add nointegrity mount option (Karl Rister)

David S. Miller:
  o [SPARC64]: Add Ultra-IIIi/Jalapeno support
  o [SPARC64]: Add JIO/Tomatillo PCI controller support
  o [SPARC64]: Read processor number correctly on Ultra-IIIi/Jalapeno
  o [SPARC64]: In ISA support, is interrupt-map exists use it
  o [SPARC64]: Finalize TOMATILLO/JIO support, help from bcollins@debian.org
  o [TG3]: Support OBP firmware mac-addresses on sparc64
  o [SPARC64]: Sanitize PCI controller handling to support Tomatillo better
  o [SPARC64]: Pass correct args to data_access_exception() in unaligned.c
  o [SPARC64]: Make sure to reject all PCI DAC dma masks
  o [SPARC64]: In schizo driver, if virtual-dma property exists, respect it
  o [ATM]: Remove -g option from driver directory CFLAGS
  o [SPARC64]: More tomatillo PCI controller fixes
  o [TG3]: More Sun onboard 5704 fixes
  o [TG3]: Only call tg3_init_rings() after hardware has been reset
  o [SPARC64]: Fix AFSR error reporting for Cheetah+/Jalapeno
  o [SPARC64]: Missing cheetah+ ASI defines
  o [SPARC64]: Fix unused variable warnings when using iounmap()
  o [SPARC64]: Do not make sparc_{cpu,fpu}_type a NR_CPUS array
  o [NET]: Export neigh_changeaddr
  o [SPARC64]: Add some missing PCI error reporting
  o [TG3]: Fix AC1001 typo in pci_ids.h
  o [NET]: Include asm/uaccess.h in net/core/ethtool.c

Harald Welte:
  o [NETFILTER]: Backport iptables AH/ESP fixes from 2.6.x
  o [NETFILTER]: Fix uninitialized return in iptables tftp
  o [NETFILTER]: NAT optimization
  o [NETFILTER]: Conntrack optimization (LIST_DELETE)

Hideaki Yoshifuji:
  o [IPV6]: Fix typo in linux/ipv6.h

Ion Badulescu:
  o [netdrvr tulip] add pci id for 3com 3CSOHO100B-TX

Jack Hammer:
  o ServeRAID 6.10 Driver Update

Jeff Garzik:
  o [ia32] Via, Intel cpu capabilities update
  o [hw_random] add combined Intel+AMD+VIA h/w RNG driver
  o [NET]: Backport ethtool_ops from 2.6.x
  o [ia32] mention that X86_VENDOR_ID is tied to NCAPINTS, in a comment in arch/i386/kernel/head.S.

John Stultz:
  o Do not clear SMI pin at bootup
  o Handle clustered XAPIC in set_ioapic_affinity()

Keith M. Wesolowski:
  o [SPARC]: Trap table alignment for HyperSPARC

Krishna Kumar:
  o [IPV6]: Reporting of prefix routes via rtnetlink

Marc-Christian Petersen:
  o Cleanup kmem_cache_reap()
  o Fix initrd with netboot
  o Cleanup DRM submenu
  o Replace bogus and obsolete "#if __SMP__" -> CONFIG_SMP
  o Allow console switching after kernel panic()
  o Unblank console if panic()
  o Handle get_block errors correctly in block_read_full_page()
  o LVM Update v1.0.5 to v1.0.7
  o CONFIG_NR_CPUS
  o Avoid potentially leaking pagetables into the per-cpu queues
  o Proper APIC with HyperThreading

Martin Devera:
  o [NET]: Fix bugs in sch_htb packet scheduler

Mikael Pettersson:
  o [ia32] adjust X86_VENDOR_ID offset in head.S, due to new NCAPINTS
  o 2.4.22 local APIC updates 1/3: remove incorrect blacklist rules
  o 2.4.22 local APIC updates 2/3: add lapic/nolapic options
  o 2.4.22 local APIC updates 3/3: disable APIC_BASE on reboot

Patrick McHardy:
  o [NET]: Fix no_cong_thresh sysctl

Randy Dunlap:
  o [NET]: Audit copy_from_user checks in pktgen

Robert Olsson:
  o [NET]: Remove some debugging from pktgen

Rusty Russell:
  o [NETFILTER]: Fix masquerade routing check, backport to 2.4 by kurd@cp.rtfm.se

Stelian Pop:
  o sonypi driver update
  o meye driver updates

Stephen Hemminger:
  o [BRIDGE]: Mailing list is at osdl.org now
  o [VLAN]: Allow it to compile with VLAN_DEBUG enabled

Willy Tarreau:
  o Fix amd67x_pm.c crash with no chipsets / CONFIG_HOTPLUG
  o make log buffer length selectable



