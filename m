Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131989AbQK2Sym>; Wed, 29 Nov 2000 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132008AbQK2Syc>; Wed, 29 Nov 2000 13:54:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:31236
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S131989AbQK2SyP>; Wed, 29 Nov 2000 13:54:15 -0500
Date: Wed, 29 Nov 2000 10:23:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: --Damacus Porteng-- <kernel@bastion.yi.org>
cc: LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
In-Reply-To: <20001129130616.A4879@bastion.sprileet.net>
Message-ID: <Pine.LNX.4.10.10011291006410.1743-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nope,

I have yet to enable ATAPI-DMA because of the nature of the hooks.

On Wed, 29 Nov 2000, --Damacus Porteng-- wrote:

> LK Prodigies:
> 
> This problem is current on the Linux-2.4.0-test11 kernel.  Please tell me if
> this has already been resolved - I am new to the list.
> 
> Here is my setup:
> 	Motherboard: Soyo 6BA+IV (built-in PIIX4 and HPT366 IDE controllers)
> 	CDRWs: Yamaha 4416S (SCSI) & Yamaha 8424E (EIDE)
> 	
> 	Kernel: 2.4.0test11 -- I must use 2.3.X or 2.4.X since my main drives
> 	are on the HPT366 channels.
> 	
> 	IDE: Using both HPT and PIIX chipsets.  Base system drives are on
> 	HPT366 channels.  / == /dev/hde.  Works fine.
> 
> 	Software: cdrecord 1.8.1, cdrecord 1.9
> 
> Problem:
> 	The problem lies with using my EIDE CDRW - I set it up properly using
> 	IDE-SCSI.  I can use my mp3tocdda shell script to encode mp3s to CD
> 	(uses cdrecord as well) on the fly using either drive, however, when I
> 	use cdrecord to write a data CD, the system hard-locks, no kernel
> 	panic messages, and no Magic SysRQ keystroke works.  
> 
> 	Quite odd that I could do the cdrecord for audio tracks, but not
> 	data..
> 
> 	Anyhow, I moved the CDRW to the PIIX4 channels (and changed my lilo
> 	append line to make hda=scsi, instead of hdg=scsi) and now both the
> 	mp3tocdda script and cdrecord for data images works fine.  
> 
> 	I'm thinking it's a problem with HPT366, since IDE-SCSI/PIIX4 worked
> 	fine with the setup, and cdrecord has always been a working package
> 	for me.
> 
> 	Also, the HPT366 setup screen (VERY simple) shows the CDRW using MW
> 	DMA 2 and is unchangable thru the HPT366 BIOS.  Is there something
> 	I should be doing with hdparm on the CD device?
> 
> 
> Thanks in advance,
> 
> Damacus Porteng
> 
> --
> Damnit, Linus, I'm a network admin, not a kernel hacker!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
