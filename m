Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSH1TKZ>; Wed, 28 Aug 2002 15:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSH1TKZ>; Wed, 28 Aug 2002 15:10:25 -0400
Received: from quechua.inka.de ([212.227.14.2]:11862 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S318349AbSH1TKY>;
	Wed, 28 Aug 2002 15:10:24 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
In-Reply-To: <20020827160722.GA13412@alcove.wittsend.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17k8H8-0003Le-00@sites.inka.de>
Date: Wed, 28 Aug 2002 21:14:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020827160722.GA13412@alcove.wittsend.com> you wrote:
>        It's ignoring something because it's assuming the user knows
> what he's doing and not wanting it to do that?  Does not compute.  

well, it was not my idea, and i dont think I fully understand all that Scope
stuff in IPv6, but I wanted to say:

The kernel is asuming, that a gateway (ie forward=1) is administrated by a
experienced admin, who knows how to set up all those special V6 prefixes,
but wants to defend internet from admins who do not know.

for a single hoomed host a default route does no harm, compared to a gateway
with wrong site or lionk local scope prefix routes.

> Did you mean 2000::/3 (first two bits zero, next bit 1)?  That would
> also cover both the 6bone and production allocations under a slightly
> tighter mask.  The /2 would cover :: through 3fff: but the /3
> would cover 2000: through 3fff:.  Any reaon why we should care about
> the ::/3 band (:: through 1fff:)?

yes, because it does not maks the link and site local prefix starting with
FE and FF (like fe80::/10)

>        Does that imply ipv6 only or does that include ipv4 on those
> tcp6 listens? 

well, depends on the kernel we are talking about. I plan to have tcp,tcp46
and tcp6 (of course udp and icmp, too) entries, like BSD has.

>        I'm not sure I like the tcp6, since it's not tcp that's
> changed, just the ip layer underneath it.  I assume you would also
> have udp6 as well?

yes

>        Hmmm...  Just be careful not to break too many scripts.  Freenet6
> has a template script with their tsp package that, I think, tries to do
> some parsing on that stuff.  That script is also broken due to the
> default route sillyness, and I'm going to let them know to change their
> route add from ::/0 to a route add for something between ::/1 and 2000::/3
> (season to taste) to get the default routes working properly.

tspc works fine for me, but you are right breaking scripts is a bit ugly.
Well on the other hand, it wil lalso unbreak some bsd scripts :)

Greetings
Bernd
