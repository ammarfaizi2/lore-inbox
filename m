Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277074AbRJHTK6>; Mon, 8 Oct 2001 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277085AbRJHTKs>; Mon, 8 Oct 2001 15:10:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35083 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277074AbRJHTKl>; Mon, 8 Oct 2001 15:10:41 -0400
Date: Mon, 8 Oct 2001 15:48:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
In-Reply-To: <1814766007.1002542145@mbligh.des.sequent.com>
Message-ID: <Pine.LNX.4.21.0110081548020.4899-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Martin J. Bligh wrote:

> >> The worst possible case I can conceive (in the future architectures 
> >> that I know of)  is 4 different levels. I don't think the number of access
> >> speed levels is ever related to the number of processors ?
> >> (users of other NUMA architectures feel free to slap me at this point).
> > 
> > So you're saying that at most any given node is 4 hops away from any
> > other for your arch?
> 
> For the current architecture (well, for NUMA-Q) it's 0 or 1. For future
> architectures, there will be more (forgive me for deliberately not being 
> specific ... I'd have to ask for more blessing first). Up to about 4. Ish.
> 
> Depending on how much extra latency each hop introduces, it may well
> not be worth adding the complexity of differentiating beyond local vs
> remote? At least at first ...
> 
> Do you know how many hops SGI can get, and how much extra latency 
> you introduce? I know we're something like 10:1 ratio at the moment 
> between local and remote. 
> 
> I guess my main point was that the number of levels was more like constant 
> than linear. Maybe for large interconnected switched systems with small 
> switches, it's n log n, but in practice I think log n is small enough to be 
> considered constant (the number of levels of switches).
> 
> >> So I *think* the worst possible case is still linear (to number of nodes) 
> >> in terms of how many classzone type things we'd need? And the number 
> >> of classzone type things any given access would have to search through 
> >> for an access is constant? The number of zones searched would be
> >> (worst case) linear to number of nodes?
> > 
> > That's how we have our stuff coded at the moment, but with classzones you
> > might be able to get that down even further.  For instance, you could have
> > classzones that correspond to the number of hops a set of nodes is from a
> > given node. Having such classzones might make finding nearby memory easier.
> 
> That's what I was planning on ... we'd need m x n classzones, where m
> was the number of levels, and n the number of nodes. Each search would
> obviously be through m classzones. I'll go poke at the current code some more.

You say "numbers of levels" as in each level being a given number of nodes
on that "level" distance ? 

