Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSGYHkt>; Thu, 25 Jul 2002 03:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGYHkt>; Thu, 25 Jul 2002 03:40:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26629 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317448AbSGYHkt>; Thu, 25 Jul 2002 03:40:49 -0400
Message-ID: <3D3FAB09.8080909@evision.ag>
Date: Thu, 25 Jul 2002 09:38:49 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [IDE bug] hdparm lockup
References: <3D3F9012.B066A944@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 2.5.28, uniprocessor
> 
> 00:0f.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 
> quad:/home/akpm> 0 hdparm -i /dev/hdc 
> 
> /dev/hdc:
>  HDIO_GETGEO_BIG failed: Invalid argument
>  (what's this?)

Please don't call every bug out there IDE. Thanks.
Becouse this one is acutally most likely due to the ioctl() handling
changes between 27 and 28...
> 
>  Model=Maxtor 96147H6, FwRev=ZAH814Y0, SerialNo=V60JT12C
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120064896
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
>  Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 
>  Kernel Drive Geometry LogicalCHS=7473/255/63
> 
> The command
> 
> 	hdparm -d1 -A1 -m16 -u1 -a64 /dev/hdc

Maybe indeed IDE or maybe as well the READA code or simple
related to the above error. I will recheck after I get 2.5.28 up and
running.



