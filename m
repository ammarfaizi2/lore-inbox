Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbTCTKOC>; Thu, 20 Mar 2003 05:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbTCTKOC>; Thu, 20 Mar 2003 05:14:02 -0500
Received: from adsl96162.timewarp.co.uk ([217.149.96.162]:5620 "EHLO
	mail.emorphia.com") by vger.kernel.org with ESMTP
	id <S261359AbTCTKOA>; Thu, 20 Mar 2003 05:14:00 -0500
From: "Chris Newland" <chris.newland@emorphia.com>
To: "Wolfram Schlich" <wolfram@schlich.org>,
       "Linux-Kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: RE: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Date: Thu, 20 Mar 2003 10:23:48 -0000
Message-ID: <OAEPKDBINGEGKPCJJAJDKEBDJIAA.chris.newland@emorphia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
Importance: Normal
X-Authenticated-Sender: chrisnewland@emorphia.com
X-Return-Path: chris.newland@emorphia.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

I had the same hardlock problem with dual athlons, MSI K7D Master, Promise
TX2000 (PDC20271) with 2 HDDs on RAID0 on the Promise card and only a CDROM
on the onboard IDE channel.

It used to lock hard (2.4.18 vanilla kernel) on 'tar' when using a USB mouse
but I haven't had a single lockup since plugging in a PS2 mouse :)

PS. Whilst 2.4 kernels run fine for me, I can't get any 2.5 kernel to run
yet.

I get a VFS kernel panic on bootup (can't mount root device).

I've installed Rusty's 2.5 modutils and tried compiling the 20271 driver
both into the kernel and as a module.

I read in Dave Jones' post-halloween notes that the Promise drivers are
broken:

<quote>
- The hptraid/promise RAID drivers are currently non functional, and
  will probably be converted to use device-mapper.
</quote>

Is this still true?

Best Regards,

Chris Newland

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Wolfram Schlich
> Sent: 20 March 2003 07:23
> To: Linux-Kernel mailinglist
> Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and
> shared IRQs
>
>
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [2003-03-20 01:31]:
> > On Wed, 2003-03-19 at 22:16, Wolfram Schlich wrote:
> > > When one of the Promise controllers is sharing the same IRQ
> with one of
> > > the NICs (don't matter which, I tried all) and data is copied *to* the
> > > machine over the network, the system deadlocks. When data is copied
> > > *from* the system over the network, it works all ok. Unfortunately the
> > > system BIOS doesn't give me any possibility of setting the IRQ
> > > channels by hand, so all I can do is put the cards into other slots.
> > >
> >
> > Thats very useful information. There certain have been (and it seems
> > still are) some cases with shared IRQ that are not quite handled right.
> > The 2.4.21pre5/pre5-ac work has partly been about fixing it. Deadlocks
> > suprise me however, since the problems I've seen have been I/O
> > errors.
>
> Well, now I have trashed my array :-)
> -> http://marc.theaimsgroup.com/?l=linux-raid&m=104811878405765&w=2
>
> Btw., it spits out *lots* of messages when IRQ sharing is *disabled*
> in the kernel config and just dies quietly when it's *enabled*
> (having it dying before didn't mess up my array... ;)).
>
> > However there is another known problem that does cause deadlocks with
> > the AMD76x, especially if the onboard IDE is used. Shove a PS/2 mouse
> > in the box, reboot and retest - if you dont already have one
>
> ?! I'm using the onboard IDE for two CDROM drives and one smaller
> hard disk which I use rarely... and I didn't use any of these devices
> in the cases in which I had the described problems... Anyway, why should I
> connect a PS/2 mouse to the machine? Is it gonna solve all my
> problems at once? ;-)
> --
> Mit freundlichen Gruessen / Yours sincerely
> Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

