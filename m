Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVGKV0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVGKV0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKVYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:24:17 -0400
Received: from totor.bouissou.net ([82.67.27.165]:36743 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262719AbVGKVWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:22:06 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 23:21:53 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507111611470.6399-100000@iolanthe.rowland.org> <200507112246.48069@totor.bouissou.net> <200507112258.53906@totor.bouissou.net>
In-Reply-To: <200507112258.53906@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112321.53413@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 22:58, Michel Bouissou a écrit :
>
> Oh no :-(

Well, I give up for tonight :-(

This time I rebooted with the mouse disabled in BIOS, with the usb-handoff 
option, with the scanner unplugged... And it went wrong simply by itself. 
"irq 21: nobody cared!"

The only thing I'm sure about is that there is something either with UP 
IO-APIC support, or with the uhci_hcd module.

When both are combined, as you can see, this is completely unstable. One time 
it works, one time it doesn't.
But if I use a kernel compiled without UP IO-APIC, or if I boot an 
IO-APIC-capable kernel with the "noapic" option, then the problem is gone, 
and it is stable (really, this time).

But of course, I don't have no IO-APIC anymore...

[root@totor etc]# cat /proc/interrupts
           CPU0
  0:     423482          XT-PIC  timer
  1:       1083          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:       1106          XT-PIC  serial
  7:       1543          XT-PIC  parport0
 10:       3527          XT-PIC  uhci_hcd:usb3, eth0, eth1, VIA8233
 11:      24934          XT-PIC  ide0, ide1, ide2, ide3, uhci_hcd:usb2, 
ehci_hcd:usb4
 12:      13809          XT-PIC  uhci_hcd:usb1, nvidia
 14:       3245          XT-PIC  ide4
 15:       3254          XT-PIC  ide5
NMI:          0
LOC:     423403
ERR:        270

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
