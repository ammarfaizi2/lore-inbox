Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRDORn6>; Sun, 15 Apr 2001 13:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132742AbRDORnt>; Sun, 15 Apr 2001 13:43:49 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:52495 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S132674AbRDORng>; Sun, 15 Apr 2001 13:43:36 -0400
Message-ID: <3AD9DDAF.5E76F797@supelec.fr>
Date: Sun, 15 Apr 2001 19:43:11 +0200
From: Francois Cami <francois.cami@supelec.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Matthew W. Lowe" <swds.mlowe@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <3ADAC95A.6B35B8DE@home.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi Matthew and everyone

I use a 3COM Etherlink III ISA and a 3C905C PCI in my firewall
box (i440BX mobo). (distro is slackware 7.1, kernels are either
2.2.19 or 2.4.3, modutils 2.3.1 (slackware 7.1 default) ).

The 3C905C was never a problem (and i guess your R8029 isn't either), 
however to make the 3C509 ISA work, I had to disable PnP in the 
card's firmware, with 3COM tools : see

http://www.3com.com/products/html/prodlist.html?family=570&cat=20&pathtype=download&tab=cat&selcat=Network%20Interface%20Cards%20%26%20Adapters

to download the DOS tools to configure your card without PnP, i.e.
manually
assigning an IRQ and address to it.

You'll have to declare to your BIOS that this particular IRQ is taken
by a non-PNP ISA card too.

Now it works well, whether i use a separate module or build the
module into the kernel.

I hope that helps.

François CAMI (new to the list)
francois.cami@supelec.fr


"Matthew W. Lowe" wrote:
> 
> Hey, Thanks for all the help everyone. So far this is my exact
> configuration:
> Two NICs, 3COM Etherlink III ISA, Realtek 8029 PCI (Covered by the
> NE2000 PCI module). Both cards are setup for PnP, the modules have been
> built into the kernel. (It worked in my old version with them build into
> the kernel.)
> 
> I have upgraded to the latest modutils, and it appeared to fix the
> problem with the 3COM Etherlink III card.
> 
> Alan Cox:
> You mentioned turning PnP off if I was building the modules into the
> kernel? Is there something in the later versions of the kernel that is
> setup like that, or ?? (** didn't quite understand what you meant **)
> 
> Thanks,
>    Matt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
