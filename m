Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVJZSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVJZSef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVJZSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:34:34 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:64809 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S964854AbVJZSee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:34:34 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: sata_nv + SMP = broken?
Date: Wed, 26 Oct 2005 11:34:25 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B004FAE5D8@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_nv + SMP = broken?
Thread-Index: AcXZyVwmGEDFoH3yQ+yU1gP88rMxMAAkQdsA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Vladimir Lazarenko" <vlad@lazarenko.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-kernel@vger.kernel.org>,
       "Marc Perkel" <marc@perkel.com>, "Jeff Garzik" <jgarzik@pobox.com>
X-OriginalArrivalTime: 26 Oct 2005 18:34:26.0751 (UTC) FILETIME=[E4EC7CF0:01C5DA5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yet again, if i enable apic, the boot process hangs here:
> sata_nv version 0.6
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 11
> ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 11
> 
> These are the last messages that I get. The same behaviour on both 
> motherboard. Shoudl I enable apic, it hangs on that.
> 
> When I disable apic, the boot sequence looks like:
> 
> sata_nv version 0.6
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 11
> ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 11
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 
> 86:3e01 87:4003 
> 88:407f
> ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed

Can you send the output of "cat /proc/interrupts" and a "lspci -xxx" ? 

Also you may want to disable hotplug from the device table in sata_nv.c
for now in case this has something to do with hotplug interrupts.
