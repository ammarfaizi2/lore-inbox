Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTKMTkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTKMTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:40:24 -0500
Received: from mx.stud.uni-hannover.de ([130.75.176.3]:61858 "EHLO
	studserv.stud.uni-hannover.de") by vger.kernel.org with ESMTP
	id S264414AbTKMTkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:40:16 -0500
From: Michael Born <michael.born@stud.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: PCI: device 00:09.0 has unknown header type 04, ignoring.  What's that?
Date: Thu, 13 Nov 2003 20:40:23 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311132040.23582.michael.born@stud.uni-hannover.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers,

I have a problem with a GPIB PCI card from Quancom 
( http://quancom.de/qprod01/eng/pb/pci_gpib.htm ).

I wrote a programm to read data <100kByte/sec from the GPIB bus to the RAM. 
When the PCI card shares it's IRQ it works for some time and then hardlocks 
my computer - the "PCI access LED" of the GPIB card is always ON then.
Now I found a PCI slot where the card doesn't have to share the IRQ - but 
linux ignores the card :-(
While booting the kernel says:
---
<6>PCI: Probing PCI hardware
<4>PCI: ACPI tables contain no PCI IRQ routing entries
<4>PCI: Probing PCI hardware (bus 00)
<3>PCI: device 00:09.0 has unknown header type 04, ignoring.
<6>PCI: Using IRQ router VIA [1106/3074] at 00:11.0
---

The BIOS bootscreen reported an "unknown device - IRQ5". But "lspci" doesn't 
show up the card!!!

What is "unknown header type 04" ?
Why does "lspci" show the card when IRQ is shared?
How can I know what's wrong with this card?

Somebody please enlighten me.
Please CC me your mail - I'm not subscribed to the list.

Greetings
Michael

PS: I already had trouble with this card spontaneously getting unconfigured 
(like before the BIOS talks to the card) in an ECS L7S7A board ...


My system:
Athlon 2000XP
512MB RAM
Epox 8KHA+ (VIA KT266a)

Suse8.2
2.4.22 kernel
3.1.97 linux gpib driver

