Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSESWC6>; Sun, 19 May 2002 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSESWC6>; Sun, 19 May 2002 18:02:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54278
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315279AbSESWC5>; Sun, 19 May 2002 18:02:57 -0400
Date: Sun, 19 May 2002 15:01:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware, IDE or ext3 problem?
In-Reply-To: <Pine.GSO.4.10.10205182031540.14231-100000@tigre.dcc.unicamp.br>
Message-ID: <Pine.LNX.4.10.10205182044290.8582-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulisses,

I guess I need to put in a special monster printk to explain the error
events.  You drive, hardware, and data are secure because of a feature I
created, but chose not to patent (nice guy erm sucker et al.).  However
you do have issues that cause the driver to invoke the transfer rate
reduction feature set.  You can simply try put the drive back in the
faster mode and if it likes it fine, otherwise it will down grade again to
stablize throughput.

The choice is to have it continue with multiple retries w/ the higher
transfer rate, or reduce the io rate but have success on a consistant
bases.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

On Sat, 18 May 2002, ULISSES FURQUIM FREIRE DA SILVA wrote:

> 
> Hi,
> 
> 	I installed Red Hat 7.3 and the 2.4.18-3 kernel shows some IDE
> errors on boot like:
> 
> VFS: Mounted root (ext2 filesystem).
> Journalled Block Device driver loaded
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> 
> 	I also tried the 2.4.18-4 kernel, but the errors continue. It's
> weird cause this happen only on boot and in spite of it the system runs
> fine.
> 	I have a SiS 5513 chipset with a QUANTUM FIREBALLlct15 20 IDE
> drive.
> 	I'm not sure if I have a true hardware problem or if there is a
> bug in the kernel. Any ideas?
> 	(please CC the answers to me)
> 
> Thanks,
> 
> -- Ulisses
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


