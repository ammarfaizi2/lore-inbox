Return-Path: <linux-kernel-owner+w=401wt.eu-S932541AbWLSArI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWLSArI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWLSArI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:47:08 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:47332 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbWLSArH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:47:07 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 19:47:07 EST
Message-ID: <45873543.8090807@comcast.net>
Date: Mon, 18 Dec 2006 19:41:39 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata and sata?
References: <457ED87A.5@comcast.net> <20061212173739.1304194f@localhost.localdomain>
In-Reply-To: <20061212173739.1304194f@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan wrote:
>> I no longer have two kernels to test through; I can't tell if the speed
>> is back or not.  Nothing in dmesg tells me if SATA is using DMA or
>> 32-bit IO support though, so I don't know... lack of knowledge over here
>> is killing me for troubleshooting this on my own.
> 
> The dmesg message shows the mode selected. It should be the highest speed
> but in one or two cases it selects UDMA33 only. I've fixed one of those
> caused by us relying on a bit not defined in older controllers. We've
> still got a case in the newer chips where BIOS setup doesn't set the
> flags properly. Old IDE has a hackish workaround for that and I'll
> probably end up porting it over.
> 
> 

It seems the highest speed here is UDMA/133.  That should be right...

I've let this go for now; except someone just brought up that copying
from one SATA drive to another slows Ubuntu to a crawl (which is what
I'm using, hence my dmesg should be relevant).  On my end I'm not
noticing; VLC used to hang the system horribly while trying to read like
20M videos (hard disk light on the whole time), now it behaves.


[   25.411977] sata_via 0000:00:0f.0: version 2.0
[   25.411992] ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI
20 (level, low) -> IRQ 18
[   25.412004] sata_via 0000:00:0f.0: routed to hard irq line 11
[   25.412057] ata3: SATA max UDMA/133 cmd 0x9400 ctl 0x9802 bmdma
0xA400 irq 18
[   25.412363] ata4: SATA max UDMA/133 cmd 0x9C00 ctl 0xA002 bmdma
0xA408 irq 18
[   25.412380] scsi2 : sata_via
[   25.415286] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[   25.598514] ieee1394: Host added: ID:BUS[0-00:1023]
GUID[0000000000000000]
[   25.613389] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   25.738290] usb 2-1: device not accepting address 2, error -71
[   25.764951] ata3.00: ATA-7, max UDMA/133, 240121728 sectors: LBA
[   25.764954] ata3.00: ata3: dev 0 multi count 16
[   25.765730] ata3.00: configured for UDMA/133
[   25.765741] scsi3 : sata_via
[   25.967113] ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
[   25.977712] ATA: abnormal status 0x7F on port 0x9C07
[   25.977852] scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6Y120M0
 YAR5 PQ: 0 ANSI: 5

-- 
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
