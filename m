Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbREPThT>; Wed, 16 May 2001 15:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbREPThJ>; Wed, 16 May 2001 15:37:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14859 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261777AbREPThE>; Wed, 16 May 2001 15:37:04 -0400
Message-ID: <3B02D6AB.E381D317@transmeta.com>
Date: Wed, 16 May 2001 12:36:11 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg> <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Geert Uytterhoeven writes:
> > On Tue, 15 May 2001, Richard Gooch wrote:
> > > Alan Cox writes:
> > > > >         len = readlink ("/proc/self/3", buffer, buflen);
> > > > >         if (strcmp (buffer + len - 2, "cd") != 0) {
> > > > >                 fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > > >                 exit (1);
> > > >
> > > > And on my box cd is the cabbage dicer whoops
> > >
> > > Actually, no, because it's guaranteed that a trailing "/cd" is a
> > > CD-ROM. That's the standard.
> >
> > Then  check for `/cd' at the end instead of `cd' :-)
> 
> Argh! What I wrote in text is what I meant to say. The code didn't
> match. No wonder people seemed to be missing the point. So the line of
> code I actually meant was:
>         if (strcmp (buffer + len - 3, "/cd") != 0) {
> 

This is still a really bad idea.  You don't want to tie this kind of
things to the name.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
