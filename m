Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265089AbSKETfz>; Tue, 5 Nov 2002 14:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKETfz>; Tue, 5 Nov 2002 14:35:55 -0500
Received: from pasky.ji.cz ([62.44.12.54]:6901 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265089AbSKETfy>;
	Tue, 5 Nov 2002 14:35:54 -0500
Date: Tue, 5 Nov 2002 20:42:29 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjanv@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105194229.GS2502@pasky.ji.cz>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjanv@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk> <20021105181431.GB3515@suse.de> <20021105193004.GA2872@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105193004.GA2872@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Nov 05, 2002 at 08:30:04PM CET, I got a letter,
where Sam Ravnborg <sam@ravnborg.org> told me, that...
> On Tue, Nov 05, 2002 at 07:14:31PM +0100, Jens Axboe wrote:
> > I'll write the script, just a damn shame that this feature is gone now.
> > .config editing is less powerful now.
> The following patch should make most garbage, such as =n, result in
> # CONFIG_FOO is not set
> without any user confirmation.

I don't think this is actually a good idea. We break forward compatibility with
this (possibly, in future we will want to add something like "yes" or you don't
know what..), and then you will still get "no" for no obvious reason - asking
is much saner approach here, IMHO. If we didn't understand it, assuming 'no' is
not a safe way, I believe.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
