Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbRE2A2O>; Mon, 28 May 2001 20:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbRE2A2F>; Mon, 28 May 2001 20:28:05 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:9226 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261855AbRE2A1y>;
	Mon, 28 May 2001 20:27:54 -0400
Message-Id: <200105280126.f4S1QmFM017170@sleipnir.valparaiso.cl>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Edgar Toernig <froese@gmx.de>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup) 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Sun, 27 May 2001 22:45:17 +0200." <01052722451714.06233@starship> 
Date: Sun, 27 May 2001 21:26:48 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On Sunday 27 May 2001 15:32, Edgar Toernig wrote:

[...]

> > you break UNIX fundamentals.  But I'm quite relieved now because I'm
> > pretty sure that something like that will never go into the kernel.

> OK, I'll take that as "I couldn't find a piece of code that breaks, so 
> it's on to the legal issues".

It boggles my (perhaps underdeveloped) mind to have things that are files
_and_ directories at the same time. The last time this was discussed was
for handling forks (a la Mac et al) in files, and it was shot down.

> SUS doesn't seem to have a lot to say about this.  The nearest thing to 
> a ruling I found was "The special filename dot refers to the directory 
> specified by its predecessor".  Which is not the same thing as:
> 
>    open("foo", O_RDONLY) == open ("foo/.", O_RDONLY)

It says "foo" and "foo/." are the same _directory_, where "foo" is a
directory as otherwise "foo/<something>" makes no sense, AFAICS. Is there
any mention on a _file_ "bar" and going "bar/" or "bar/<something>"?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
