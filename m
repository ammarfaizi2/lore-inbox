Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTE2Or1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTE2Or0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:47:26 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:62181 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S262273AbTE2OrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:47:02 -0400
Date: Thu, 29 May 2003 11:00:18 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
In-Reply-To: <1054216464.20725.70.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305291059030.11675-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow. I feel dumb. When I add the -X66 to tell the drive as well, then 
everything is peachy. Thanks! :)
Now I suppose I just have to figure out how to make that work on boot 
(perhaps just to make the BIOS put them in DMA mode)
	-Josiah



On 29 May 2003, Alan Cox wrote:

On Iau, 2003-05-29 at 15:32, Wm. Josiah Erikson wrote:
> hard drives that I'm trying to get to work with linux 2.4.21-rc6. The 
> problem I'm having is that it's REALLY slow and crashy. The kernel reports 
> this on bootup:

I'm running the siimage driver fine with several drives. Your setup is
intriguing in that the BIOS has chosen to leave the drives in PIO mode

> SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
> SiI3112 Serial ATA: chipset revision 2
> SiI3112 Serial ATA: not 100% native mode: will probe irqs later
>     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
>     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

Really the SATA drives ought to have come up in UDMA

> everything else on my system to a temporary halt, and hdparm -t reports 
> about 1.3MB/sec reads. This is a bummer, as I was hoping to RAID 0 them 
> together and make them my boot drives :)
> 
> If I try and enable DMA, the machine instantly hardlocks.

Thats with hdparm -X66 -d1 ?

The only updates to the siimage driver are those in 2.4.21-ac which you 
shouldn't need.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

