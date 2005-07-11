Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVGKV2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVGKV2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKV0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:26:11 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:55300 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S262746AbVGKVZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:25:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 16:25:43 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4A@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWGXqZSC3sNqcuFQgGUiV/g5izlJQAAAzCA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2005 21:25:40.0157 (UTC) FILETIME=[162696D0:01C5865F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Le Lundi 11 Juillet 2005 22:58, Michel Bouissou a écrit :
> >
> > Oh no :-(
> 
> Well, I give up for tonight :-(
> 
> This time I rebooted with the mouse disabled in BIOS, with 
> the usb-handoff option, with the scanner unplugged... And it 
> went wrong simply by itself. 
> "irq 21: nobody cared!"
> 
> The only thing I'm sure about is that there is something 
> either with UP IO-APIC support, or with the uhci_hcd module.
> 
> When both are combined, as you can see, this is completely 
> unstable. One time it works, one time it doesn't.
> But if I use a kernel compiled without UP IO-APIC, or if I 
> boot an IO-APIC-capable kernel with the "noapic" option, then 
> the problem is gone, and it is stable (really, this time).
> 
> But of course, I don't have no IO-APIC anymore...
> 
> [root@totor etc]# cat /proc/interrupts
>            CPU0
>   0:     423482          XT-PIC  timer
>   1:       1083          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   4:       1106          XT-PIC  serial
>   7:       1543          XT-PIC  parport0
>  10:       3527          XT-PIC  uhci_hcd:usb3, eth0, eth1, VIA8233
>  11:      24934          XT-PIC  ide0, ide1, ide2, ide3, 
> uhci_hcd:usb2, 
> ehci_hcd:usb4
>  12:      13809          XT-PIC  uhci_hcd:usb1, nvidia
>  14:       3245          XT-PIC  ide4
>  15:       3254          XT-PIC  ide5
> NMI:          0
> LOC:     423403
> ERR:        270
> 
> Cheers.

Michel,
When you get chance, maybe you could boot the OS that used to work for you (you mentioned 2.4) and provide the boot trace and /proc/interrupts for comparison.
Thanks,
--Natalie
