Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132901AbRDJCjn>; Mon, 9 Apr 2001 22:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132902AbRDJCjd>; Mon, 9 Apr 2001 22:39:33 -0400
Received: from femail13.sdc1.sfba.home.com ([24.0.95.140]:48623 "EHLO
	femail13.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S132901AbRDJCjR>; Mon, 9 Apr 2001 22:39:17 -0400
Message-ID: <008401c0c167$73f14d80$8d19b018@c779218a>
From: "Nicholas Knight" <tegeran@home.com>
To: "David St.Clair" <dstclair@cs.wcu.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <986664971.1224.4.camel@bugeyes.wcu.edu>
Subject: Re: UDMA(66) drive coming up as UDMA(33)?
Date: Mon, 9 Apr 2001 19:39:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "David St.Clair" <dstclair@cs.wcu.edu>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, April 07, 2001 10:36 AM
Subject: UDMA(66) drive coming up as UDMA(33)?


> I'm trying to get my hard drive to use UDMA/66.  I'm thinking the cable
> is not being detected.  When the HPT366 bios is set to UDMA 4; using
> hdparm -t, I get a transfer rate of 19.51 MB/s. When the HPT366 bios is
> set to PIO 4 the transfer rate is the same. Is this normal for a UDMA/66
> drive? What makes me think something is wrong is that the log says

The speed is dependant on the drive, and has absilutely nothing to do with
the UDMA mode, beyond that the controller and cable need to be able to
support at least the speed the drive is recieving/outputting data in order
for the drive to operate at full speed, 19.51MB/sec sounds right for a good
7200RPM HDD

>
> "ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio" <-- PIO?

hmm this is a little odd but I don't know the ins and outs of the HPT366
controller

>
> and
>
> "hde: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63,
> UDMA(33)" <--- UDMA(33)? shouldn't it be UDMA(66)?
>

this certainly sounds like it's not detecting the cable properly... have you
tried replacing it with a new cable that you KNOW supports ATA/66?


> HPT366: onboard version of chipset, pin1=1 pin2=2

is the HPT366 controller in an add-in card or built into the motherboard? it
looks like it's builtin from this line

the bottom line here is that the cable probably isn't being detected
properly for some reason, I doubt if it's a kernel problem, the cable is
probably "bad", try picking up a new ATA/66+ cable and putting it in there
this shouldn't actually cause you problems unless you're often transferring
more than 33MB/sec though, which isn't likely on a desktop system, ATA/66
and ATA/100 are *generaly* overkill for most desktop systems, even for many
powerusers

