Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSAGOku>; Mon, 7 Jan 2002 09:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289225AbSAGOkl>; Mon, 7 Jan 2002 09:40:41 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:16784 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S289222AbSAGOkU>; Mon, 7 Jan 2002 09:40:20 -0500
Message-ID: <007b01c19789$50c695b0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <swsnyder@home.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz>
Subject: Re: "APIC error on CPUx" - what does this mean?
Date: Mon, 7 Jan 2002 15:40:55 +0100
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
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <swsnyder@home.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>; <alan@lxorguk.ukuu.org.uk>
Sent: Monday, January 07, 2002 2:16 PM
Subject: Re: "APIC error on CPUx" - what does this mean?


> On  8 Jan 02 at 2:08, Chris Wedgwood wrote:
> > On Mon, Jan 07, 2002 at 01:29:42PM +0100, Petr Vandrovec wrote:
> >
> >     They are spurious IRQ 7, just message is printed only once during
> >     kernel lifetime... I have about three spurious IRQ 7 per each 1000
> >     interrupts delivered to CPU. It is on A7V (Via KT133).
> >
> > Any idea _why_ these occur though?  It seems some mainboards produce a
> > plethora of these whilst others never produce these...
>
> Nope. Probably when CPU is in local APIC mode, it acknowledges interrupts
> to chipset with different timming, and from time to time CPU still
> sees IRQ pending, so it asks for vector, but as chipset has no
> interrupt pending, it answers with IRQ7. I did no analysis to find
> whether IRQ7 happens directly when we send confirmation to 8259,
> or whether it happens due to some noise on IRQ line.
>
> AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using
> APIC.

This (APIC errors) happened very often with my BP6 board too, but with
recent kernels I don't get many of these messages.

As for spurious interrupts, I had these coming every five minutes on my
Cyrix 6x86/SiS 5597 box. But this "settled" when I moved the box to another
corner in the room, and also did some interior adjustments of cables and
such (it is a server running in a very crammed slimline desktop box, with a
HUB taped to the floppy mount =)

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden



