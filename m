Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281193AbRKTSMH>; Tue, 20 Nov 2001 13:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKTSL6>; Tue, 20 Nov 2001 13:11:58 -0500
Received: from 24-240-35-67.hsacorp.net ([24.240.35.67]:40710 "HELO
	majere.epithna.com") by vger.kernel.org with SMTP
	id <S281193AbRKTSLr>; Tue, 20 Nov 2001 13:11:47 -0500
Date: Tue, 20 Nov 2001 13:11:43 -0500 (EST)
From: <listmail@majere.epithna.com>
To: Brian <hiryuu@envisiongames.net>
Cc: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon: Kernel 2.4.14 IDE problems
In-Reply-To: <200111201624.fAKGO7E28238@demai05.mw.mediaone.net>
Message-ID: <Pine.LNX.4.33.0111201257460.29517-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had a similar with the 2.4.14 kernel when I added  a 80GB
Maxtor drive to the machine on an ABIT BP6 Board with the Highpoint 366
Controller.  The Drive was installed as the Master on the Highpoint.  The
Highpoint was not in bootable mode.  After I had installed the Drive,
Fdisked and formated and beguan loading data to it.  The machine
expirenced a strange lockup.  The machine being unresponsive, I hit the
reset.  Well it turned out that as it came backup it tripped over the new
drive, because it was unable to FSCK it at all.  Even single user mode
could no l.onger address the drive.  It kept throwing an error when
addressing the drive:  about chipset support (I aplogise for not having
the exact error text, it was before I joined the list).  In any case to
fix this error I had to move the drive to the standard IDE interface on
the board(the BP6 has 2 standard IDE, and 2 ata66 Ports)

On Tue, 20 Nov 2001, Brian wrote:

> We use 20 GB Western Digitals on our dual Athlons.  The chipset does
> support DMA and it has been quite stable.  Therefore, I would direct blame
> toward the drive.
>
> 	-- Brian
>
> On Tuesday 20 November 2001 07:41 am, Paul G. Allen wrote:
> > I just compiled and installed a vanilla 2.4.14 kernel (nope, I haven't
> > tweaked this one yet :). Just as a reminder, I have a Tyan Thunder K7
> > with 2 1.4GHz Athlons (_NOT_ MP or XP). It has an IBM DTLA-307030
> > Ultra100 IDE drive on the Ultra100 IDE interface.
> >
> > The kernel seems to boot with DMA enabled for this drive which causes
> > frequent system lockups. This is the same problem I had with kernels
> > through 2.4.9 (including the ac series). Disabling DMA (hdparm -d0
> > /dev/hda) solves the problem.
> >
> > Is this a hardware issue with the MP chipset (I have not kept up to date
> > on AMD errata due to other projects), or is this drive one of the known
> > IDE drives that do not properly support DMA? If a chipset issue, should
> > the kernel not detect the problem and disable DMA?
> >
> > PGA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

