Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTBDXlk>; Tue, 4 Feb 2003 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTBDXlk>; Tue, 4 Feb 2003 18:41:40 -0500
Received: from unthought.net ([212.97.129.24]:59067 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S267575AbTBDXlj>;
	Tue, 4 Feb 2003 18:41:39 -0500
Date: Wed, 5 Feb 2003 00:51:12 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204235112.GB17244@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030204232101.GA9034@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 03:21:01PM -0800, Larry McVoy wrote:
> > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > make kernel changes to make it work with it.  
> 
> I can't offer any immediate help with this but I want the same thing.  At
> some point, we're planning on funding some extensions into GCC or whatever
> reasonable C compiler is around:

[snipping Linus from To:]

Cool.

> 
>     - associative arrays as a builtin type
> 
>       {
>       	  assoc	bar = {};	// anonymous, no file backing
> 
> 	  bar{"some key"} = "some value";
> 	  if (defined(bar{"some other value"})) ...
>       }

Allow me:

{
 std::map<std::string,std::string> bar;

 bar["some key"] = "some value";
 if (bar.find("some other value") != bar.end()) ...
}

Works beautifully, all you need is to pick the existing language which
allows for the existing standard library which already provide that
functionality.

I doubt there's much need for a C+ or C 2+/3 langauage variant  ;)

> 
>     - regular expressions
> 
>       {
>       	  char	*foo = "blech";
> 
> 	  if (foo =~ /regex are nice/) {
> 	  	printf("Well isn't that special?\n");
> 	  }
>       }

Ok, I can't help you with that.

You have probably seen a Perl program before... Now imagine a two
million line Perl program... That is why the above is not a good idea ;)

It's still your right to want it of course...

> 
>     - tk bindings built in

Built into the language (not a library)?

<sarcasm>
Then I'd want the compiler in a kernel module  ;)
</>

> and then we'll port BK to that compiler.  It's likely to be GCC because we
> want to support all the different architectures but if a kernel sponsered
> cc shows up we'll happily throw money at that.

If you look at http://www.codesourcery.com, you can see that there
really are some people who do GCC extentions or optimizations for money
- various institutions have funded additions to GCC this way.

It's a cool idea - I have a few things I'd like my company to fund as
well... Some time in the future...  Unless someone beats us to it.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
