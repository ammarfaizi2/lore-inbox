Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310126AbSCKOaK>; Mon, 11 Mar 2002 09:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310124AbSCKO37>; Mon, 11 Mar 2002 09:29:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:35593 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310126AbSCKO3t>; Mon, 11 Mar 2002 09:29:49 -0500
Date: Mon, 11 Mar 2002 15:29:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dog slow IDE
Message-ID: <20020311152942.A25466@ucw.cz>
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv>; from tmh@nothing-on.tv on Mon, Mar 11, 2002 at 01:40:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What does haparm /dev/hda (without the -i) say? Is it using DMA at all?
It may be set up for UDMA4 or UDMA5 but still run PIO only ... btw what
chipset is this?

Vojtech

On Mon, Mar 11, 2002 at 01:40:59PM +0000, Tony Hoyle wrote:
> For some reason the my IDE is running extremely slow (which accounts for 
> why this box feels so sluggish).
> 
> hdparm gives:
> 
> /dev/hda:
> 
>   Model=Maxtor 53073U6, FwRev=DA6207V0, SerialNo=K607RFNC
>   Config={ Fixed }
>   RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>   BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>   CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60030432
>   IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes: pio0 pio1 pio2 pio3 pio4
>   DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
>   AdvancedPM=yes: disabled (255) WriteCache=enabled
>   Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 
> ATA-4 ATA-5
> 
> /dev/hdb:
> 
>   Model=MAXTOR 4K040H2, FwRev=A08.1500, SerialNo=572124112782
>   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>   RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>   BuffType=DualPortCache, BuffSize=2000kB, MaxMultSect=16, MultSect=16
>   CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78198750
>   IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes: pio0 pio1 pio2 pio3 pio4
>   DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>   AdvancedPM=no WriteCache=enabled
>   Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 
> ATA-4 ATA-5
> 
> Both drives claim to be using UDMA if I read the above correctly.
> 
> However:
> 
> /dev/hda:
>   Timing buffered disk reads:  64 MB in 16.27 seconds =  3.93 MB/sec
> 
> /dev/hdb:
>   Timing buffered disk reads:  64 MB in 32.99 seconds =  1.94 MB/sec
> 
> 1.94MB/sec is *way* to slow for a UDMA5 hard disk surely?
> 
> Tony
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
