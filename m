Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTJVXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJVXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:38:27 -0400
Received: from intra.cyclades.com ([64.186.161.6]:47498 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261326AbTJVXiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:38:16 -0400
Date: Wed, 22 Oct 2003 21:24:17 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre8
Message-ID: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -pre8... It contains a quite big amount of ACPI fixes,
networking changes, network driver changes, few IDE fixes, SPARC merge, SH
merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.

People seeing boot IDE related crashes on Alpha with previous kernels
please try this.

Have fun


Summary of changes from v2.4.23-pre7 to v2.4.23-pre8
============================================

<daniel:deadlock.et.tudelft.nl>:
  o atyfb ibook fix

<gorgo:thunderchild.debian.net>:
  o [NET]: Fix get_random_bytes() call in sunhme.c:get_hme_mac_nonsparc()

<ja:ssi.bg>:
  o [IPV4]: ip_fragment must copy the nfcache field

<len.brown:intel.com>:
  o [ACPI] Summary of changes for ACPICA version 20031002
  o [ACPI] fix acpi_asus module build (Stephen Hemminger)
  o [ACPI] delete descriptions for stale ACPI build options
  o [ACPI] speed up reads from /proc/acpi/ (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=726
  o [ACPI] fix object reference count bug for battery status (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1038
  o [ACPI] acpi_ec_gpe_query(ec) fix for T40 crash (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1171
  o [ACPI] correct parameter to acpi_ev_gpe_dispatch() (Shaohua David Li)
  o [ACPI] correct parameter to acpi_ev_gpe_dispatch() take II (Bob Moore)
  o [ACPI] fix !CONFIG_PCI build use X86 ACPI specific version of eisa_set_level_irq() http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI] fix use_acpi_pci !CONFIG_PCI build error per 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=1392
  o [ACPI] Broken fan detection prevents booting (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1185

<lethal:unusual.internal.linux-sh.org>:
  o sh: signal trampoline workaround for SH-4 core bug
  o sh: irq_intc2 updates
  o sh: Add BPS_230400 definition to sh-sci
  o sh64: Add pcibios_scan_all_fns() definition

<marcelo:logos.cnet>:
  o Al Viro: Clear all flags in exec_usermodehelper
  o x86: Clear IRQ_INPROGRESS in setup_irq()
  o MIPS/MIPS64: Clear IRQ_INPROGRESS in setup_irq()
  o Remove parcelfarce email from CREDITS
  o Shantanu Goel: Fix merge mistake in refill_inactive()
  o Changed EXTRAVERSION to -pre8
  o ide-disk.c: Limit disk size to 137GB if LBA48 is not available
  o Jan Niehusmann: Make LBA48 work in pdc202xx_old.c

<mroos:linux.ee>:
  o [SPARC]: Use NR_CPUS for linux_cpus[]

<pp:ee.oulu.fi>:
  o b44 enable interrupts after tx timeout (2.4.23-pre6)

<sheilds:msrl.com>:
  o [SPARC64]: Fix typo in bbc_envctrl.c

<wensong:linux-vs.org>:
  o [IPVS] Fix to set the statistics of dest zero when bound to a new service
  o [IPVS]: Fix ip_vs_ftp to use cp->vaddr because iph->daddr is already mangled

<xose:wanadoo.es>:
  o change sym53c8xx.o to sym53c8xx_2.o in Configure.help

Alexander Viro:
  o Alpha: clear IRQ_INPROGRESS in setup_irq()
  o fix for do_tty_hangup() access of kfreed memory

Bartlomiej Zolnierkiewicz:
  o fix ServerWorks PIO auto-tuning

Chas Williams:
  o [ATM]: rewrite recvmsg to use skb_copy_datagram_iovec
  o [ATM]: remove listenq and backlog_quota from struct atm_vcc
  o [ATM]: cleanup connect
  o [ATM]: eliminate SOCKOPS_WRAPPED
  o [ATM]: move vcc's to global sk-based linked list
  o [ATM]: setsockopt/getsockopt cleanup

David S. Miller:
  o [SPARC64]: Always use sethi+jmpl to reach VISenter{,half}
  o [SPARC64]: Implement force_successful_syscall_return()
  o [NET]: linux/in.h needs linux/socket.h
  o [VLAN]: kfree(skb) --> kfree_skb(skb)
  o [SPARC64]: Update defconfig
  o [SPARC]: Audit inline asm

Eric Brower:
  o [SPARC64]: Fix kernel_thread() return value check in envctrl.c

Hugh Dickins:
  o tmpfs 1/5 LTP ENAMETOOLONG
  o tmpfs 2/5 LTP S_ISGID dir
  o tmpfs 3/5 swapoff/truncate race
  o tmpfs 4/5 getpage/truncate race
  o tmpfs 5/5 writepage/truncate race

Jeff Garzik:
  o [netdrvr xircom_cb] backport 2.6 changes
  o [netdrvr 8139too] add pci id
  o [netdrvr 8139too] another new PCI ID
  o [netdrvr tulip] add pci id

Manfred Spraul:
  o [netdrvr natsemi] fix ring clean

Martin Josefsson:
  o [NETFILTER]: Remove unused destroy callback in ip6t_ipv6header.c, from Maciej Soltysiak

Matt Domsch:
  o Fix megaraid2 compilation problems

Michael Shields:
  o [SPARC64]: Fix watchdog on CP1500/Netra-t1

Mikael Pettersson:
  o APICBASE fix backport from 2.6

Mirko Lindner:
  o sk98lin-2.4: Driver update to version 6.18

Neil Brown:
  o Remove un-necessary locking in lockd

Olaf Hering:
  o [IRDA]: Fix build with gcc-3.4
  o Fix NinjaSCSI compilation

Patrick McHardy:
  o [NETFILTER]: Add size check to ip_nat_mangle_udp_packet

Scott Feldman:
  o ethtool_ops eeprom stuff
  o hang on ZEROCOPY/TSO when hitting no-Tx-resources

Trond Myklebust:
  o Fix a deadlock in the NFS asynchronous write code
  o A request cannot be used as part of the RTO estimation if it gets
    resent since you don't know whether the server is replying to the 
    first or the second transmission. However we're currently setting the 
    cutoff point to be the timeout of the first transmission.
  o UDP round trip timer fix. Modify Karn's algorithm so that we inherit timeouts from previous requests.
  o Increase the minimum RTO timer value to 1/10 second. This is more in line with what is done for TCP.
  o Fix a stack overflow problem that was noticed by Jeff Garzik by removing some unused readdirplus cruft.
  o Make the client act correctly if the RPC server's asserts that it does not support a given program, version or procedure call.



