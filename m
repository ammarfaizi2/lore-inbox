Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRBFOZG>; Tue, 6 Feb 2001 09:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129400AbRBFOY5>; Tue, 6 Feb 2001 09:24:57 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:16903 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129446AbRBFOYX>; Tue, 6 Feb 2001 09:24:23 -0500
Message-ID: <3A800912.1B77C3DB@Hell.WH8.TU-Dresden.De>
Date: Tue, 06 Feb 2001 15:24:18 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA silent disk corruption - bad news
In-Reply-To: <14B049560B85@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On  5 Feb 01 at 23:08, Udo A. Steinberg wrote:
> 
> > 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
> >         Subsystem: Asustek Computer, Inc.: Unknown device 8033
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>                   >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
>                                                     ^^^^^^
> I tried all different settings in BIOS, and I even programmed values
> from your lspci to my VIA (except for SDRAM timmings) - and although
> it is a bit better, it is not still perfect.

> So for today I'm back on [UMS]DMA disabled. I'll try downgrading BIOS
> today, but it looks to me like that something is severely broken here.

Are your drives connected to the VIA or the Promise controller? Mine
are both connected to the PDC20265 and running in UDMA-100 mode. There
have been several threads on lkml about corruption on disks connected
to Via chipset IDE controllers, although I didn't follow them in great
detail. Maybe your problem is not related to the host bridge, but to
the IDE controller?

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
