Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313936AbSDPWzx>; Tue, 16 Apr 2002 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313937AbSDPWzw>; Tue, 16 Apr 2002 18:55:52 -0400
Received: from nydalah028.sn.umu.se ([130.239.118.227]:39088 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S313936AbSDPWzu>; Tue, 16 Apr 2002 18:55:50 -0400
Message-ID: <01a101c1e599$db6634b0$0201a8c0@homer>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Michael Obster" <michael.obster@bingo-ev.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com> <00dc01c1e58b$668dd2f0$0201a8c0@homer> <3CBCB762.4030902@bingo-ev.de>
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
Date: Wed, 17 Apr 2002 00:55:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Michael Obster" <michael.obster@bingo-ev.de>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 17, 2002 1:44 AM
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O


> hi,
>
> >>I get (when FSCK):
> >>
> >>spurious 8259A IRQ7
>
> I also get this message every time i boot my machine when the fs are
> mounted. but i don't had a machine lock yet.
> Configuration: Athlon 1GHz on a VIA chip (ASUS A7V).
> Btw. What does this message say?

Nothing to worry about.
Interrupts which are not known where they originate from are sent to IRQ7
(per 8259A spec). It could be just about anything in your machine generating
these interrupts, and this is only a problem if it happens very often. There
were a discussion about this a while ago and the conclusion is that it
happens with just about every chipset.

>
> > First check out what kind of chipset you really have;
> > lspci -xs 0:0
> > should do the thing. Post the results.
>
> Kernel is 2.4.19pre5
>
> my result is:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> (rev 02)
> 00: 06 11 05 03 06 00 10 22 02 00 00 06 00 08 00 00
> 10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

You should have no problem with this chipset if it is the KT133 without
onboard graphics (99% chance).

>
> I hope you can do s.th. with that.

LOL! I mistakenly read your acronym as "sh*t".

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


