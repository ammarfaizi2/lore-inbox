Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSAUJOG>; Mon, 21 Jan 2002 04:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289100AbSAUJN4>; Mon, 21 Jan 2002 04:13:56 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:25538 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289099AbSAUJNr>; Mon, 21 Jan 2002 04:13:47 -0500
Message-Id: <200201210913.g0L9Da64001779@tigger.cs.uni-dortmund.de>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering. 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Mon, 21 Jan 2002 00:49:27 +0300." <3C4B3B67.60505@namesys.com> 
Date: Mon, 21 Jan 2002 10:13:36 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Rik van Riel wrote:

[...]

>On basically any machine we'll have multiple memory zones.
> >
> >Each of those memory zones has its own free list and each
> >of the zones can get low on free pages independantly of the
> >other zones.
> >
> >This means that if the VM asks to get a particular page
> >freed, at the very minimum you need to make a page from the
> >same zone freeable.

> I'll discuss with Josh tomorrow how we might implement support for that. 
>   A clean and simple mechanism does not come to my mind immediately.

Free the page you were asked to free, optionally free anything else you
might want to. Anything else sounds like a gross violation of layering to
me.

The other way would be for the VM to say "Free at least <n> pages of this
<list>", but that gives a complicated API.
-- 
Horst von Brand			     http://counter.li.org # 22616
