Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSKCTkS>; Sun, 3 Nov 2002 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSKCTkS>; Sun, 3 Nov 2002 14:40:18 -0500
Received: from pasky.ji.cz ([62.44.12.54]:61429 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262414AbSKCTkR>;
	Sun, 3 Nov 2002 14:40:17 -0500
Date: Sun, 3 Nov 2002 20:46:47 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, mec@shout.net
Subject: Re: [kconfig] Survival of scripts/Menuconfig?
Message-ID: <20021103194647.GD2516@pasky.ji.cz>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org, mec@shout.net
References: <20021103111333.GA2516@pasky.ji.cz> <Pine.LNX.4.44.0211031803380.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031803380.6949-100000@serv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Nov 03, 2002 at 06:56:53PM CET, I got a letter,
where Roman Zippel <zippel@linux-m68k.org> told me, that...
> On Sun, 3 Nov 2002, Petr Baudis wrote:
> >   I'm asking because I want to move the relevant lxdialog functionality to
> > scripts/kconfig/mconf.c (I think it makes no sense to call lxdialog externally
> > from mconf.c) and get rid of the separate lxdialog tree. And scripts/Menuconfig
> > is the only other user of lxdialog.
> 
> What do you plan to do with it exactly?

After looking at it further, it turned out that the lxdialog code I want to
preserve is larger than expected, thus I will make it a library rather than
pumping all the stuff to mconf.c. Still huge advantage against having to call
the external binary everytime (also, we won't have that ugly flickering anymore
;-).

> In any case could you start with a copy of mconf.c? We are past feature 
> freeze now, so it makes little sense to remove lxdialog, but it could be 
> distributed separately together with the qt/gtk version.

Well, I think that it's not so good idea to have menuconfig distributed
separately, since it is probably the best thing you can get out of the text
mode, and there're really not much alternatives you could dream out. Having the
make config as the only way to configure the kernel is not a good thing, IMHO.

Also, as I said above, I decided to rather transform lxdialog to a library,
which is not so big change, IMHO.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
