Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283772AbRK3UPM>; Fri, 30 Nov 2001 15:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283775AbRK3UPC>; Fri, 30 Nov 2001 15:15:02 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:48264 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S283772AbRK3UOs>; Fri, 30 Nov 2001 15:14:48 -0500
Message-ID: <002501c179db$acff0f40$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Gunther Mayer" <Gunther.Mayer@t-online.de>, <root@chaos.analogic.com>
Cc: "Chris Meadors" <clubneon@hereintown.net>, <linux-kernel@vger.kernel.org>,
        <martin@jtrix.com>
In-Reply-To: <Pine.LNX.3.95.1011128084801.10732A-100000@chaos.analogic.com> <3C07DDC6.5FAE4E35@t-online.de>
Subject: Re: 'spurious 8259A interrupt: IRQ7' -> read the 8259 datasheet !
Date: Fri, 30 Nov 2001 21:14:54 +0100
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
From: "Gunther Mayer" <Gunther.Mayer@t-online.de>
To: <root@chaos.analogic.com>
Cc: "Chris Meadors" <clubneon@hereintown.net>; "Martin Eriksson"
<nitrax@giron.wox.org>; <linux-kernel@vger.kernel.org>; <martin@jtrix.com>
Sent: Friday, November 30, 2001 8:28 PM
Subject: Re: 'spurious 8259A interrupt: IRQ7' -> read the 8259 datasheet !


> "Richard B. Johnson" wrote:
> >
> > On Wed, 28 Nov 2001, Chris Meadors wrote:
> >
> > > On Wed, 28 Nov 2001, Martin Eriksson wrote:
>
> ...
> ... rumours deleted (e.g. "printer status bits are all ORed into irq7")
> ...
>
> >From "Harris Semiconductor 82C59A Interrupt Controller Datasheet":
>   If no interrupt request is present at step 4 of either sequence
>   (i.e., the request was too short in duration), the 82C59A will
>   issue an interrupt level 7.

Uhmm... call me slow, but I don't get it 100%... so this message has NOTHING
to do with the LPT IRQ7? It just signals this because IRQ7 is the lowest
priority IRQ on the 8259A?

>
> 1. The irq controller sees an interrupt.
> 2. The irq controller signals "there is _some_ interrupt" to the cpu.
> 3. The CPU acks via INTA
> 4. The irq controller looks if the irq is still there
>    (and signals IRQ7 if the line is no longer active).

Umm.. so again.. this means that the IRQ is not held long enough for the PIC
to actually recognize *what* IRQ was asserted?

>
> You have some device which doesn't keep the IRQ raised long enough !
> (or the CPU doesn't service the irq for a too long time and the
>  edge triggered irq is de-asserted or even serviced by a polling routine)

Thanks a bunch for clearing this up (this far)!!

When we get a firm indication on the 'problem', could the "spurious 8259A
interrupt" message be de-obfuscated into something less unsettling?

PS. Real Men (tm) never reads the datasheets!

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


