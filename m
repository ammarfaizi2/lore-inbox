Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131366AbQLVVLC>; Fri, 22 Dec 2000 16:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131757AbQLVVKx>; Fri, 22 Dec 2000 16:10:53 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:38154 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131366AbQLVVKk>;
	Fri, 22 Dec 2000 16:10:40 -0500
Message-ID: <00d901c06c57$5ece3220$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Andreas Dilger" <adilger@turbolinux.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>,
        "Linux Raid mailing list" <linux-raid@vger.kernel.org>
In-Reply-To: <200012222032.eBMKW0U13909@webber.adilger.net>
Subject: Re: Fw: max number of ide controllers?
Date: Fri, 22 Dec 2000 15:40:07 -0500
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

> Charles Wilkins writes:
> > Andrzej M. Krzysztofowicz says,
> >
> > >"Linux supports up to 10 IDE channels, however channel numbers of PCI
> > controllers seem to be assigned first."
> >
> > Warren Young says,
> > >"Kernel 2.2 is limited to 4 IDE controllers."
> >
> > ok, so which is it kernel guys, 4 or 10 IDE controllers for the 2.2.x
> > kernel?
>
> It depends if you have Andre's IDE patches applied to your kernel sources

I have ide.2.2.18.1209.patch applied. The kernel is 2.2.18.
So what is the answer? 4 controllers max or 10 for my kernel?

> or not.
>
> > well, i know this SB32 card can operating on at least 3 different io
ports .
> > . .
>
> It may be that there is some difficulty in the order the IDE cards are
> initialized.  From your previous dmesg output, it appears that ide3 and
ide4
> (PCI cards) are initialized before ide2 (ISA card), so they may be
stealing
> an ioport that the ISA card needs.  Try booting with just the SB32 card
> and checking /proc/ioports, and then with only the other card, and see
> if anything in /proc/ioports (or /proc/interrupts) is conflicting.
>

I have done this. There are no conflicts.
SB32 uses 0x168-0x16f,0x36e,10 and nothing else does.

What would be the correct kernel command to manually set up the SB32 as ide
4 for the above resources?

Kernel 2.4.0-test12 picks up the SB32 controller even with the promise
controller is installed, but I would prefer to stay with the stable 2.2.x
kernel if possible.

Charles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
