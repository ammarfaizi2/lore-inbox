Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSHAVrt>; Thu, 1 Aug 2002 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHAVrt>; Thu, 1 Aug 2002 17:47:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44557 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315870AbSHAVrs>; Thu, 1 Aug 2002 17:47:48 -0400
Message-ID: <3D49AC0E.9070804@evision.ag>
Date: Thu, 01 Aug 2002 23:45:50 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: martin@dalecki.de, Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0208011709390.12627-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> Newsflash: for Homsky-3 grammar "reg exp guessing" _IS_ complete parser
> in the formal sense.

Unsually only unless you compre it with your *intentions*.
Please don't confuse definition of grammar with parser implementation
despite that fact the reg-exp stuff is looking like declarative
programming. Whot it does is *not* always equivalent to what it should.
OK?

>>>is tough".  Examples on demand, including real gems like
>>>	fread(&foo, sizeof(foo), 1, fp);
>>>	if (foo.x >= 100000 || foo.y >= 100000)
>>>		/* fail and exit */
>>>	p = (char *)malloc(foo.x * foo.y);
>>>	if (!p)
>>>		/* fail and exit */
>>>	for (i = 0; i < foo.x; i++)
>>>		fread(p + i*foo.y. 1, foo.y, fp);
>>>and similar wonders (if anybody wonders what's wrong with the code above,
>>>you need to learn how multiplication is defined on int and compare 10^10 with
>>>2^32).  And yes, it's real-life code, from often-used programs.  Used on
>>>untrusted data, at that.
>>
>>Storing the constants in question in the above code sample
>>as ASCII at the start of where foo is pointing at, would have hardly
>>saved the poor overworked programmers mind from precisely the same
>>mistake he did above. (Needless to say that you actually forgott
>>to mention that the code fails on <= 32 bit systems. Inestad of 
>>providing te "hint" for guessing where the actual error is.)
> 
> 
> Huh???
> 
> you: "it's easy to screw up when working with ASCII strings"
> me: "tossers will find a way to screw up on anything, no matter what it is;
>      see example of tosser screwing up on plain arithmetics"
> you: "use of ASCII wouldn't help them in that case"
> 

Scratch the above: I tell you: "Not unsing ASCII is greatly
diminishing the propability of the occurrance of the error."
And error rate depends on the size of code. No matter how
perfect you think someone has to be as a coder.
  No code - no errors. The same buggy code twice - twice the same errors.

> Sure thing, it wouldn't.  _Nothing_ short of acquiring some clue would.
> Possible solutions:
> 	A) replace all arithmetics with BIGNUMs (and just you wait for
> first out-of-memory)
> 	B) get rid of tossers.
> 
> Matter of taste, indeed, but I'd rather go for (B) - has a benefit of
> solving many other problems.

No. The vomitting only moves to the time where you actually get your ass 
up from the kernel and take a look at the code trying to use it. And 
then it's more painfull. Go libproc or its relatives please. I don't
blaim Albert for it! I blaim the interface.
I don't try to tell you that binary interfaces are the best thing
since slice bread. They are just less worse for the *actual* user.

That's the point.

