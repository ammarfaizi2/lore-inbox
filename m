Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSKCTbF>; Sun, 3 Nov 2002 14:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSKCTbF>; Sun, 3 Nov 2002 14:31:05 -0500
Received: from pasky.ji.cz ([62.44.12.54]:49909 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262373AbSKCTbD>;
	Sun, 3 Nov 2002 14:31:03 -0500
Date: Sun, 3 Nov 2002 20:37:34 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103193734.GC2516@pasky.ji.cz>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
	linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103200704.A8377@ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Nov 03, 2002 at 08:07:05PM CET, I got a letter,
where Vojtech Pavlik <vojtech@suse.cz> told me, that...
> On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:
> > Jos Hulzink wrote:
> > 
> > >It took me about an hour to find out why my keyboard didn't work in 2.5.45. 
> > >Well... after all it seemed that I need to enable 4 ! options inside the 
> > >input configuration, just to get my default, nothing special PS/2 keyboard up 
> > >and running. Oh, and I didn't even have my not so fancy boring default PS/2 
> > >mouse configured then. Guys, being able to configure everything is nice, but 
> > >with the 2.5 kernel, things are definitely getting out of control IMHO.
> > >  
> > >
> > 
> > This is potentially becoming a FAQ...  I ran into this too, as did 
> > several people in the office.  People who compile custom kernels seem to 
> > run into this when they first jump into 2.5.x.  AT Keyboard support is 
> > definitely buried :/
> > 
> > Unfortunately I don't have any concrete suggestions for Vojtech (input 
> > subsystem maintainer), just a request that it becomes easier and more 
> > obvious how to configure the keyboard and mouse that is found on > 90% 
> > of all Linux users computers [IMO]...
> 
> Too bad you don't have any suggestions. I completely agree this should
> be simplified, while I wouldn't be happy to lose the possibility of not
> compiling AT keyboard support in.

Well, why can't it be enabled by default? Other options are as well, and it's
IMHO sane to enable keyboard and mice support by default. It should clear up
the initial confusion as well.

I think that these options should be enabled by default:

[Userland interfaces]
	Mouse interface
		Legacy /dev/psaux (?)
			(I suggest to make this non-default in 2.7, but maybe
			 we want shorter transition period?)

[Input I/O drivers]
	Serial i/o support
		i8042
		Serial port line discipline

[Input device drivers]
	Keyboards
		AT keyboard support
	Mice
		Serial mouse (?)
			(..or maybe not, this is really not so common as PS/2
			 lately)
		PS/2 mouse

I think that those are absolute minimum and if anyone will want to have any of
these explicitly off, he's more likely to know where to turn it off, rather
than vice versa.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
