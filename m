Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUGEPD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUGEPD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGEPDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:03:52 -0400
Received: from yoda.ing.unibs.it ([192.167.22.24]:907 "EHLO localhost")
	by vger.kernel.org with ESMTP id S266140AbUGEO7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:59:50 -0400
Date: Mon, 5 Jul 2004 17:00:32 +0200
From: marco ghidinelli <marcogh@linux.it>
To: linux-kernel@vger.kernel.org
Subject: irq mess on a via kt400 notebook...
Message-ID: <20040705150032.GA1923@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Subliminal: BillGatesSucks
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a lot of errors in my /proc/interrupts when i enable the ioapic,
even under kernel 2.6 and 2.4:

$ cat /proc/interrupts 
           CPU0       
  0:    3296925          XT-PIC  timer
  1:       8808          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  uhci_hcd
  5:          0          XT-PIC  uhci_hcd, VIA8233
  9:        640          XT-PIC  acpi
 10:          0          XT-PIC  ehci_hcd
 11:     205410          XT-PIC  uhci_hcd, eth0, radeon@PCI:1:0:0
 12:     468682          XT-PIC  i8042
 14:      24512          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0 
LOC:    3295129 
ERR:     368518

---------^^^^^^

MIS:          0

and when i try to access the cdrom under kernel 2.6 sometimes it stops to
work and complains about:

Jul  5 06:33:11 localhost kernel: hdc: cdrom_pc_intr: The drive appears
confused (ireason = 0x01)

i posteb a bugreport on this about 1 month ago, but nobody seems to
care.

i attach fresh dmesg from a recent 2.6 kernel.

http://bugzilla.kernel.org/show_bug.cgi?id=2811

i even try a lot of options (nolapic, noapic, noacpi) but without the
right clue to understand what's happens.

