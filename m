Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315910AbSEGRXj>; Tue, 7 May 2002 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315911AbSEGRXi>; Tue, 7 May 2002 13:23:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52236
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315910AbSEGRXi>; Tue, 7 May 2002 13:23:38 -0400
Date: Tue, 7 May 2002 10:21:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@suse.de>
cc: Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <20020507160825.S22215@suse.de>
Message-ID: <Pine.LNX.4.10.10205071020520.22915-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



vaio:~ # hdparm -i /dev/hda

/dev/hda:

 Model=FUJITSU MHJ2181AT, FwRev=D034, SerialNo=01001697
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=35433216
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 Drive Supports : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=2205/255/63 PhysicalCHS=37495/15/63

BS Dave it does parse the difference nicely

On Tue, 7 May 2002, Dave Jones wrote:

> On Tue, May 07, 2002 at 02:57:46PM +0100, Anton Altaparmakov wrote:
>  > How do I get this information with hdparm please?
>  > 
>  > [aia21@drop ide]$ cat via
> 
> Bartlomiej Zolnierkiewicz moved all this stuff to userspace
> a long time ago in 'ideinfo'.
> 
>  > [aia21@drop hda]$ cat cache
>  > 1916
>  > [aia21@drop hda]$ cat capacity
>  > 80418240
>  > [aia21@drop hda]$ cat geometry
>  > physical     79780/16/63
>  > logical      5005/255/63
>  > 
>  > And hdparm never gives you the physical geometry AFAICS.
> 
> Why would a normal user ever need to know this info?
> 
>  > And as I said, I can understand removing the ability to write values into 
>  > /proc/ide/*, what I disagree with is the removal of the information 
>  > provided by read-only access to /proc/ide/*. And that is because I am not 
>  > aware of any other way to get the same information.
> 
> The parsing gunk we have for /proc/ide is fugly, and should have been
> done with sysctls from day one imo.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

