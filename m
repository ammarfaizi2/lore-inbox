Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSA0XSf>; Sun, 27 Jan 2002 18:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSA0XSY>; Sun, 27 Jan 2002 18:18:24 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:55244 "EHLO fep2.cogeco.net")
	by vger.kernel.org with ESMTP id <S289057AbSA0XSU> convert rfc822-to-8bit;
	Sun, 27 Jan 2002 18:18:20 -0500
Subject: Re: VIA KT266 and SBLive! (emu10k1)
From: "Nix N. Nix" <nix@go-nix.ca>
To: Martin =?iso-8859-2?Q?Ma=E8ok?= <martin.macok@underground.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020127010324.K1409@sarah.kolej.mff.cuni.cz>
In-Reply-To: <1012086718.11336.91.camel@tux> 
	<20020127010324.K1409@sarah.kolej.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 27 Jan 2002 18:18:09 -0500
Message-Id: <1012173498.5048.5.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-26 at 19:03, Martin Maèok wrote:
> On Sat, Jan 26, 2002 at 06:11:53PM -0500, Nix N. Nix wrote:
> > I understand (not well enough, perhaps) that there are some known
> > problems with a combination of Via chipset and SBLive!.  Indeed, I have
> > experienced these myself, in that sometimes, when a sound is about to
> > play (as when I roll up my GNOME panel), the speakers first emit a burst
> > of noise (sounds like a can of pop opening) before playing the sound.
> 
> > problem somewhat by following someone's (from Via Arena) recommendation,
> > namely to move the DBLive! card to PCI slot 3.  The reason behind the
> > move, accordig to the group is to obtain a unique IRQ for the card. 
> 
> > Unfortunately, the problem still surfaces occasionally.  Can you please
> > advise me on what I can do to (hopefully) eliminate this problem ?
> 
> Wonder if this is related:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=53803
> 
> Try changing theese values
> -CONFIG_HIGHMEM4G=y
> +CONFIG_NOHIGHMEM=y
> 
> -CONFIG_SOUND_DMAP=y
> +# CONFIG_SOUND_DMAP is not set

I couldn't find the CONFIG_SOUND_DMAP setting in .config anywhere, so
the only changes I made were to comment out CONFIG_HIMEM and
CONFIG_HIMEM4G, and set CONFIG_NOHIMEM=y

This is vanilla 2.4.17 .



Is that enough ?  Is that what you meant (I'm not as fluent in diff as I
should be) ?

Thanks for the help.

> 
> I don't know why ... but it just helped me.
> 
> (and I think that some have also succeded with i686 kernel instead of
> athlon kernel)
> 
> -- 
>          Martin Maèok                 http://underground.cz/
>    martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


