Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSA2DYF>; Mon, 28 Jan 2002 22:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSA2DX4>; Mon, 28 Jan 2002 22:23:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26630 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286447AbSA2DXn>; Mon, 28 Jan 2002 22:23:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 03:23:11 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a354iv$ai9$1@penguin.transmeta.com>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain>
X-Trace: palladium.transmeta.com 1012274617 906 127.0.0.1 (29 Jan 2002 03:23:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Jan 2002 03:23:37 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201290137.g0T1bwB24120@karis.localdomain>,
Francesco Munda  <syylk@libero.it> wrote:
>
>I deeply agree with you, especially in keeping "many eyes" to look at the
>same kernel tree, and not chosing one of the many subtrees; as added bonus,
>this stuff is buzzword compliant! What we can ask more? :)

Some thinking, for one thing.

One "patch penguin" scales no better than I do. In fact, I will claim
that most of them scale a whole lot worse. 

The fact is, we've had "patch penguins" pretty much forever, and they
are called subsystem maintainers.  They maintain their own subsystem, ie
people like David Miller (networking), Kai Germaschewski (ISDN), Greg KH
(USB), Ben Collins (firewire), Al Viro (VFS), Andrew Morton (ext3), Ingo
Molnar (scheduler), Jeff Garzik (network drivers) etc etc. 

If there are problems with certain patches, it tends to be due to one or
more of:

 - the subsystem is badly modularized (quite common, originally. I don't
   think many people realize how _far_ Linux has come in the last five
   years wrt issues like architectures, driver independence, filesystem
   infrastructure etc). And it still happens.

 - lack of maintainer interest. Many "maintainers" are less interested
   in true merging than in trying to just push whatever code they have,
   and only ever grow their patches instead of keeping them in pieces.

   This is usually a matter of getting used to it, and the best people
   get used to it really quickly (Andrea, for example, used to not do
   this well at all, but look at how he does it now! From a merge
   standpoint, his patches have gone from "horrible" to "very good")

 - personality/communication issues. Yes, they happen. I've tried to
   have other people be "filters" for the people I cannot work with, but
   I have to say that most of the time when I can't work with somebody,
   others have real problems with those people too. 

   (An example of a very successful situation: David Miller and Alexey
   Kuznetsov: Alexey used to have these rather uncontrolled patches that
   I couldn't judge or work with but that obviously had a lot of
   potential, and David acting as a filter made them a very successful
   team.)

In short, if you have areas or patches that you feel have had problems,
ask yourself _why_ those areas have problems. 

A word of warning: good maintainers are hard to find.  Getting more of
them helps, but at some point it can actually be more useful to help the
_existing_ ones.  I've got about ten-twenty people I really trust, and
quite frankly, the way people work is hardcoded in our DNA.  Nobody
"really trusts" hundreds of people.  The way to make these things scale
out more is to increase the network of trust not by trying to push it on
me, but by making it more of a _network_, not a star-topology around me. 

In short: don't try to come up with a "patch penguin".  Instead try to
help existing maintainers, or maybe help grow new ones. THAT is the way
to scalability.

		Linus
