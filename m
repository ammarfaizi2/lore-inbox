Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVE1S71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVE1S71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 14:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVE1S70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 14:59:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:19421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261177AbVE1S7T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 14:59:19 -0400
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: usb/acpi related: irq 11: nobody cared!
Date: Sat, 28 May 2005 21:02:16 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505282102.16858.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.6.X we need to give pci=noacpi for some mainboards (gigabyte 7DXE) to 
get usb working. With 2.4.2X this was no issue with those boards. Any ideas?

Here's an oops without pci=noacpi (2.6.11-ck9 + Win4Lin + bluesmoke patches, 
the problem is really also existing with a vanilla kernel)


irq 11: nobody cared!
 [<c0138bb2>] __report_bad_irq+0x22/0x80
 [<c0138c80>] note_interrupt+0x50/0x80
 [<c013878b>] __do_IRQ+0x11b/0x120
 [<c03a3780>] ip_rcv_finish+0x0/0x2a0
 [<c01056da>] do_IRQ+0x1a/0x30
 [<c0103f8a>] common_interrupt+0x1a/0x20
 [<c03a3780>] ip_rcv_finish+0x0/0x2a0
 [<c03993ea>] nf_hook_slow+0x2a/0x100
 [<c03a34a5>] ip_rcv+0x435/0x500
 [<c03a3780>] ip_rcv_finish+0x0/0x2a0
 [<c038fccb>] netif_receive_skb+0x14b/0x210
 [<c038fe12>] process_backlog+0x82/0x130
 [<c038ff37>] net_rx_action+0x77/0x110
 [<c0123dd6>] __do_softirq+0x126/0x160
 [<c0123e65>] do_softirq+0x55/0x70
 [<c0123fa8>] irq_exit+0x68/0x80
 [<c01056df>] do_IRQ+0x1f/0x30
 [<c0103f8a>] common_interrupt+0x1a/0x20
 [<c0101030>] default_idle+0x0/0x30
 [<c0101054>] default_idle+0x24/0x30
 [<c01010ed>] cpu_idle+0x4d/0x60
 [<c0556881>] start_kernel+0x181/0x1c0
handlers:
[<c035ff70>] (usb_hcd_irq+0x0/0x60)
[<c035ff70>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #11

           CPU0
  0:     486512    IO-APIC-edge  timer
  1:         13    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 10:          0   IO-APIC-level  VIA686A
 11:     100000   IO-APIC-level  uhci_hcd, uhci_hcd
 12:        102    IO-APIC-edge  i8042
 14:        610    IO-APIC-edge  ide0
 15:         26    IO-APIC-edge  ide1
 16:      33105   IO-APIC-level  r128@PCI:1:5:0
 19:     193715   IO-APIC-level  eth0
NMI:          0
LOC:     486129
ERR:          0
MIS:          0

Please tell me, if I can do more about it or if you need more information.

Thanks,
	Bernd


-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
