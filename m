Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318485AbSHENoa>; Mon, 5 Aug 2002 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318469AbSHENo3>; Mon, 5 Aug 2002 09:44:29 -0400
Received: from cibs9.sns.it ([192.167.206.29]:56847 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S318802AbSHENoH>;
	Mon, 5 Aug 2002 09:44:07 -0400
Date: Mon, 5 Aug 2002 15:47:26 +0200 (CEST)
From: venom@sns.it
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Munck Steenholdt <tmus@get2net.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: i810 sound broken...
In-Reply-To: <1028552057.18130.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still OSS modules for i810 does not work with 2.5 kernels, actually 2.4
is fine. No time to switch to alsa (and not interested for now too).



On 5 Aug 2002, Alan Cox wrote:

> Date: 05 Aug 2002 13:54:17 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Thomas Munck Steenholdt <tmus@get2net.dk>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: i810 sound broken...
>
> On Mon, 2002-08-05 at 12:27, Thomas Munck Steenholdt wrote:
> > I've noticed some writing on lkml on how i810(AC97) sound was broken.
> > Aparantly a couple of fixes have been posted, but I couldn't see
> > where(if at all) those patches have gone... 2.4.19 still does not work
> > and 2.4.19-ac3 won't even load the i810 module.
> >
> > Does anybody know if the known i810 sound issue has, in fact, been fixed, and if so - in what kernel/patch?
>
> Its working nicely for me in 2.4.19 and 2.4.19-ac1. The 2.4.19-ac3 tree
> has a bug in pci_enable_device which will stop it working if built with
> some compilers (by chance it works ok the way I tested it). Thats fixed
> in ac4.
>
> The changes in the recent i810 audio are
> - Being more pessimistic in our interpretation of codec power up
> - Turning on EAPD in case the BIOS didn't do so at boot up
>
> Longer term full EAPD control as we do with the cs46xx is on my list,
> paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
> power controller)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

