Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269144AbTCBIBA>; Sun, 2 Mar 2003 03:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbTCBIBA>; Sun, 2 Mar 2003 03:01:00 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:25301 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S269144AbTCBIA6>; Sun, 2 Mar 2003 03:00:58 -0500
Message-ID: <3E61BF1B.7040706@kegel.com>
Date: Sun, 02 Mar 2003 00:21:47 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>	<3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com> <1046578585.2544.451.camel@spc1.mesatop.com>
In-Reply-To: <1046578585.2544.451.camel@spc1.mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz <jw () pegasys ! ws> wrote:

> An ispell filter seems a simpler approach to me. (ispell -F
> filter) I use that (shown here to head off requests) for
> email so quoted content is ignored.  A similar filter for C
> source would make this trivial.
> 
> $ grep ispell .muttrc
> set ispell="ispell -F maildequote"
> $ cat bin/maildequote
> #!/usr/bin/perl
> 
> while (<STDIN>)
> {
>         /^[>|] / || /^On .* wrote:$/ and tr[A-Za-z][_];
>         print $_;
> }
> print "\004";

Integrating in to existing spellcheckers is a Good Idea,
though it might not totally replace the perl script Matthias
wrote (does ispell have a batch mode that works on whole
directory trees?).

BTW, ispell on my system is gnu aspell,
and I couldn't tell for the life of me from the manual
whether it supports this kind of filter.
Nor could I find any doc on ispell filters.
Where's the best place to learn about 'em?
- Dan



-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

