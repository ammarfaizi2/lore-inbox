Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266322AbUFZRHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUFZRHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267192AbUFZRHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:07:55 -0400
Received: from smtp811.mail.ukl.yahoo.com ([217.12.12.201]:37484 "HELO
	smtp811.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266322AbUFZRHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:07:51 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Assuming someone else called the IRQ
Date: Sat, 26 Jun 2004 18:08:31 +0100
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406261808.31860.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Every kernel in the 2.6 serious so far has exhibited the same problem; after 
some time of running my desktop system, I get:

Assuming someone else called the IRQ

Spamming to the kernel log. Any idea what's causing this or how I can work out 
which driver has the bug? (I suspect yenta_socket, it didn't happen prior to 
me buying a PCI -> PCMCIA cardbus adaptor).

[alistair] 18:04 [~] uname -r
2.6.7

[alistair] 18:06 [~] cat /proc/interrupts
           CPU0
  0:  250894252          XT-PIC  timer
  1:     176607    IO-APIC-edge  i8042
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:     154556    IO-APIC-edge  ide0
 15:    1427469    IO-APIC-edge  ide1
 16:          4   IO-APIC-level  bttv0
 17:    1050146   IO-APIC-level  ide2, ide3
 18:    1397064   IO-APIC-level  EMU10K1
 19:    8748235   IO-APIC-level  ohci1394, yenta, eth0
 20:          2   IO-APIC-level  ehci_hcd
 21:          3   IO-APIC-level  ohci_hcd, ohci1394
 22:    1218068   IO-APIC-level  ohci_hcd
NMI:          0
LOC:  250913490
ERR:          1
MIS:       3996

Although I have an nvidia video card in the system, the module was not loaded 
and X was not started, so I find it unlikely that this could be to blame. The 
video card would share IRQ 19 as well, if the driver was loaded.

[alistair] 18:06 [~] uptime
 18:07:35 up 2 days, 21:41,  2 users,  load average: 0.13, 0.35, 0.26

Any suggestions would be very helpful.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
