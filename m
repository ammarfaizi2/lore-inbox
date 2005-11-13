Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVKMAMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVKMAMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 19:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVKMAMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 19:12:46 -0500
Received: from 80-218-116-26.dclient.hispeed.ch ([80.218.116.26]:61062 "EHLO
	magnific.ch") by vger.kernel.org with ESMTP id S964891AbVKMAMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 19:12:45 -0500
Subject: Via VT6240 Sata problem
From: Yves Kurz <yves@magnific.ch>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 13 Nov 2005 01:12:29 +0100
Message-Id: <1131840749.14747.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux users and developers

I've got a new PC (Asus Pundit p2-ae2) with an Via VT6420 SATA
controller that is connected to a Maxtor 6L200MO hard disk. The problem
is, that no distribution is able to see the disk. I was trying Ubuntu
(hoary/breezy i386 and amd64), Suse 10 eval i386, the Debian Etch Beta 1
installer and I've got always time the same result. 

Part of the log from the boot process (Ubuntu Breezy Amd64)
...
SCSI subsystem initialized
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:0f.0 from 10 to 4
sata_via(0000:00:0f.0): SATA master/slave not supported (0xa2)
ACPI: PCI interrupt for device 0000:00:0f.0 disabled
sata_via: probe of 0000:00:0f.0 failed with error -5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
...

I tried several kernel parameters like pci=noacpi acpi=off noacpi...
etc. but that did not change anything. The bios also doesn't provide a
compatibility mode switch for the sata controller.

So I had a look at the sources of sata_via.c to see what this SATA
master/slave means. Well it's not clear to me from the source why I get
the not supported message. There is just one device attached which I
can't configure in any way. 
What can I do to make Linux find my harddisk? Am I doing something
wrong?

Thanks 

Yves


BTW: Could you please CC me? I'm not subscribed to the list.




