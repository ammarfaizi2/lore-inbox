Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbSKCXSh>; Sun, 3 Nov 2002 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKCXSh>; Sun, 3 Nov 2002 18:18:37 -0500
Received: from pasky.ji.cz ([62.44.12.54]:8441 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S263403AbSKCXSg>;
	Sun, 3 Nov 2002 18:18:36 -0500
Date: Mon, 4 Nov 2002 00:25:08 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Matt Pharr <matt@pharr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard not recognized with 2.5 kernels
Message-ID: <20021103232507.GE20338@pasky.ji.cz>
Mail-Followup-To: Matt Pharr <matt@pharr.org>, linux-kernel@vger.kernel.org
References: <m2lm4az1jj.fsf@dual.pharr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2lm4az1jj.fsf@dual.pharr.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Nov 04, 2002 at 12:17:04AM CET, I got a letter,
where Matt Pharr <matt@pharr.org> told me, that...
..snip..
> After 2.5 boots, my keyboard doesn't seem to be recognized (it's an
> old-style one plugged into the keyboard port, not a USB keyboard).
> Everything is fine up to the login: prompt, but then any key I hit doesn't
> cause anything to happen (including ctrl-alt-del).
..snip..
> I don't think I did anything dumb in the configuration step--I used my
> working 2.4.19 .config file, did a 'make oldconfig', and answered questions
> in conservative ways.  In particular, I do have CONFIG_INPUT_KEYBOARD set
> properly:
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_UINPUT is not set

Try to answer yes to the Serial i/o support (under Input device support) and
then enable support of the i8042 PC Keyboard controller.

Making the keyboard configuration under 2.5.x more obvious is currently in the
process of discussion.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
