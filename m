Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSJOXmV>; Tue, 15 Oct 2002 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264896AbSJOXmV>; Tue, 15 Oct 2002 19:42:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46726 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S264891AbSJOXmP>; Tue, 15 Oct 2002 19:42:15 -0400
Date: Tue, 15 Oct 2002 21:10:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre11
Message-ID: <Pine.LNX.4.44L.0210152109360.31342-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre11 with a lot of misc fixes.

Users which had problems with pdcraid on 2.4.19, please try this one and
report results.


Summary of changes from v2.4.20-pre10 to v2.4.20-pre11
============================================

<barryn@pobox.com>:
  o 2.4.20-pre10: make PL-2303 hack work again

<cel@citi.umich.edu>:
  o allow nfsroot to mount via TCP

<dhinds@sonic.net>:
  o Fixup PCMCIA thinko introduced by kmalloc failure handling patches

<eyal@eyal.emu.id.au>:
  o Fix brlvger driver compilation problem

<fubar@us.ibm.com>:
  o Prevent EFAULT errors when checking link status, in bonding net driver

<jeb.j.cramer@intel.com>:
  o e1000 net driver minor fixes/cleanups

<johnstul@us.ibm.com>:
  o Cleanup clustered APIC code to allow others to use it

<marcelo@freak.distro.conectiva>:
  o Do not state that 2.4 is under active development on "SubmittingDrivers" documentation file
  o Fix misuse of types in brlvger
  o Do not skip Promise ataraid's: they used to work fine with pdcraid
  o Changed EXTRAVERSION to pre11
  o Add PCI ID for SiS 646
  o Undo DMI updates. Its 2.4.21-pre stuff

<mkp@mkp.net>:
  o forte sound driver updates

<paul.mundt@timesys.com>:
  o SH5 support for shwdt

<rth@are.twiddle.net>:
  o Fix missed variable rename in stxncpy glibc conversion
  o Sync stxncpy with 2.5 changes

<shaggy@shaggy.austin.ibm.com>:
  o JFS: return code from sb_bread was incorrectly checked

<thockin@freakshow.cobalt.com>:
  o drivers/net/natsemi.c: sync with 2.5.x
  o drivers/net/natsemi.c: add dp83816 support
  o drivers/net/natsemi.c: janitorial - whitespace, wrap, and indenting cleanup
  o drivers/net/natsemi.c: stop tx/rx and reinit_ring on a PHY reset
  o drivers/net/natsemi.c: cleanup version string, fix compile error
  o drivers/net/natsemi.c: boost some printk() levels to WARN
  o drivers/net/natsemi.c: fix compile error - s/KERN_WARN/KERN_WARNING/

<wg@malloc.de>:
  o usbfs race while mounting/umounting

<zubarev@us.ibm.com>:
  o IBM PCI Hotplug: small patch

<zwane@linuxpower.ca>:
  o Add ethtool media selection to 3c509 net driver
  o Add ethtool media support to smc91c92_cs net driver

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entry for CONFIG_USB_MIDI
  o update address of the emu10k1-devel list

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o better code for C3
  o small parisc bits
  o Update LNZ credits entry
  o update kernel params docs
  o update submitting drivers
  o 2.5 backport for sleep with lock
  o watchdog updates
  o SIS 646 AGP
  o native power management for AMD 76x
  o dont set leds until keyboard tasklet is running
  o fix out of memory oops in sis_ds
  o another watchdog fix
  o add ali5451 joystick to config doc
  o fix missingchecks in hotplug
  o handle hisax init failure right
  o fix types in mac apm emu
  o fix broken comment, gcc 3.1 warning in video
  o atalk bits are ISA
  o gcc warning fixes for ethernet
  o fix ugly irda hack
  o ibm token ring updates
  o fix warning in cycx_x25
  o fixup Geode slave disconnect
  o 82092 missing license tag
  o fix oops with AHA2840 card
  o dont register missing gameports
  o fix maestro3 bug that broken m3 in earlier pre
  o more USB size fixes
  o update intermezzo
  o update ver_linux
  o update the SiS framebuffer

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Handle passive resets correctly in SYN-RECV

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o hid-input: fix find_next_zero_bit usage

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: MESH driver SMP fix

dan.zink@hp.com <Dan.Zink@hp.com>:
  o Compaq PCI Hotplug bug fix
  o Compaq PCI Hotplug bug fix 2

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: change name of get_index() to read_index()

David S. Miller <davem@redhat.com>:
  o Fix 2.4.19 mm performance regression due to P4 TLB fix

David Woodhouse <dwmw2@infradead.org>:
  o Deal with VFS calling clear_inode() and read_inode() simultaneously for the same inode

Greg Kroah-Hartman <greg@kroah.com>:
  o IBM PCI Hotplug driver: typo fix for previous patch
  o USB: fix ctsrts handling in pl2303 driver

Harald Welte <laforge@gnumonks.org>:
  o net/ipv6/netfilter/ip6t_LOG.c: Display ipv4 encapsulation properly
  o net/ipv4/netfilter/ip_conntrack_core.c: Fix ip_conntrack_change_expect locking
  o [NETFILTER]: Avoid nesting readlocks in conntrack code
  o net/ipv4/netfilter/ipt_unclean.c: Source port is allowed to be zero

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o [netdrvr] Use ADVERTISE_FULL in mii lib, to clean up duplex check
  o Merge ewrk3 net driver updates from 2.5.x

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: fix "IP frame delayed" bug
  o ISDN: Update md5sums.asc

Manfred Spraul <manfred@colorfullife.com>:
  o drivers/net/natsemi.c:  create a function for rx refill
  o drivers/net/natsemi.c: combine drain_ring and init_ring
  o drivers/net/natsemi.c: OOM handling
  o drivers/net/natsemi.c: stop abusing netdev_device_{de,a}ttach
  o drivers/net/natsemi.c: write MAC address back to the chip
  o drivers/net/natsemi.c: lengthen EEPROM timeout, and always warn about all timeouts
  o drivers/net/natsemi.c: comments update

Paul Mackerras <paulus@samba.org>:
  o missed drivers/macintosh bits
  o add hypervisor console for ppc64
  o ppc update for Configure.help
  o add Documentation/powerpc/cpu_features.txt

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Missing ncpfs bigendianness fix


