Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRLLV0U>; Wed, 12 Dec 2001 16:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282260AbRLLV0L>; Wed, 12 Dec 2001 16:26:11 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:38948 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282213AbRLLVZ4>; Wed, 12 Dec 2001 16:25:56 -0500
Date: Wed, 12 Dec 2001 22:25:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212222534.P4801@athlon.random>
In-Reply-To: <20011211144223.E4801@athlon.random> <E16DooZ-0001J4-00@starship.berlin> <20011212121624.B4801@athlon.random> <E16EFb9-0000E4-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16EFb9-0000E4-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Dec 12, 2001 at 09:03:20PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 09:03:20PM +0100, Daniel Phillips wrote:
> On December 12, 2001 12:16 pm, Andrea Arcangeli wrote:
> > On Tue, Dec 11, 2001 at 04:27:23PM +0100, Daniel Phillips wrote:
> > > On December 11, 2001 03:23 pm, Andrea Arcangeli wrote:
> > > > As said I wrote some documentation on the VM for my last speech at the
> > > > one of the most important italian linux events, it explains the basic
> > > > design. It should be published on their webside as soon as I find the
> > > > time to send them the slides. I can post a link once it will be online.
> > > 
> > > Why not also post the whole thing as an email, right here?
> > 
> > I uploaded it here:
> 
> ftp://ftp.suse.com//pub/people/andrea/talks/english/2001/pluto-dec-pub-0.tar.gz
> 
> This is really, really useful.
> 
> Helpful hint: to run the slideshow, get magicpoint (debian users: apt-get 
> install mgp) and do:
> 
>    mv pluto.mpg pluto.mgp # ;)

8)

>    mgp pluto.mgp -x vflib
> 
> Helpful hint #2: Actually, just gv pluto.ps is gets all the content.
> 
> Helpful hint #3: Actually, less pluto.mgp will do the trick (after the 
> rename) and lets you cut and paste the text, as I'm about to do...
> 
> Nit: "vm shrinking is not serialized with any other subsystem, it is also 
>                                                               only---^^^^
> threaded against itself."

correct.

> The big thing I see missing from this presentation is a discussion of how 
> icache, dcache etc fit into the picture, i.e., shrink_caches.

Going into the differences between icache/dcache and pagecache would
been too low level (and I should have spent some time explaining what
icache and dcache are first ;), so as you noticed I intentionally
ignored those highlevel vfs caches in the slides. The concept of "pages
of cache" is usually well known by most people instead, so I only
considered the pagecache, that incidentally is also the most interesting
case for the VM.  For seasoned kernel developers it would been
interesting to integrate more stuff, of course, but as you said this is
a start at least :).

About the icache/dcache shrinking, that's probably the most rough thing
we have in the vm at the moment. It just works.

Andrea
