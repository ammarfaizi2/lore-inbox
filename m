Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSJ2ABd>; Mon, 28 Oct 2002 19:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSJ2ABd>; Mon, 28 Oct 2002 19:01:33 -0500
Received: from pc132.utati.net ([216.143.22.132]:128 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261393AbSJ2ABa> convert rfc822-to-8bit; Mon, 28 Oct 2002 19:01:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: 2.5.44: what's .tmp_export-objs for?
Date: Mon, 28 Oct 2002 14:07:44 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210281054.16008.landley@trommello.org> <87y98inphh.fsf@goat.bogus.local>
In-Reply-To: <87y98inphh.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210281307.44739.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 October 2002 16:54, Olaf Dietsche wrote:
> Rob Landley <landley@trommello.org> writes:
> > I accidentally did a 2.5.44 kernel build as root rather than my normal
> > user, so I'm trying to see what clean steps I need to so (as root) to be
> > able to build the tree again.  A normal make clean failed (permission
> > denied deleting files), so I did an su and a make clean.  Exit back to
> > normal user, make clean, life is good, do a make dep, and it complains
> > about the directory .tmp_export-objs.
> >
> > 1) Why does the build process use a hidden directory?
> >
> > 2) Why isn't make clean removing something with "tmp" in the name?
>
> "make help" lists a bunch of options. I guess, what you're searching
> for is "make mrproper" or even "make distclean".

Except that make mrproper deletes the .config file so I'd have to spend 
fifteen minutes with menuconfig again unless I know (and remember) to back it 
up. :)

I guess make clean is trying to avoid damaging the "make dep" output.  I 
thought that a big part of Keith Owens' new build system was to get rid of 
the horror that is "make dep", but I remember now that Linus rejected it for 
some reason.  Oh well.  Just curious...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
