Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSKJSav>; Sun, 10 Nov 2002 13:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSKJSav>; Sun, 10 Nov 2002 13:30:51 -0500
Received: from [195.39.17.254] ([195.39.17.254]:17924 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265039AbSKJSau>;
	Sun, 10 Nov 2002 13:30:50 -0500
Date: Sun, 10 Nov 2002 19:35:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Werner Almesberger <wa@almesberger.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021110183526.GA2855@elf.ucw.cz>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net> <20021105171230.A11443@in.ibm.com> <20021105150048.H1408@almesberger.net> <1036521360.5012.116.camel@irongate.swansea.linux.org.uk> <20021105161902.I1408@almesberger.net> <1036542104.2749.197.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036542104.2749.197.camel@andyp>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Let me ask the same dumb question - what does kexec need that a dumper
> > > doesn't.
> > 
> > kexec needs:
> >  - a system call to set it up
> >  - a way to silence devices <snip>
> <snip>
> >  - a bit of glue <snip>
> >  - device drivers that can bring silent devices back to life
> <snip>
> 
> > > In other words given reboot/trap hooks can kexec happily live
> > > as a standalone module ?
> 
> You could probably skip the system call to set it up.  Example: I could
> imagine a bizarre set of pseudo-devices:
> 
> 	# insmod kexec
> 	# cat bzImage > /proc/kexec/next-image
> 	# echo "root=805" > /proc/kexec/next-cmndline
> 	# echo 1 > /proc/kexec/reboot
> 
> and hide away that dirty little sequence with a nice kexec(3) library
> routine.

Actually, sys_reboot has void * parameter. Reusing it as "next-image"
char * seems okay to me.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
