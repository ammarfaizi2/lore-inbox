Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGBLCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 07:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTGBLCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 07:02:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263894AbTGBLCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 07:02:50 -0400
Date: Wed, 2 Jul 2003 13:17:08 +0200
From: Jens Axboe <axboe@suse.de>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow writer...
Message-ID: <20030702111708.GB839@suse.de>
References: <20030701213036.GB239@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701213036.GB239@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01 2003, DervishD wrote:
>     Hi all :))
> 
>     I've installed a PlexWriter Premium (52x) in my system, and the
> highest speed I can achieve with it is 24x with data and 15x with
> audio (the speed difference is quite strange :??). The hard disk is
> UDMA5, so it should provide the data at 52x. This is the info for the
> hard disk:
> 
> /dev/root:
> 
>  Model=ST340016A, FwRev=3.05, SerialNo=3HS040AC
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4 
>  DMA modes:  mdma0 mdma1 mdma2 
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: device does not report version:  1 2 3 4 5
> 
>     As you can see, the udma5 mode is active, and this is a test from
> hdparm on the same disk:
> 
> /dev/root:
>  Timing buffered disk reads:  64 MB in  1.58 seconds = 40.51 MB/sec
> 
>     Am I doing something wrong, like not tuning correctly something
> in the disk? I am using a DIY box with Linux 2.4.21, CPU Duron 850,
> and no processes are running while burning in order to not disturb
> the writing process. I'm afraid that DMA is not working properly or
> maybe the motherboard is damaged or something like that :??

Questions:

- Is the cd writer on a different channel?
- What ide adapter are you using?
- Is dma enabled on the cd writer?
- What cdrecord version are you using?

You should try 2.5.73 as well and see if it makes any difference. Make
sure to use -dev=/dev/hdc (or whatever your cd-rw drive is) and _don't_
use ide-scsi (just ide-cd)

-- 
Jens Axboe

