Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284854AbRL2NXo>; Sat, 29 Dec 2001 08:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287189AbRL2NXe>; Sat, 29 Dec 2001 08:23:34 -0500
Received: from mail.sonytel.be ([193.74.243.200]:18853 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S284854AbRL2NXW>;
	Sat, 29 Dec 2001 08:23:22 -0500
Date: Sat, 29 Dec 2001 14:23:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <20011229004430.Y1507-100000@gerard>
Message-ID: <Pine.GSO.4.21.0112291421030.277-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> On Fri, 28 Dec 2001, Geert Uytterhoeven wrote:
> > The sym-2 driver has a define for modifying the PCI latency timer
> > (SYM_SETUP_PCI_FIX_UP), but it is never used, so I see no corruption.
> 
> By default sym-2 use value 3 for the pci_fix_up (cache line size + memory
> write and invalidate). The latency timer fix-up has been removed, since it
> is rather up to the generic PCI driver to tune latency timers.
> 
> > Is this a hardware bug in my SCSI host adapter (53c875 rev 04) or my host
> > bridge (VLSI VAS96011/12 Golden Gate II for PPC), or a software bug in the
> > driver (wrong burst_max)?
> 
> Great bug hunting!
> 
> It is about certainly not a software bug in the driver. Any latency timer
> value should not give any trouble if hardware was flawless. Just the PCI
> performances could be affected.

I played a bit with sym-2 and setpci. Everything goes fine as long as the PCI
latency timer value is smaller than 0x16 (yes, at first I thought it was
decimal, but setpci parameters are in hex).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

