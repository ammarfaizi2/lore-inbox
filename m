Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTFBSfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTFBSfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:35:38 -0400
Received: from main.gmane.org ([80.91.224.249]:25554 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264835AbTFBSfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:35:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: RocketRaid Serial ATA support (HPT374)
Date: 02 Jun 2003 20:48:57 +0200
Message-ID: <yw1x8yske2na.fsf@zaphod.guide>
References: <Pine.LNX.4.44.0306021014210.31232-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Swallow <sean@swallow.org> writes:

> I recently bought a Highpoint RocketRaid 1540. I thoght that it should

So did I.

> work in Linux since it used the HPT374 chipset. I have been unable to get
> get it working with the driver in the kernel (kernel 2.4.20, 2.4.21-rc2,
> 2.4.21-rc6 and 2.5.70) or the driver from HighPoint's site.

It's working wonderfully for me with 2.4.21-pre5 on Alpha.

> I will be happy to provide any other information I can.
> 
> I have a RocketRaid 1540 connected to 4 60gb ata100 IBM drives 
> (Model=IC35L060AVVA07-0) on a Tyan 2466N.
> 
> Upon boot, the first thing I notice is that the first 2 channels are
> recognized as ata100 and the second 2 are only ata33.
> 
> HPT374: IDE controller at PCI slot 02:05.0
> HPT374: chipset revision 7
> HPT374: not 100% native mode: will probe irqs later
> HPT37X: using 33MHz PCI clock
>     ide2: BM-DMA at 0x3000-0x3007, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x3008-0x300f, BIOS settings: hdg:pio, hdh:pio
> HPT37X: using 33MHz PCI clock
>     ide4: BM-DMA at 0x3400-0x3407, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0x3408-0x340f, BIOS settings: hdk:pio, hdl:pio
> hde: IC35L060AVVA07-0, ATA DISK drive
> ide2 at 0x3890-0x3897,0x3886 on irq 17
> hdg: IC35L060AVVA07-0, ATA DISK drive
> ide3 at 0x3888-0x388f,0x3882 on irq 17
> hdi: IC35L060AVVA07-0, ATA DISK drive
> ide4 at 0x38a8-0x38af,0x389e on irq 17
> hdk: IC35L060AVVA07-0, ATA DISK drive
> ide5 at 0x38a0-0x38a7,0x389a on irq 17
> hde: max request size: 128KiB
> hde: host protected area => 1
> hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
> UDMA(100)
>  hde: hde1 hde2 hde3
> hdg: max request size: 128KiB
> hdg: host protected area => 1
> hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
> UDMA(100)
>  hdg: hdg1 hdg2

Looks good so far.

> hdi: max request size: 128KiB
> hdi: host protected area => 1
> hdi: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
> UDMA(33)
>  hdi: hdi1 hdi2
> hdk: max request size: 128KiB
> hdk: host protected area => 1
> hdk: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
> UDMA(33)
>  hdk: hdk1 hdk2
> 
> Then the second 2 start complaining...
> 
> hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdi: drive not ready for command
> hdk: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdk: drive not ready for command
> 
> And, if I try to mount them, more fun ensues...

Make sure all the drives are configured as master.  Also, < ATA-100
drives will not work with the RocketHead adapters, but I gather this
is not your case.

-- 
Måns Rullgård
mru@users.sf.net

