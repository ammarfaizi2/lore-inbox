Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157593AbQGaO6m>; Mon, 31 Jul 2000 10:58:42 -0400
Received: by vger.rutgers.edu id <S157355AbQGaO6F>; Mon, 31 Jul 2000 10:58:05 -0400
Received: from [195.71.101.13] ([195.71.101.13]:2139 "HELO lxMA.nowhere") by vger.rutgers.edu with SMTP id <S157686AbQGaO44>; Mon, 31 Jul 2000 10:56:56 -0400
Date: Mon, 31 Jul 2000 17:16:56 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731171656.K2224@lxMA.mediaways.net>
Reply-To: matthias.andree@gmx.de
Mail-Followup-To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org> <20000731165300.I2224@lxMA.mediaways.net> <39859644.340AE15E@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39859644.340AE15E@baldauf.org>; from xuan--reiserfs@baldauf.org on Mon, Jul 31, 2000 at 17:07:49 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

> But I never wanted it to be in sleep (rather than standby) mode, my
> original intent was to bring the system to a state where spin ups are
> only done when necessary. Someone said something about noflushd, but I
> could not find any links or rpm packages, does anybody have...?

yup. Freshmeat has:

http://freshmeat.net/appindex/1999/09/04/936483800.html

which links to the home page:

http://www.tuebingen.linux.de/~s-kod1/noflushd/

Note you cannot currently build the RPM as user since it has install -o
root somewhere in its Makefile. If you dare, rpm --rebuild as root,
else, fix the Makefile or wait for the update. I have contacted Daniel
Kobras about this (noflushd maintainer) and he agreed to use %defattr in
the RPM .spec in the next release rather than using -o/-g root on
$(INSTALL). Daniel is not an RPM expert, he's using Debian.

Also note I'm Bcc:'ing Daniel. It's not really blind cc: this way, but
this prevents him from being drawn into a possible continued discussion.
I see many people with improperly configured mailers or mailers without
mailing list support that have this tendency (of drawing people in).

Let's please take this off the list. I'm setting Reply-To:, but I'm not
sure if it makes it through the list software.

-- 
Matthias Andree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
