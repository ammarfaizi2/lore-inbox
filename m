Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDJPql>; Tue, 10 Apr 2001 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDJPqc>; Tue, 10 Apr 2001 11:46:32 -0400
Received: from [216.97.27.1] ([216.97.27.1]:4624 "EHLO
	alabaster.propagation.net") by vger.kernel.org with ESMTP
	id <S132313AbRDJPqQ>; Tue, 10 Apr 2001 11:46:16 -0400
Message-ID: <008801c0c1d5$652210a0$1501a8c0@ramphome.com>
Reply-To: "Reverend EvvL X" <EvvL@RustedHalo.net>
From: "Reverend EvvL X" <EvvL@RustedHalo.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <986664971.1224.4.camel@bugeyes.wcu.edu> <008401c0c167$73f14d80$8d19b018@c779218a> <986874119.4770.0.camel@bugeyes.wcu.edu>
Subject: Re: UDMA(66) drive coming up as UDMA(33)?
Date: Tue, 10 Apr 2001 08:46:21 -0700
Organization: The RustedHalo Network
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently running a BP6 with a on board HPT366 and a 7200rpm
drive. From what I've seen with my setup at home that 19.51 MB/s
sounds just about right for a hdparm test. When the manual is
refering to the "UDMA 4 66 Mb/s" their talking about the maximum
burst rate for the ATA bus not the max transfer rate, someone
please correct me if I'm worng.

-Eric Olinger

----- Original Message -----
From: "David St.Clair" <dstclair@cs.wcu.edu>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, April 09, 2001 8:41 PM
Subject: Re: UDMA(66) drive coming up as UDMA(33)?


> Well, I'm positive what I have is an 80pin cable. I may try a diffrent
> one.  I guess I could benchmark the drive in windows and see how it
> compares to linux. (Both are on the same drive). The HPT366 chip is
> integrated on the BE6 motherboard.
>
> The manual says PIO 4 mode should get about 16.6 Mb/s, UDMA 2 33 Mb/s,
> and UDMA 4 66 Mb/s.  Does anyone know what the correct numbers I should
> be seeing in linux? (/w hdparm -t)
>
> Again, my hardware is:
>
> Quantum Fireball KA 13.6 7200 rpm HD
> Abit BE6 /w integrated HPT366 chip
>
> Kernel 2.4.3
>
>
> Thanks,
>
> David St.Clair
>
>
>
>
> On 09 Apr 2001 19:39:23 -0700, Nicholas Knight wrote:
> > ----- Original Message -----
> > From: "David St.Clair" <dstclair@cs.wcu.edu>
> > To: <linux-kernel@vger.kernel.org>
> > Sent: Saturday, April 07, 2001 10:36 AM
> > Subject: UDMA(66) drive coming up as UDMA(33)?
> >
> >
> > > I'm trying to get my hard drive to use UDMA/66.  I'm thinking the
cable
> > > is not being detected.  When the HPT366 bios is set to UDMA 4; using
> > > hdparm -t, I get a transfer rate of 19.51 MB/s. When the HPT366 bios
is
> > > set to PIO 4 the transfer rate is the same. Is this normal for a
UDMA/66
> > > drive? What makes me think something is wrong is that the log says
> >
> > The speed is dependant on the drive, and has absilutely nothing to do
with
> > the UDMA mode, beyond that the controller and cable need to be able to
> > support at least the speed the drive is recieving/outputting data in
order
> > for the drive to operate at full speed, 19.51MB/sec sounds right for a
good
> > 7200RPM HDD
> >
> > >
> > > "ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio" <-- PIO?
> >
> > hmm this is a little odd but I don't know the ins and outs of the HPT366
> > controller
> >
> > >
> > > and
> > >
> > > "hde: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63,
> > > UDMA(33)" <--- UDMA(33)? shouldn't it be UDMA(66)?
> > >
> >
> > this certainly sounds like it's not detecting the cable properly... have
you
> > tried replacing it with a new cable that you KNOW supports ATA/66?
> >
> >
> > > HPT366: onboard version of chipset, pin1=1 pin2=2
> >
> > is the HPT366 controller in an add-in card or built into the
motherboard? it
> > looks like it's builtin from this line
> >
> > the bottom line here is that the cable probably isn't being detected
> > properly for some reason, I doubt if it's a kernel problem, the cable is
> > probably "bad", try picking up a new ATA/66+ cable and putting it in
there
> > this shouldn't actually cause you problems unless you're often
transferring
> > more than 33MB/sec though, which isn't likely on a desktop system,
ATA/66
> > and ATA/100 are *generaly* overkill for most desktop systems, even for
many
> > powerusers
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

