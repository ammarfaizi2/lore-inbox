Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSEYFCr>; Sat, 25 May 2002 01:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEYFCq>; Sat, 25 May 2002 01:02:46 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6926 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313558AbSEYFCo>; Sat, 25 May 2002 01:02:44 -0400
Date: Fri, 24 May 2002 22:00:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8 ide bugs
In-Reply-To: <004101c20334$361b0b80$baefb0d4@nick>
Message-ID: <Pine.LNX.4.10.10205242159110.31297-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Obviously you have not enable taskfile IO, if you have then you have my
attention.  You are running the legacy code which the talented king
pengiun screwed, and now is return back into 2.5.

Cheers,

On Fri, 24 May 2002, Nick Evgeniev wrote:

> Hi,
> 
> I've got the following problem with 2.4.19-pre8 &
> ide-2.4.19-p7.all.convert.10.patch (w/o patch & I've more fatal problems
> with sb & filesystem corruptions) kernel reports "kernel: bug: kernel timer
> added twice at c01a7356." & panics.
> 
> Is it a known issue? What is the solution??? I remember that with 2.4.7 I
> didn't have any ide errors... but it had reiserfs bugs...
> Are there light at the end of ide nightmare?
> 
> Here is log:
> >-------------------------------
> May 24 12:19:48 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
> May 24 12:19:48 vzhik kernel:
> May 24 12:19:48 vzhik kernel: hdg: status timeout: status=0xd0 { Busy }
> May 24 12:19:48 vzhik kernel:
> May 24 12:19:49 vzhik kernel: hdg: DMA disabled
> May 24 12:19:49 vzhik kernel: ide3: reset: success
> May 24 12:19:49 vzhik kernel: PDC202XX: Secondary channel reset.
> May 24 12:19:49 vzhik kernel: hdg: drive not ready for command
> May 24 12:19:50 vzhik kernel: hde: timeout waiting for DMA
> May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
> May 24 12:19:50 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
> func only: 16
> May 24 12:19:50 vzhik kernel: hde: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> May 24 12:19:50 vzhik kernel: hde: dma_intr: error=0x84 { DriveStatusError
> BadCRC }
> May 24 12:19:50 vzhik kernel: hde: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> May 24 12:19:50 vzhik kernel: hde: dma_intr: error=0x84 { DriveStatusError
> BadCRC }
> May 24 12:19:50 vzhik kernel: hde: timeout waiting for DMA
> May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
> May 24 12:19:50 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
> func only: 16
> May 24 12:19:50 vzhik kernel: hde: status timeout: status=0xd1 { Busy }
> May 24 12:19:50 vzhik kernel:
> May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
> May 24 12:19:50 vzhik kernel: hde: drive not ready for command
> May 24 12:19:50 vzhik kernel: ide2: reset: success
> May 24 12:24:24 vzhik kernel: hdg: ide_set_handler: handler not null;
> old=c01a5234, new=c01a5234
> May 24 12:24:24 vzhik kernel: bug: kernel timer added twice at c01a7356.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

