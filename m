Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319126AbSH1Xaf>; Wed, 28 Aug 2002 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319127AbSH1Xaf>; Wed, 28 Aug 2002 19:30:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54542 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319126AbSH1Xab>; Wed, 28 Aug 2002 19:30:31 -0400
Date: Wed, 28 Aug 2002 19:46:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre5
Message-ID: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes pre5.

Mainly merging with Alan and others.


Summary of changes from v2.4.20-pre4 to v2.4.20-pre5
============================================

<andersen@codepoet.org>:
  o 2.4.20-pre[234] hosed /proc/partitions fix

<bhavesh@avaya.com>:
  o Fix scheduler's RT behaviour

<danc@mvista.com>:
  o PPC32: Add support for SBS Palomar 4 board

<davem@pizda.ninka.net>:
  o SPARC64: Initial Cheetah-plus support, not fully debugged yet

<dwmw2@redhat.com>:
  o Another JFFS2 oops fix

<dz@cs.unitn.it>:
  o latest version of i8k module

<engebret@us.ibm.com>:
  o Re: [PATCH] PPC64 update to 2.4.19-rc1

<hch@lst.de>:
  o Merge ETHTOOL_GDRVINFO support for several pcmcia net drivers
  o update drm to XFree 4.2 version
  o use -iwithprefix to find gcc headers
  o fix theoretical race init pagefault init survive path

<james@cobaltmountain.com>:
  o drivers_usb_usb-uhci.c, typo: the the, missing 'of'
  o drivers_usb_auerswald.c, typo: the the
  o net/ipv4/netfilter/ip_conntrack_core.c: Fix comment typo
  o net/ipv4/netfilter/ip_nat_core.c: Fix comment typo

<jani@iv.ro>:
  o tridentfb bitdepths in Config.in

<jgarzik@tout.normnet.org>:
  o Correct xdr_shift_buf prototype in inc/linux/sunrpc/xdr.h to match implementation (s/unsigned int/size_t/).

<jsiemes@web.de>:
  o net/ipv4/ipconfig.c: Add support for multiple nameservers

<jwoithe@physics.adelaide.edu.au>:
  o Support for Buffalo 40GB USB hard disk

<kisza@sch.bme.hu>:
  o net/ipv6/netfilter/ip6_tables.c: Fix extension header parsing bugs

<mark@alpha.dyndns.org>:
  o USB: ov511 1.61 for 2.4

<paulus@au1.ibm.com>:
  o PPC32: add support for the IBM "Spruce" reference platform
  o PPC32: clean up the interrupt handling on the APUS platform

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Handle dirty buffers encountered
  o 2.4.20-pre4/ext3: Fix "buffer_jdirty" assert failure
  o 2.4.20-pre4/ext3: Fix the "dump corrupts filesystems"
  o 2.4.20-pre4/ext3: Fix buffer alias problem
  o 2.4.20-pre4/ext3: Truncate leak fix
  o 2.4.20-pre4/ext3: Fix out-of-inodes handling
  o 2.4.20-pre4/ext3: fsync optimisation
  o 2.4.20-pre4/ext3: Fix truncate restart error
  o 2.4.20-pre4/ext3: Performance fix for O_SYNC behaviour

<solar@openwall.com>:
  o net/unix/af_unix.c: Set ATIME on socket inode

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o SBUS: extern->static inline
  o these were wrong - they've been right in -ac for ages
  o add config.in for new synclink mp
  o parisc config.in
  o note the initrd vanishing bug and block size issue
  o docs for isapnp update in pre4
  o make synclink vars static
  o fix wrap handling in ieee1394
  o fix warning in i2o
  o set DMA mask in i2o
  o typo fixes for aic7xxx
  o ixj wrong definition
  o zorro proc should use loff_t too
  o hppa also needs a weird kstat
  o only egcs had this problem so dont pad on 2.95+
  o cache align the irq stat
  o sparc64 fix pcibios for changes in pre4
  o new dmi entries
  o long standing khttpd fix
  o generic part of rw trylocks
  o update parport ifdefs for HPPA
  o resend - HIL input bus
  o down_write_trylock
  o fix EFS on cd crash
  o add hppa to fbcon data
  o quieten the latency message
  o ppc64 missing ioctl32 gunk
  o hppa like ia64 doesnt use the old ipc structs
  o new sem_getcount means this cna go
  o more typo fixes
  o typo fixes ctd
  o fix the via rhine
  o fix bttv_read type error
  o fix detected_devices type error
  o isdn gcc warning fixer
  o vt.c clean up ifdefs
  o update /proc description
  o journalling docs
  o PCI fixes
  o docs for ldm update
  o ps2esdi - wrong bit
  o driver for AMD watchdog
  o add synclink_mp
  o saner error return for hotplug
  o i2o typo fix
  o e1000 - return without code
  o decruft smodem
  o fix pci_release/request_regions bugs
  o fix __FUNCTION__ in irda-usb

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o arch/i386/lib/checksum.S: Handle zero length

