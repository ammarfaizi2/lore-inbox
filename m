Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVADOuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVADOuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVADOuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:50:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261663AbVADOuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:50:14 -0500
Date: Tue, 4 Jan 2005 15:50:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, vojtech@ucw.cz
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104145011.GB3097@stusta.de>
References: <20041227142821.GA5309@ucw.cz> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org> <200501040114.26499.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501040114.26499.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:14:26AM -0500, Dmitry Torokhov wrote:
> On Tuesday 04 January 2005 12:54 am, Linus Torvalds wrote:
> > 
> > I pulled and immediately unpulled again.
> > 
> > Vojtech, stuff like this is unacceptable:
> > 
> > 	PS/2 driver library (SERIO_LIBPS2) [N/m/y/?] (NEW) ?
> > 
> > 	Say Y here if you are using a driver for device connected
> > 	to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
> > 
> > Stop messing with peoples minds. The default config should contain
> > keyboard and mouse support, and unless the user asks for "Embedded" or the
> > year 2010 comes along and you can't find computers with non-USB keyboards
> > anyway, that's how it's going to remain.
> > 
> > We had this _idiocy_ early in 2.5.x, and it caused untold silly problems. 
> > We fixed it. We're not going to re-do that mistake.
> 
> When I do "make oldconfig" it silently sets SERIO_LIBPS2 to Y if I have
> either atkbd or psmouse built-in and if both of them are modules it gives
> option [M/y]. Do you have atkbd or psmouse selected?
>...

As far as I can see, you are correct, and unless you are on !X86 or have 
EMBEDDED enabled SERIO_LIBPS2 is always forced to yes.

But although it doesn't seem to be a problem, I'm wondering why 
SERIO_LIBPS2 is a user-visible option?

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

