Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbQLNFeI>; Thu, 14 Dec 2000 00:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbQLNFd6>; Thu, 14 Dec 2000 00:33:58 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:35334 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S131555AbQLNFdz>;
	Thu, 14 Dec 2000 00:33:55 -0500
Date: Wed, 13 Dec 2000 23:04:08 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: CORBA vs 9P
In-Reply-To: <Pine.GSO.4.21.0012132348230.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132303190.25033-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that I addressed most if not all of this email in my previous
one... let me know if I missed something.

-Chris

btw, thanks for putting up with me, I know I can be obstinate
sometimes. :)  

On Wed, 13 Dec 2000, Alexander Viro wrote:

> 
> 
> On Wed, 13 Dec 2000, Chris Lattner wrote:
> 
> > > > Okay, so there are _stubs_ for these platforms.  How many languages are
> > > > there bindings for?
> > > Grr... Let's define the terms, OK? What is available: kernel code that
> > > represents the client side of RPC as a filesystem. Userland clients do
> > > not know (or care) about the mechanisms involved.
> > 
> > But they DO CARE about the format of the data.
> 
> And how would CORBA help here? Because format changes are usually coming
> from the _contents_ changes. And if you don't care about the contents -
> why the hell do you retrieve the object int the first place?
> 
> > > 	And files with structure are things of dreadful past. BTDT.
> > > You really need to... work with an OS that would have and enforce
> > > "structured files" <spit> to appreciate the beauty of ASCII streams.
> > 
> > Ahhh, so ASCII streams are a wonderful thing.  Are you an XML fan?  :)
> 
> No, thanks.
> 
> > > 	However, that's a different story. What I _really_ don't understand
> > > is the need to export anything structured from kernel to userland.
> > 
> > Okay, how about a few examples.  How about /proc/meminfo?  How about the
> > "stat" structure?  How about /proc/stat?  You seem to be indicating that
> > ASCII files are fine for general exportation of kernel information.  The
> 
> Yes, _if_ you take care to think what you are exporting. /proc/meminfo is
> a shi..ning example of _not_ doing that over many years.
> 
> > /proc filesystem begs to differ.  One specific example is the
> > /proc/meminfo file.  Why is it that one field is 0 now?  Ouch we can't
> > change the format of the file because we'll break some program.  Crap, you
> > want to add a field, well, tough luck.
> 
> Oh, cool. So CORBA would magically change the definition of the structure in
> your (C/Modula-3/APL/COBOL) programs. How? And what would happen with the
> code that used to access the field in question?
> 
> > The struct stat example is one _trivial_ example of "the need to export
> > anything structured from kernel to userland".
> 
> It's a trivial example of "why you need to think before deciding what to
> export".
>  
> > > 	IOW, I would really like to see a description of use of your
> > > mechanism. If it's something along the lines of "let's take a network
> > > card driver, implement it in userland and preserve the current API" -
> > > see the comment about layering violations. You've taken an internal
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > API and exposed it to userland in all gory details. See also your own
> > > comment about internal APIs being not convenient for such operations.
> > 
> > I'm not trying to dictate interfaces.  I'm not trying to tell people what
> > to use this stuff for.  I'm arguing that it's useful and that you can do
> > very interesting things with it.
> 
> And when interface changes, you do what, exactly?
> 
> > > If it's something else - I wonder what kind of objects you are talking
> > > about and why opaque stuff (== file descriptors) would not be sufficient.
> > 
> > Opaque stuff is fine.  I have no problem with file descriptors.  They
> > effectively solve the exact same class of problems that CORBA does, except
> > that they add significant _API BLOAT_ because every little "method" that
> > implements them gets a syscall.
> 
> Huh? Could you elaborate, please?
> 
> 

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
