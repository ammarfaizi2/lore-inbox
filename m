Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269107AbTCBDfh>; Sat, 1 Mar 2003 22:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269114AbTCBDfh>; Sat, 1 Mar 2003 22:35:37 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:54030 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S269107AbTCBDfg>; Sat, 1 Mar 2003 22:35:36 -0500
Date: Sat, 1 Mar 2003 19:45:56 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030302034556.GC30797@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> <3E612409.7090603@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E612409.7090603@kegel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 01:20:09PM -0800, Dan Kegel wrote:
> Steven Cole wrote:
> >Once you've loosed your beast upon the tree, I'd suggest that you
> >very carefully look through the resulting diff for inappropriate
> >corrections and redact the unnecessary hunks.  In the spelling fixes
> >which I sent to Linus, I redacted hunks which didn't need fixing.  For
> >example, Linus making fun of Sun folks' ability to spell, etc. and some
> >comments in French or German for which the spelling was correct in those
> >languages.
> 
> Good points.
> 
> >In addition to making fixes in the comments in the source, all of
> >Documentation should be fair game.
> 
> Yeah, but that's easy :-)
> 
> >Then you'll have to contend with the folks whose out-of-tree patches
> >you've borked.
> 
> That's a good argument for making the spellfix program polished
> enough that everyone can use it, I think.  Those maintaining
> out-of-tree patches can run the tool on their tree, and regenerate
> diffs.

An ispell filter seems a simpler approach to me. (ispell -F
filter) I use that (shown here to head off requests) for
email so quoted content is ignored.  A similar filter for C
source would make this trivial.


$ grep ispell .muttrc
set ispell="ispell -F maildequote"
$ cat bin/maildequote
#!/usr/bin/perl

while (<STDIN>)
{
        /^[>|] / || /^On .* wrote:$/ and tr[A-Za-z][_];
        print $_;
}
print "\004";


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
