Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSJaSfd>; Thu, 31 Oct 2002 13:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbSJaSfd>; Thu, 31 Oct 2002 13:35:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60822 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265277AbSJaSfb>;
	Thu, 31 Oct 2002 13:35:31 -0500
Date: Thu, 31 Oct 2002 10:45:10 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Dave Craft <dcraft@austin.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <Pine.A41.4.44.0210311128060.21482-100000@craft.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0210311023270.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Dave Craft wrote:

> On Thu, 31 Oct 2002, Linus Torvalds wrote:
> 
> > What I'm saying by "vendor driven" is that it has no relevance for the
> > standard kernel, and since it has no relevance to that, then I have no
> > incentives to merge it. The crash dump is only useful with people who
> > actively look at the dumps, and I don't know _anybody_ outside of the
> > specialized vendors you mention who actually do that.
> 
>   Unfortunately the vast majority of the customers I deal with
>   buy a distribution and then put a kernel from kernel.org
>   on.  I believe this comes about because of either needing fixes
>   or function that appear in later kernels that have not made
>   it to the distributions kernels yet.
> 
>   Even if the distribution included LKCD in their kernel,
>   I lose lots of debug ability once customers switch over to
>   kernel.org and no longer have the LKCD patch.
> 
>   Thus we are currently left with having to maintain LKCD patches for
>   many arbitrary kernel.org kernels and convince customers to apply
>   it BEFORE they start encountering problems that we'll have to look at.
>   Application of patches that aren't automatically included in kernel.org
>   rarely happens with our customer set (before problems occur),
>   no matter how much we flag the issue to them up front.


So, this is precisely where something like OSDL's Carrier Grade and Data 
Center working groups can come into play, amazingly enough. 

By now, nearly everyone has heard about the working groups and nearly
every developer that has, despises them. Even I resist association with
them. But, they can have some real value to the vendors and the OEMs in 
exactly the way you describe. 

Take for example DCL. It's a kernel tree with several base patches 
intended to make Linux better in the data center. The base is not fancy, 
and includes things like LKCD and kdb (I think). It's actively maintained 
and updated more often than Linus makes a release (by virtue of 
bitkeeper).

The intent is to later have multiple child trees that implement features
for a specific application space (e.g. databases), while maintainig the
same base set of features. People wishing to use the most recent kernel 
with those features can use the DCL tree directly. Or an OEM FAE can use 
the tree to build something for the vendor, or add extra features.

Note that it's not a distribution. We don't even make real releases, since 
we don't create tarballs or patches (it's only in BK, which actually kinda 
sucks). It's merely a means to have these features actively maintained and 
kept in synch. 

And really, that's what everyone wants. Linus doesn't want the features,
as don't other developers, regardless of the Buzzword or Coolness factors.
Some vendors and users do want them. The developers of the features and
distributors of features don't want to deal with the tedium and pain of
updating patches each and every release.

In the end, it comes down to the fact that Linus's tree is Linus's tree. 
Other people can have their trees. I'm not going to tell you go off and 
make your own if you want those features so bad, because I know what a 
pain in the ass it is, and I know having someone else do it is a lot 
easier.

DCL and CGL have their trees, for purposes probably very very similar to 
what your customers need. I encourage you to check them out and work with 
them (or talk to people in your company that are). Try and make it work, 
and everyone can be happy (relativey). And, if DCL and CGL aren't 
satisfying the space that you need, please speak up to OSDL and the 
working groups. People are listening, and willing to take your suggestions 
into consideration. 

Relevant URLs:

http://osdl.org/projects/cgl/
http://osdl.org/projects/dcl/

	-pat "kissing serious butt" mochel

