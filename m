Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQL2JPm>; Fri, 29 Dec 2000 04:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQL2JPe>; Fri, 29 Dec 2000 04:15:34 -0500
Received: from inje.iskon.hr ([213.191.128.16]:19460 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S129340AbQL2JPR>;
	Fri, 29 Dec 2000 04:15:17 -0500
Date: Fri, 29 Dec 2000 09:14:47 +0100
From: Vid Strpic <strpic@bofhlet.net>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 dies on my 486..
Message-ID: <20001229091447.A4283@localhost>
Mail-Followup-To: Vid Strpic <strpic>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E14BSuz-00038b-00@the-village.bc.nu> <Pine.LNX.4.31.0012281859360.802-200000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0012281859360.802-200000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Thu, Dec 28, 2000 at 07:09:34PM -0500
X-Operating-System: Linux 2.4.0-test11
X-Editor: VIM - Vi IMproved 5.7 (2000 Jun 24, compiled Jul  8 2000 15:10:48)
X-Authenticated-Sender: Vid Strpic <strpic@bofhlet.net>
X-Politics: UNIX fundamentalist
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 07:09:34PM -0500, Mike A. Harris wrote:
> On Thu, 28 Dec 2000, Alan Cox wrote:
> >What hardware config, what hdparm tuning options ?
> AMD 486-DX2/66 12Mb RAM, ALi 14xx chipset.  Using 2.2.18 stock
> and also 2.2.18+IDE.
> 
> hdparm settings:
> 
> /dev/hdb:
>  multcount    =  8 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 827/32/63, sectors = 1667232, start = 0
> 
>  Model=Maxtor 7850 AR, FwRev=UA7X6059, SerialNo=P60133LS
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs FmtGapReq }
>  RawCHS=1654/16/63, TrkSize=0, SectSize=0, ECCbytes=11
>  BuffType=3(DualPortCache), BuffSize=64kB, MaxMultSect=8, MultSect=8
>  DblWordIO=yes, OldPIO=2, DMA=yes, OldDMA=1
>  CurCHS=1654/16/63, CurSects=1889533977, LBA=yes, LBAsects=1667232
>  tDMA={min:150,rec:150}, DMA modes: sword0 sword1 *sword2 *mword0
>  IORDY=on/off, tPIO={min:240,w/IORDY:180}, PIO modes: mode3
> 
> I am thinking possible hardware failure, but I havent spent time
> yet trying to narrow it down.

I think it's probably a hardware issue, yes.  I've seen several Maxtors
doing just this kind of stuff before ... I have one @ork which gives
this kind of errors if I put the box sideways - if it stays upright, no
problems :)

> No special lilo options or any tweaking going on on this machine
> other than hdparm..

Well, have you tried setting 32-bit support to '0'?  Just for hdb,
first, if that doesn't help, for hda and hdc also.

It happened to me on one machine (486 also, just one Quantum) but
inexplainably sometimes.  On other occasions all is well.

-- 
    ))       Vid Strpic, IRC:Martin, strpic@bofhlet.net, /bin/zsh.
    ((         (I don't speak for my employer, just for myself.)
  C|~~|     UNIX fundamentalist - and an average chauvinistic male.
   `--'
  C>N>K   Never anger a dragon, for you are crunchy and good with ketchup.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
