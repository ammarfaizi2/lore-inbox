Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRIEXRB>; Wed, 5 Sep 2001 19:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272079AbRIEXQv>; Wed, 5 Sep 2001 19:16:51 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:49679 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S272359AbRIEXQg>; Wed, 5 Sep 2001 19:16:36 -0400
Message-ID: <003401c13660$84eab860$20040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Stanislav Brabec" <utx@penguin.cz>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010905234544.A18413@utx.vol.cz>
Subject: Re: PCI (?) problems of MSI K7T266 Pro = MS-6380 / VIA KT266 8233
Date: Wed, 5 Sep 2001 19:14:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have Microstar mainboard MSI K7T266 Pro (MS-6380) with
> VIA KT266 chipset (VIA 8233), Athlon 1200/266, linux-2.4.9
>
> Does anybody with this mainboard have some problems (or using it
> succesfull), or should I suspect some bad setup / problematic PCI card
> or more particular bugs?

We have a machine with this motherboard and a 1.4Ghz Athlon CPU and use it
without significant problems.

> I have encountered many, probably PCI related problems:

I don't find any of these to point toward PCI problems, are there other
reasons you would suspect PCI?

> - USB PC2PC driver sometimes looses data errors (cca once per 20MB)

This actually sounds pretty good, do you really mean one error per 20MB?
I've never used the PC2PC driver but knowing the nature of USB with it's
bandwidth saturation issues, etc. I think this sounds pretty good.

> - SCSI scanner sometimes hangs scanning

Sounds like a SCSI configuration problem, possibly termination.

> - SCSI CD-ROM/writer sometimes fails to mount CD-ROM (read errors)

See above.

One other thing to check though, I'm assuming your using the onboad SCSI.
I've seen at least one of these have "unexplained" SCSI problems that turned
out to be caused by the SCSI connector on the motherboard grounding out to
the case.  The connector is precariously close to the metal grouding pad
where the board is commonly mounted to the case.  A small insulator did the
trick in the cases I've seen (in one case it was total bus failure on
channel A, in the other it was simply intermittent errors).

> - Mangled sound output from AC97 codec

I think this is largely caused by the VIA audio driver included with
standard linux.  I've had no end of trouble with it.  I use ALSA on my VIA
chip and it works mostly without trouble.  I'd suggest at least giving it a
try.

> - PCI bus cannot be overclocked to more than 34.5 MHz

Uh, what do you expect?  The spec is 33Mhz, you're not guaranteed more than
that, that's why they have a spec.

Later,
Tom




