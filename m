Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314544AbSEBOfa>; Thu, 2 May 2002 10:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSEBOf3>; Thu, 2 May 2002 10:35:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25869 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314544AbSEBOf1>; Thu, 2 May 2002 10:35:27 -0400
Message-ID: <3CD13FF3.5020406@evision-ventures.com>
Date: Thu, 02 May 2002 15:32:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173HX6-00041D-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>>change configs, rebuild without make mrproper).  To do modversions
>>>right needs a new version of modutils as well, there is no chance of
>>>that work being started until kbuild 2.5 is in the kernel.
>>
>>How many years was it that I was telling that symbol versioning is
>>a silly concept not solving any single problem and the implementation is to say
>>the least ugly?
> 
> 
> Modversions solves a huge number of problems very very well. The fact that
> you don't like it doesn't change the reality of the situation.

Could you name *ONE* please? Maybe the following?

- It's solving the problem of applying quick security
fixes to vendor specific kern src.rpm packeges for the user
very well.

- It solves the problem of too fast kernel compiles as well fine.

- As an added bonus it makes you use
the force flag to insmod more often with binary only modules, which
everybody loves... This gives you the good feeling of polite
questions you have been missing from DOS for so long:
"Do you really wan't to delete this file Y/N"...

- And then we have no better use for our RAM then
storing some extendid redundant string information there of course
as well.

- And of course it is not annoying if you want to move
modules which you have just compiled yourself between
two machines. Or perhaps a compilation host and some testing systems.

Far better sollution then just versioning the kernel release
and expecting people to actually know what they do.
They are finally all loosers, becouse they use a system they
can mess with.

It is far better then providing clean submodule interfaces as well.
And finally it's of course a better sollution then versioning
with the granularity of a whole module, which we just don't
have right now. It would be ridiculous to have some
modules to provide the ABI version information they expose just
to let the clients check it explicitely in far too few bytes like
about 1 or maybe 2. The analogy with shared libraries would be far
too big - becouse of it course turned out there to be not sufficient and
the X11 people didn't show us what true compatibility means and the
glibc people don't know what real man programming is.

What are weak symbols for? Ah yes - we have to hold up the
a.out tradition in it's full glory!

Did I mention that the C++ solution to linker deficiencies is
inferior to module versioning of course as well, becouse
catching the type signature is not what we wan't.

Yes - versioning of every single piece is indeed a very good
solution to the above problems and a nice piece of SW design!

