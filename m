Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVBAKmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVBAKmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVBAKmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:42:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64909 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261973AbVBAKmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:42:19 -0500
Date: Tue, 1 Feb 2005 11:42:14 +0100
From: Jens Axboe <axboe@suse.de>
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Strange vmstat output. 2.6.10 Scheduler?
Message-ID: <20050201104214.GK4137@suse.de>
References: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro> <20050201102638.GJ4137@suse.de> <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01 2005, Catalin(ux aka Dino) BOIE wrote:
> 
> >On Tue, Feb 01 2005, Catalin(ux aka Dino) BOIE wrote:
> >>Hello!
> >>
> >>I have a weird problem with a server. I use deadline.
> >>The output of vmstat is:
> >> 1  1  12312   6064   7580 815432    0    0  5332   456 1263  3119 22  5  
> >> 0
> >> 73
> >> 0  1  12312   5280   7584 816240    0    0  6204   620 1307  1530 15  4  
> >> 0
> >> 81
> >> 0  1  12312   6096   7528 815088    0    0  7604  8732 1256  1398  5  8  
> >> 0
> >> 87
> >> 0  1  12312   6048   7528 815144    0    0     8     8 1243  1440 14  2  
> >> 0
> >> 84
> >> 0  1  12312   6048   7528 815168    0    0     0     0 1261  1287  8  2  
> >> 0
> >> 90
> >> 0  2  12312   6040   7584 815184    0    0     0     0 1258  1197  7  2  
> >> 0
> >> 91
> >> 0  2  12312   6024   7584 815208    0    0     0     0 1265  1309  6  5  
> >> 0
> >> 89
> >> 0  2  12312   6024   7584 815208    0    0     0   136 1253   365  2  2  
> >> 0
> >> 96
> >> 0  2  12312   5984   7584 815208    0    0     0     0 1268   413  2  1  
> >> 0
> >> 97
> >> 0  2  12312   6052   7584 815208    0    0     0     0 1270   375  2  1  
> >> 0
> >> 97
> >> 1  0  12312   6164   7584 815156    0    0  6188   288 1270  4314 23  5  
> >> 0
> >> 72
> >> 0  1  12312   5684   7536 815592    0    0  4128  8656 1270  1316 14  3  
> >> 0
> >> 83
> >> 0  1  12312   5684   7536 815608    0    0     0     0 1258  1251  8  3  
> >> 0
> >> 89
> >> 0  1  12312   5552   7536 815628    0    0     0     0 1258  1327  8  2  
> >> 0
> >> 90
> >> 0  1  12312   5552   7536 815644    0    0     0     0 1264  1127  7  2  
> >> 0
> >> 91
> >> 0  1  12312   5552   7536 815668    0    0     0     2 1258  1225  8  3  
> >> 0
> >> 89
> >> 0  3  12312   5248   7588 816108    0    0  4340   585 1249  1316  7  3  
> >> 0
> >> 90
> >> 0  2  12312   5612   7584 815680    0    0  3092   188 1254   411  3  1  
> >> 0
> >> 96
> >> 0  2  12312   5564   7584 815676    0    0     0     0 1261   259  2  2  
> >> 0
> >> 96
> >> 0  2  12312   5564   7584 815676    0    0     0     0 1254   348  2  1  
> >> 0
> >> 97
> >>
> >>It seems strange because iowait is at 90% but nothing is trasnfered
> >>to/from disk. Why is that?
> >
> >The bi/bo numbers are sometimes a little confusing, it doesn't mean that
> >the drive is actually doing 8656kb of io at that very second - only that
> >this much io was queued to the drive.
> >
> >>I run postgresql on this server and I'm not satistied by it's speed.
> >>
> >>Single Pentium IV, IDE disk.
> >>
> >>What can be the problem?
> >
> >Do you have write cache enabled on the drive?
> 
> No. Intentionaly I disabled it:
> 
> ATA device, with non-removable media
>         Model Number:       WDC WD800JB-00CRA1
>         Serial Number:      WD-WMA8E8797395
>         Firmware Revision:  17.07W17
> Standards:
>         Supported: 5 4 3 2
>         Likely used: 6
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  156301488
>         device size with M = 1024*1024:       76319 MBytes
>         device size with M = 1000*1000:       80026 MBytes (80 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         bytes avail on r/w long: 40     Queue depth: 1
>         Standby timer values: spec'd by Standard, with device specific 
> minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Recommended acoustic management value: 128, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    READ BUFFER cmd
>            *    WRITE BUFFER cmd
>            *    Host Protected Area feature set
>            *    Look-ahead
>                 Write cache
>            *    Power Management feature set
>                 Security Mode feature set
>            *    SMART feature set
>            *    Device Configuration Overlay feature set
>                 Automatic Acoustic Management feature set
>                 SET MAX security extension
>            *    DOWNLOAD MICROCODE cmd
>            *    SMART self-test
>            *    SMART error logging
> Security:
>                 supported
>         not     enabled
>         not     locked
>                 frozen
>         not     expired: security count
>         not     supported: enhanced erase
> HW reset results:
>         CBLID- above Vih
>         Device num = 0 determined by CSEL
> Checksum: correct
> 
> Thanks!

Well then that is why, the writes are taking quite a while to reach the
platter. Nothing is wrong, the drive is just slow :-)

-- 
Jens Axboe

