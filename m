Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbSAAXfL>; Tue, 1 Jan 2002 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286362AbSAAXfC>; Tue, 1 Jan 2002 18:35:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43017
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286365AbSAAXez>; Tue, 1 Jan 2002 18:34:55 -0500
Date: Tue, 1 Jan 2002 15:32:16 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Brian <hiryuu@envisiongames.net>
cc: Krzysztof Oledzki <ole@ans.pl>, linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net>
Message-ID: <Pine.LNX.4.10.10201011521190.6558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brian,

Well if hell freezes over and I die, the patches to make the driver
handled clean low_level IO threading will never be accepted.  Because they
model the state-diagrams of the physical layer of the hardware exactly in
the transport layer, it is totally orthoginal to the darwinism of Linux.
Design is a problem, it is not permitted in a darwin-evolution model.

It only allows you to access both drives on a channel and only suffer a
10% IO loss max on each, but you gain a smooth IO access to both drives.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Tue, 1 Jan 2002, Brian wrote:

> This is an inherent quirk (SCSI folks would say brain damage) in IDE.
> 
> Only one drive on an IDE chain may be accessed at once and only one 
> request may go to that drive at a time.  Therefore, the maximum you could 
> hope for in that test is half speed on each.  Throw in the overhead of 
> continuously hopping between them and 12MB is no surprise.
> 
> That is why even cheapo Compaqs and Gateways have the hard drive and 
> CD-ROM on separate chains.  It's also why IDE RAID cards have a separate 
> connector for each drive.
> 
> 	-- Brian
> 
> On Tuesday 01 January 2002 05:34 pm, Krzysztof Oledzki wrote:
> > Hello,
> >
> > There is something wrong with ide data throughput with at last both via
> > kt133 and promise pcd20265 controllers.
> >
> > I have Asus A7V-133 Mobo with VIA KT133A chipset and onboard Promise
> > pcd20265 ide controller. My CPU is Athlon 1400 MHz and I have 512 MB of
> > PC133 SDRAM. I noticed that connecting two ata100 hdds into the same
> > channel makes everything much slower. So I made some test:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

