Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJQOgS>; Thu, 17 Oct 2002 10:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJQOgS>; Thu, 17 Oct 2002 10:36:18 -0400
Received: from dsl-65-188-232-225.telocity.com ([65.188.232.225]:63700 "EHLO
	area51.underboost.net") by vger.kernel.org with ESMTP
	id <S261474AbSJQOgR>; Thu, 17 Oct 2002 10:36:17 -0400
Date: Wed, 16 Oct 2002 10:39:25 -0400 (AST)
From: dijital1 <dijital1@underboost.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.42+ reboot kills Dell Latitude keyboard
In-Reply-To: <m1n0pd17ad.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0210161036200.14665-100000@area51.underboost.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a controller difference between the Inspiron 4100 and your
latitude?

Ron Henry

"the illiterate of the future are not those who can neither read
or write; but those who cannot learn, unlearn, and relearn..."

On 17 Oct 2002, Eric W. Biederman wrote:

> Mikael Pettersson <mikpe@csd.uu.se> writes:
>
> > Eric W. Biederman writes:
> >  > Mikael Pettersson <mikpe@csd.uu.se> writes:
> >  >
> >  > > Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
> >  > > Shortly after the screen is blanked and the BIOS starts, it
> >  > > prints a "keyboard error" message and requests an F1 or F2
> >  > > response (continue or go into SETUP). Never happened with any
> >  > > other kernel on that machine.
> >  > >
> >  > > Apparently the 2.5.42+ "let's shut everything down at reboot"
> >  > > change
> >  >
> >  > There was no such change just a discussion of what the kernel
> >  > has been doing since 2.5.8 or so.
> >  >
> >  > > put the keyboard controller in a state which is inconsistent
> >  > > with the BIOS' expections at a warm boot.
> >  >
> >  > There is a bug in device_suspend.  device_shutdown, and device_suspend
> >  > where merged and the POWER_DOWN case now removes the drivers which
> >  > is a bug.  You may be getting hit with that.
> >  >
> >  > Eric Blade has posed a patch fixing that.
> >
> > I tried Eric Blade's patch
> > <http://marc.theaimsgroup.com/?l=linux-kernel&m=103477012517984&w=2>
> > but it didn't make any difference. Same keyboard error as before.
> >
> > So either the patch doesn't change what actions are taken on reboot,
>
> Correctly only what actions are taken before reboot, are changed.
>
> > or the keyboard (std SERIO_I8042 + ATKBD PC stuff) driver was also
> > broken in the 2.5.41->2.5.42 step.
>
> There is something in the ChangeLog about fixing the keyboard reboot
> case.  I don't see where the code changes in the patch but the
> keyboard code was touched quite a bit.
>
> So I suspect the keyboard driver also does the wrong thing for
> you in this case.
>
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

