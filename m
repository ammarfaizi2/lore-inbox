Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRLVSVN>; Sat, 22 Dec 2001 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286835AbRLVSVD>; Sat, 22 Dec 2001 13:21:03 -0500
Received: from DSL05-106.LABridge.com ([206.117.134.106]:32896 "EHLO
	xi.blackbean.org") by vger.kernel.org with ESMTP id <S281762AbRLVSUp>;
	Sat, 22 Dec 2001 13:20:45 -0500
Date: Sat, 22 Dec 2001 10:20:43 -0800
To: Adam Keys <akeys@post.cis.smu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Message-ID: <20011222182043.GA4474@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: Jim Radford <radford@blackbean.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hda: Maxtor 93073U6, ATA DISK drive
> hdc: Maxtor 90840D6, ATA DISK drive
 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec
> /dev/hdc:
>  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec

I'm in the same boat with my Maxtor 54098U8.  It has been getting
progressively slower.  Two weeks ago I was getting a whopping 3MB/s,
now I get:

/dev/hda:
 Timing buffered disk reads:  64 MB in 115.29 seconds =568.44 kB/sec

My CDROM (ide-scsi) is faster than this!

# time dd if=/dev/scd0 of=/dev/null count=32k bs=512
real    0m8.443s

  = 1.8MB/sec

The wierd thing is that I don't get any errors, but I have just
switched from emacs to vi. :-) I ran Maxtor's powermax.exe and their
90sec test hadn't finished after 20 minutes so I rebooted. :-(

Same results with 2.4.9 - 2.4.17.

-Jim

VP_IDE: VIA vt82c686a (rev 14) IDE UDMA66 controller on pci00:07.1

# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4865/255/63, sectors = 78165360, start = 0
 busstate     =  1 (on)
