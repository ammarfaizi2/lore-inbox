Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269164AbTCBIac>; Sun, 2 Mar 2003 03:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269165AbTCBIac>; Sun, 2 Mar 2003 03:30:32 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:58894 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S269164AbTCBIab>; Sun, 2 Mar 2003 03:30:31 -0500
Date: Sun, 2 Mar 2003 00:40:48 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030302084048.GD30797@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> <3E6167B1.6040206@kegel.com> <3E617428.3090207@kegel.com> <1046578585.2544.451.camel@spc1.mesatop.com> <3E61BF1B.7040706@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E61BF1B.7040706@kegel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 12:21:47AM -0800, Dan Kegel wrote:
> jw schultz <jw () pegasys ! ws> wrote:
> 
> >An ispell filter seems a simpler approach to me. (ispell -F
> >filter) I use that (shown here to head off requests) for
> >email so quoted content is ignored.  A similar filter for C
> >source would make this trivial.
> >
> >$ grep ispell .muttrc
> >set ispell="ispell -F maildequote"
> >$ cat bin/maildequote
> >#!/usr/bin/perl
> >
> >while (<STDIN>)
> >{
> >        /^[>|] / || /^On .* wrote:$/ and tr[A-Za-z][_];
> >        print $_;
> >}
> >print "\004";
> 
> Integrating in to existing spellcheckers is a Good Idea,
> though it might not totally replace the perl script Matthias
> wrote (does ispell have a batch mode that works on whole
> directory trees?).
> 
> BTW, ispell on my system is gnu aspell,
> and I couldn't tell for the life of me from the manual
> whether it supports this kind of filter.
> Nor could I find any doc on ispell filters.
> Where's the best place to learn about 'em?

The manpage was my only reference.  It was enough:

       The -F switch specifies an external  deformatter  program.
       This  program should read data from its standard input and
       write to its standard output.  The  program  must  produce
       exactly  one  character  of  output  for each character of
       input, or ispell will lose synchronization and corrupt the
       output  file.   Whitespace  characters (especially blanks,
       tabs, and newlines) and characters that should  be  spell-
       checked  should  be  passed through unchanged.  Characters
       that should not be spell-checked should be converted  into
       blanks or other non-word characters.  For example, an HTML
       deformatter might turn all HTML tags into blanks, and also
       blank  out  all  text  delimited by tags such as "code" or
       "kbd".

I don't know if aspell has filter support.  I'm running 
International Ispell Version 3.2.06 08/01/01
It came standard on SuSE.
http://fmg-www.cs.ucla.edu/geoff/ispell.html
It isn't GPL but the license terms are not unacceptable.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
