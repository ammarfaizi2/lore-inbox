Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263535AbTC3Kmw>; Sun, 30 Mar 2003 05:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbTC3Kmw>; Sun, 30 Mar 2003 05:42:52 -0500
Received: from mmp11.dna044.com ([217.78.194.33]:141 "EHLO
	mgmtmmp11.dnafinland.fi") by vger.kernel.org with ESMTP
	id <S263535AbTC3Kmv>; Sun, 30 Mar 2003 05:42:51 -0500
Date: Sun, 30 Mar 2003 13:53:52 +0300
From: Thomas Backlund <tmb@iki.fi>
Subject: Re: 3c59x gives HWaddr FF:FF:...
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Juan Quintela <quintela@mandrakesoft.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, LKML <linux-kernel@vger.kernel.org>
Message-id: <021301c2f6aa$ae726140$9b1810ac@xpgf4>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <20030328145159.GA4265@werewolf.able.es>
 <20030328124832.44243f83.akpm@digeo.com>
 <20030328230510.GA5124@werewolf.able.es>
 <20030328151624.67a3c8c5.akpm@digeo.com>
 <20030329004630.GA2480@werewolf.able.es>
 <0d0001c2f616$6a678dc0$9b1810ac@xpgf4> <86y92xh9wt.fsf@trasno.mitica>
 <1049019577.597.6.camel@teapot>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: "Juan Quintela" <quintela@mandrakesoft.com>
Cc: "Thomas Backlund" <tmb@iki.fi>; "J.A. Magallon" <jamagallon@able.es>;
"LKML" <linux-kernel@vger.kernel.org>
Sent: Sunday, March 30, 2003 1:19 PM
Subject: Re: 3c59x gives HWaddr FF:FF:...


| On Sun, 2003-03-30 at 04:21, Juan Quintela wrote:
| > In my experience, that bug is related with acpi.  In a kernel compiled
| > without acpi, the card works perfectly, in a kernel compiled with acpi
| > it depend on the phase of the moon and similar things :(
|
| I'm not using ACPI but APM and, on a vanilla 2.4.20 kernel, that's what
| I'm seeing with my 3CCFE575CT on my kernel dmesg ring:
|
| <snip>
| Yenta IRQ list 08d8, PCI irq5
| Socket status: 30000020
| Yenta IRQ list 08d8, PCI irq10
| Socket status: 30000006
| cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5257
| PCI: Failed to allocate resource 0(1000-2c3) for 06:00.0
| PCI: Enabling device 06:00.0 (0000 -> 0003)
| <snip>
| eth0: command 0x5800 did not complete! Status=0xffff
| eth0: command 0x2804 did not complete! Status=0xffff
| <snip>
|
| However, Alan Cox patches for 2.4.20 and Red Hat's linux kernel both
| seem to work OK... I think it's related to PCI resource assignment.
|

Have you tried with pci=noapic?
When I used the 3c59x on my integrated 3Com (on Asus nForce2 board), it
always got to the point that it got the IP, but no traffic was going
through...
(same thing happends with the 3Com 3c90x driver...)
This was solved by either booting with acpi=off or pci=noapic...

Thomas


