Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTKSM1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 07:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKSM1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 07:27:24 -0500
Received: from intra.cyclades.com ([64.186.161.6]:44982 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264022AbTKSM1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 07:27:19 -0500
Date: Wed, 19 Nov 2003 10:17:32 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-rc2
Message-ID: <Pine.LNX.4.44.0311191013530.1383-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here it goes -rc2. 

Important netfilter fixes, several ACPI fixes, few driver corrections 
(tulip, tg3, megaraid2), amongst others.

If no problems shows up this should become final in a few days.




Summary of changes from v2.4.23-rc1 to v2.4.23-rc2
============================================

<atul.mukker:lsil.com>:
  o [scsi megaraid2] fix DMA sync to use correct S/G list pointer

<davej:redhat.com>:
  o Correct cmpci fix

<khali:linux-fr.org>:
  o Update I2C maintainers entry

<len.brown:intel.com>:
  o [ACPI] fix CONFIG_HOTPLUG_PCI_ACPI config (Xose Vazquez Perez)
  o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off completely, including table parsing for HT.
  o [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid
  o [ACPI] fix poweroff failure ala 2.6 (Ducrot Bruno) http://bugzilla.kernel.org/show_bug.cgi?id=1456
  o [ACPI] fix ACPI/legacy interrupt sharing issue ala 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=1283
  o [ACPI] print_IO_APIC() only after it is actually programmed http://bugzilla.kernel.org/show_bug.cgi?id=1177
  o [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered SCI http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI ] pci=acpi ineffective fix from i386 2.6 (Thomas Schlichter) http://bugzilla.kernel.org/show_bug.cgi?id=1219
  o [ACPI] Re-enable IRQ balacning if IOAPIC mode http://bugzilla.kernel.org/show_bug.cgi?id=1440
  o [ACPI] fix x86_64 build errors
  o [ACPI] Maintainer: Andy Grover -> Len Brown
  o [ACPI] fix x86_64 !CONFIG_ACPI build
  o 2.4.23 build x86_64 build fixes
  o i386 build fix from previous cset
  o x86_64 build fix from previous cset
  o [ACPI] sync some i386 ACPI build fixes into x86_64 to fix !CONFIG_ACPI build
  o "pci=noacpi" use pci_disable_acpi() instead of touching use_acpi_pci directly

<livio:ime.usp.br>:
  o Backport inode_hash race fix

<marcelo:logos.cnet>:
  o Exclude broken netfilter hunk: laforge@netfilter.org|ChangeSet|20030904111137|30468
  o Cset exclude: xose@wanadoo.es|ChangeSet|20031115132946|56340
  o Changed EXTRAVERSION to -rc2
  o Cset exclude: davej@redhat.com|ChangeSet|20031114154840|57070

<pmeda:akamai.com>:
  o [netdrvr tulip] fix hashed setup frame code

<xose:wanadoo.es>:
  o pci-irq.c bad PCI ident of 440GX host bridge

Adrian Bunk:
  o fixup after synclink update

Andi Kleen:
  o Readd IORR changes to Nvidia k7 driver
  o Remaining x86-64 updates
  o Add memory clobber to ip_fast_csum

Harald Welte:
  o Netfilter: Sane ip_ct_tcp_timeout_close_wait value

Herbert Xu:
  o [netdrvr tg3] fix tqueue initialization



