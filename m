Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268783AbTBZPqW>; Wed, 26 Feb 2003 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268784AbTBZPqW>; Wed, 26 Feb 2003 10:46:22 -0500
Received: from lucidpixels.com ([66.45.37.187]:44305 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S268783AbTBZPqR>;
	Wed, 26 Feb 2003 10:46:17 -0500
Message-ID: <3E5CE3B2.6010003@lucidpixels.com>
Date: Wed, 26 Feb 2003 10:56:34 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vishwas@india.hp.com
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about DMA and cd burning.
References: <3E5C4ECD.7020806@lucidpixels.com> <3E5CA785.8010801@india.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, hdparm -d1 /dev/hd{b,c} did not work on older kernels for me, but 
2.4.20 appears to work successfully.

However, second question, both of my Plextors support UDMA2, and both 
are on 80 PIN/IDE cables, when I enabled -d1 -X66, the kernel, it 
crashed the kernel.

Feb 26 10:30:55 war kernel: hdc: drive_cmd: status=0x41 { DriveReady Error }
Feb 26 10:30:55 war kernel: hdc: drive_cmd: error=0x04
Feb 26 10:30:59 war kernel: hdc: drive_cmd: status=0x41 { DriveReady Error }
Feb 26 10:30:59 war kernel: hdc: drive_cmd: error=0x04
Feb 26 10:31:02 war kernel: hdc: drive_cmd: status=0x41 { DriveReady Error }
Feb 26 10:31:02 war kernel: hdc: drive_cmd: error=0x04
Feb 26 10:32:22 war kernel: scsi : aborting command due to timeout : pid 
11206, scsi1, channel 0, id 1, lun 0 Read (10) 00 00 00 00 00 00 00 02 00
Feb 26 10:32:22 war kernel: hdc: timeout waiting for DMA
Feb 26 10:32:22 war kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Feb 26 10:32:22 war kernel: hdc: status timeout: status=0xd8 { Busy }
Feb 26 10:32:22 war kernel: hdc: drive not ready for command

After this, X froze and the keyboard lights were blinking, I could not 
change to console or anything to see the kernel messages.

1] Why does the kernel turn DMA off by default?
     config: http://installkernel.tripod.com/config-2.4.20.txt
2] Why does the kernel crash when I try to enable UDMA2 on the cdrw?


vishwas@india.hp.com wrote:

> use: hdparam -d1 /dev/<hdX>
>
> to enable DMA, if it still says it cannot enable DMA.
> try enabling the xfermode,which gives me the same
> performace as DMA enabled.
>
> hdparam -X<num> /dev/<hdX>
>     put num greater than 32..like 33,34 etc  (for multiword DMA)
>     OR  greater that 64....like 65 66 etc.   (for UltraDMA)
>
> -vvp
>
>
>
>
>
>
>
>
>
>
>


