Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVCBIBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVCBIBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVCBIBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:01:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:10400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbVCBIAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:00:44 -0500
Date: Wed, 2 Mar 2005 00:02:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.11
Message-ID: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 there it is. Only small stuff lately  - as promised. Shortlog from -rc5 
appended, nothing exciting there, mostly some fixes from various code 
checkers (like fixed init sections, and some coverity tool finds).

So it's now _officially_ all bug-free.

			Linus

----
Summary of changes from v2.6.11-rc5 to v2.6.11
============================================

<c.lucas:com.rmk.(none)>:
  o [SERIAL] drivers/serial/*: convert to pci_register_driver

<takis:lumumba.luc.ac.be>:
  o prism54 not releasing region

Alex Williamson:
  o [SERIAL] 8250 woraround for buggy uart

Alexander Nyberg:
  o SELinux: Leak in error path
  o SELinux: null dereference in error path

Andrea Arcangeli:
  o Make the new merged pipe writes check for SIGPIPE

Andrew Morton:
  o binfmt_elf build fix
  o [IA64] ia64 audit build fix
  o genhd: NULL checking fix

Andries E. Brouwer:
  o __devinitdata in parport_pc
  o __init in cfq-iosched.c
  o remove __initdata in scsi_devinfo.c
  o __initdata in apic.c
  o more apic.c

Aurelien Jarno:
  o USB: Fix usbfs regression

Bartlomiej Zolnierkiewicz:
  o [ide] fix build for built-in hpt366 and modular ide-disk
  o [ide] fix IRQ masking in ide_do_request()

Ben Dooks:
  o [ARM PATCH] 2498/1: CREDITS - add Ben Dooks
  o [ARM PATCH] 2505/1: Remove FTVPCI from debug code

Bjorn Helgaas:
  o [SERIAL] discover PNP ports before PCI, etc
  o [SERIAL] add TP560 data/fax/modem support

Chris Wright:
  o fix audit inode filter
  o send audit reply to correct socket

David Gibson:
  o ppc64: hugepage hash flushing bugfix

David Howells:
  o Make keyctl(KEYCTL_JOIN_SESSION_KEYRING) use the correct arg

David S. Miller:
  o [IPV4]: Fix lost routes in fn_hash netlink dumps
  o [AF_UNIX]: Fix SIOCINQ for STREAM and SEQPACKET

Dmitry Torokhov:
  o Input: add more PNP IDs to i8042 driver

Greg Kroah-Hartman:
  o sysfs: fix signedness problem
  o fix module paramater permissions in radeon_base.c
  o USB: fix bug in acm's open function

Harald Welte:
  o [NETFILTER]: ipt_hashlimit rule load time race condition

Hideaki Yoshifuji:
  o add sysctl helper functions to provide milliseconds-based
    interfaces
  o [IPV4] Use appropriate sysctl helpers for gc_min_interval_ms
  o [IPV6]: Unregister per-device snmp6 proc entry earlier

Jens Axboe:
  o [PATCH] Fix bounced bio and dm panic

Kenji Kaneshige:
  o [IA64] pci_irq.c: need signed variable to handle error return from
    acpi

Linus Torvalds:
  o Fix possible pty line discipline race
  o Properly limit keyboard keycodes to KEY_MAX
  o Make pipe "poll()" take direction of pipe into account
  o Linux 2.6.11

Nishanth Aravamudan:
  o [PKTGEN]: Replace interruptible_sleep_on_timeout()

Olaf Hering:
  o Fix incorrect __init on 'modedb[]' array

Patrick McHardy:
  o [NETFILTER]: Prevent NAT from seeing fragments

Randy Dunlap:
  o [ide] make 1-bit fields unsigned
  o srat: initdata section references
  o sound/oss/aedsp16: init/exit section cleanups
  o sonicvibes: fix initdata references
  o sound/oss/opl3as2: fix init section reference
  o isdn: use __init for ICCVersion()
  o dc395x: fix section references
  o hp100: fix section references
  o rrunner: fix section references

Robert Olsson:
  o [PKTGEN]: reduce stack usage

Russell King:
  o [ARM] Fix dma_mmap() size argument

Sascha Hauer:
  o [ARM PATCH] 2496/1: i.MX DMA fix
  o [ARM PATCH] 2497/1: i.MX pll decode