Brian Beattie <beattie@beattie-home.net>:
  o patch for 2.4 scanner.h add device ids

David S. Miller <davem@nuts.ninka.net>:
  o arch/sparc64/defconfig: Update
  o include/linux/sunrpc/svcsock.h: Make sk_flags a long
  o include/linux/sunrpc/svcsock.h: sk_flags must be a long for bitops
  o SPARC: Update for changed pcibios_enable_device args
  o include/linux/sunrpc/xdr.h: Kill xdr_zero_buf decl, fix xdr_shift_buf args
  o arch/sparc64/mm/ultra.S: Fix branch condition in __cheetah_flush_tlb_range
  o include/asm-sparc/types.h: No need to make dma64_addr_t 64-bits on sparc32
  o SPARC64: Fix obscure cheetah+ hangs
  o TIGON3: Add missing udelay when clearing SRAM stats/status block
  o SPARC64: Fix DRM to use new not old drivers
  o net/unix/af_unix.c: Set msg_namelen in unix_copy_addr properly, define MODULE_LICENSE
  o net/ipv4/tcp_diag.c: Avoid unaligned accesses to tcpdiag_cookie
  o SPARC64:setup_arch Flush correct I-cache line when patching irqsz_patchme
  o SPARC64: Ultra-III+ bug fix and better bad trap logging

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: documentation updates
  o USB: ov511 driver update to the latest version
  o USB: pegasus driver update to the latest version
  o microtek driver update to the latest version
  o wacom driver update to fix incorrect data problem
  o USB: minor cleanups and __FUNCTION__ fixes
  o USB: fix some USB 2.0 hub bugs
  o update to latest version of rtl8150 driver
  o minor printer driver fixes
  o stv680 driver update to latest version
  o USB: usb-ohci bug fix for slow machines and cardbus bug fix
  o USB: uhci incorrect bit operations and FSBR timeout fixes
  o added Configure.help entry for the ACPI PCI Hotplug driver
  o PCI Hotplug: fixed oops when accessing pcihpfs

Hanna Linder <hannal@us.ibm.com>:
  o path_lookup for 2.4.20-pre4

Hugh Dickins <hugh@veritas.com>:
  o M386 flush_one_tlb invlpg

James Morris <jmorris@intercode.com.au>:
  o [NETFILTER]: ip{,6}_queue.c cleanups and fixes

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Fix 8139cp 64-bit DMA support
  o Update e1000 net driver for two small ethtool fixes

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Revert broken cpqarray statistics change in previous -pre
  o Readded context_swtch to kernel_stat structure
  o Changed EXTRAVERSION to -pre5

Neil Brown <neilb@cse.unsw.edu.au>:
  o SUNRPC 1 of 3 - The new "sk_flags" word in struct svc_sock
  o SUNRPC 2 of 3 - Fix two problems with multiple concurrent
  o SUNRPC 3 of 3 - Call svc_sock_setbufsize when socket

Rob Radez <rob@osinvestor.com>:
  o SPARC32: Sparc32 compile fixes with CONFIG_PCI enabled

Rusty Russell <rusty@rustcorp.com.au>:
  o [PATCH] duplicate declarations #2
  o 2.5: kconfig missing OBSOLETE (2_3) again
  o Documentation_filesystems_devfs_README, typo: the the
  o Trivial Patch to SonyCD535 documentation
  o drivers_net_rcpci45.c, typo: the the
  o drivers_net_pcmcia_xircom_cb.c, typo: the the,
  o Re: pci_alloc_consistant gfp flag fix
  o drivers_net_winbond-840.c, typo: the the
  o list_for_each_entry

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver update 1/3
  o e100 net driver update 2/3
  o e100 net driver update 3/3
  o e1000 net driver update 1/5
  o e1000 net driver update 2/5
  o e1000 net driver update 3/5
  o e1000 net driver update 4/5
  o e1000 net driver update 5/5

Tim Waugh <twaugh@redhat.com>:
  o 2.4.20-pre4: parportbook thinko

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: separate finding and parsing the info from the boot wrapper
  o PPC32: implement hooks for extra PCI fixups needed on some platforms
  o PPC32: Add hooks for Abatron BDI2000 debugger, extra compile flags


