Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULJLde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULJLde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 06:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbULJLdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 06:33:33 -0500
Received: from i-194-106-33-239.freedom2surf.net ([194.106.33.239]:15294 "EHLO
	webmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261180AbULJLdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 06:33:31 -0500
Message-ID: <1102678410.41b9898a485ad@webmail.freedom2surf.net>
Date: Fri, 10 Dec 2004 11:33:30 +0000
From: bugzilla@emiller.f2s.com
To: linux-kernel@vger.kernel.org
Subject: ACPI and APIC on nforce2 with 2.4 kernel - is there hope?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.3
X-Originating-IP: 81.171.131.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any hope of seeing the acpi_skip_timer_override patch in the 2.4
branch? It has been in the 2.6 branch since around 2.6.5-rcfoo. This patch
addresses a problem specific to nforce2 motherboards that results in an XT-PIC
timer on ACPI and APIC enabled 2.4.x kernels.

I really don't know how much of a Bad Thing (TM) this is but my anxieties are
due to: 1) The fact that I see clock gain of about one minute per week; 2) The
fact that nforce2 has suffered from notorious instability and I just want to
feel comfort that all known problems are going to get ironed out. I acknowledge
that this problem is: 1) a hardware problem; 2) fixed in the latest stable
branch (as of the 2.6.6 release).

If the answer to my question is no, I would appreciate guidance on: 1) whether
this issue could cause me problems (is it likely to result in clock gain; could
it cause general instability or other problems); 2) what people recommend as a
2.4.x kernel configuration for nforce2 motherboards (mine is Abit NF7-S Rev2)
in terms of ACPI, IOAPIC and LAPIC parameters.

To demonstrate, with an ACPI and APIC enabled 2.4.26 Debianised kernel, I see:

cat /proc/interrupts
           CPU0
  0:    1180749          XT-PIC  timer
  1:       1834    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     234451    IO-APIC-edge  PS/2 Mouse
 14:      20449    IO-APIC-edge  ide0
 15:         23    IO-APIC-edge  ide1
 19:          0   IO-APIC-level  mgacore
 20:    1192269   IO-APIC-level  usb-ohci, eth0
 21:        443   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:          3   IO-APIC-level  ohci1394, usb-ohci
NMI:          0
LOC:    1180732
ERR:          0
MIS:          0

N.B. I understand that the separate issue of the non-availability of IRQ2
because of the spurious reservation by cascade has now been patched, as of
2.4.27-pre2 (and 2.6.6).

See also http://bugzilla.kernel.org/show_bug.cgi?id=1203

Please cc me as I am not subscribed to this list.

