Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRBFOfI>; Tue, 6 Feb 2001 09:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129537AbRBFOe5>; Tue, 6 Feb 2001 09:34:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:6161 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129512AbRBFOev>;
	Tue, 6 Feb 2001 09:34:51 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Date: Tue, 6 Feb 2001 15:31:08 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VIA silent disk corruption - bad news
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <14B6B12B6E92@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Feb 01 at 15:24, Udo A. Steinberg wrote:
> Petr Vandrovec wrote:
> > On  5 Feb 01 at 23:08, Udo A. Steinberg wrote:
> > 
> > > 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
> > >         Subsystem: Asustek Computer, Inc.: Unknown device 8033
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> > >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
> >                   >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> >                                                     ^^^^^^
> > I tried all different settings in BIOS, and I even programmed values
> > from your lspci to my VIA (except for SDRAM timmings) - and although
> > it is a bit better, it is not still perfect.
> 
> > So for today I'm back on [UMS]DMA disabled. I'll try downgrading BIOS
> > today, but it looks to me like that something is severely broken here.
> 
> Are your drives connected to the VIA or the Promise controller? Mine
> are both connected to the PDC20265 and running in UDMA-100 mode. There
> have been several threads on lkml about corruption on disks connected
> to Via chipset IDE controllers, although I didn't follow them in great
> detail. Maybe your problem is not related to the host bridge, but to
> the IDE controller?

They are connected to Promise, I reserved VIA for CDROM drive.
One HDD runs in UDMA5 mode, another in UDMA2. Corruption is often
when I run md5sum in parallel on both HDDs - in that case almost
no file generates same checksum which was generated using PIO4.
When I run md5sum on only one HDD, there are about 4 checksum errors
in 6GB of data. But I'm more and more inclined to throw this A7V away,
as it is impossible to get datasheet from Promise, and for VIA host
bridge I was just able to slow down normal system operation by factor
of 3... but still with same corruption :-( Just if page could have
4092 and not 4096 bytes ;-)
                                                Petr
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
