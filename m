Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTE2Ojm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTE2Ojm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:39:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7126
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262269AbTE2Ojl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:39:41 -0400
Subject: Re: siimage driver status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu>
References: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054216464.20725.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 May 2003 14:54:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

