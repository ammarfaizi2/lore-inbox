Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTBJWQt>; Mon, 10 Feb 2003 17:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBJWQt>; Mon, 10 Feb 2003 17:16:49 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:59010 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265369AbTBJWQr>;
	Mon, 10 Feb 2003 17:16:47 -0500
Date: Mon, 10 Feb 2003 23:26:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jakob Oestergaard <jakob@unthought.net>,
       Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030210222632.GD22275@dualathlon.random>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com> <20030204235112.GB17244@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204235112.GB17244@unthought.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 12:51:12AM +0100, Jakob Oestergaard wrote:
> On Tue, Feb 04, 2003 at 03:21:01PM -0800, Larry McVoy wrote:
> > > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > > make kernel changes to make it work with it.  
> > 
> > I can't offer any immediate help with this but I want the same thing.  At
> > some point, we're planning on funding some extensions into GCC or whatever
> > reasonable C compiler is around:
> 
> [snipping Linus from To:]
> 
> Cool.
> 
> > 
> >     - associative arrays as a builtin type
> > 
> >       {
> >       	  assoc	bar = {};	// anonymous, no file backing
> > 
> > 	  bar{"some key"} = "some value";
> > 	  if (defined(bar{"some other value"})) ...
> >       }
> 
> Allow me:
> 
> {
>  std::map<std::string,std::string> bar;
> 
>  bar["some key"] = "some value";
>  if (bar.find("some other value") != bar.end()) ...
> }

Indeed. Hardcoding map and multimap templates with string,string
parameter in the language sounds like a very worthless effort. If he
wants an high level syntax on top of the abstractions he should use a
more high level language. C can do everything but it's going to be a
sintax like what we do in the kernel, with lists, rbtrees, structures of
pointer to functions etc..

> Works beautifully, all you need is to pick the existing language which
> allows for the existing standard library which already provide that
> functionality.
> 
> I doubt there's much need for a C+ or C 2+/3 langauage variant  ;)
> 
> > 
> >     - regular expressions
> > 
> >       {
> >       	  char	*foo = "blech";
> > 
> > 	  if (foo =~ /regex are nice/) {
> > 	  	printf("Well isn't that special?\n");
> > 	  }
> >       }
> 
> Ok, I can't help you with that.
> 
> You have probably seen a Perl program before... Now imagine a two
> million line Perl program... That is why the above is not a good idea ;)

actually the python syntax for re is quite nice, and would be pretty
compatible with C, no magic perl =~ operator etc.. again a library like
STL in an highlevel language would do the trick just fine.

> 
> It's still your right to want it of course...
> 
> > 
> >     - tk bindings built in
> 
> Built into the language (not a library)?

Oh my.

> 
> <sarcasm>
> Then I'd want the compiler in a kernel module  ;)
> </>

then I want insmod kde.o too ;)

Andrea
