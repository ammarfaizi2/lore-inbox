Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSJJOJ0>; Thu, 10 Oct 2002 10:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJJOJ0>; Thu, 10 Oct 2002 10:09:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64014 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261587AbSJJOJZ>;
	Thu, 10 Oct 2002 10:09:25 -0400
Message-ID: <3DA58B60.1010101@pobox.com>
Date: Thu, 10 Oct 2002 10:14:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Walter Landry <wlandry@ucsd.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
References: <20021009.163920.85414652.wlandry@ucsd.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Landry wrote:
> Jeff Garzik wrote:
> 
>>If you can't fit a whole tree including metadata into RAM, though,
>>BK crawls... Going from "bk citool" at the command line to actually
>>seeing the citool window approaches five minutes of runtime, on this
>>200MB laptop... [my dual athlon with 512MB RAM corroborates your
>>numbers, though] "bk -r co -Sq" takes a similar amount of time...
>>
>>I also find that BK brings out the worst in the 2.4 kernel
>>elevator/VM... mouse clicks in Mozilla take upwards of 10 seconds to
>>respond, when "bk -r co -Sq" is running on this laptop [any other
>>read-from-disk process behaves similarly]. And running any two BK
>>jobs at the same time is a huge mistake. Two "bk -r co -Sq" runs
>>easily take four or more times longer than a single run. Ditto for
>>consistency checks, or any other disk-intensive activity BK indulges
>>in.
> 
> 
> Hello,
> 
> What kind of CPU and hard drive do your two machines above have?  I'm
> a developer for arch[1], and I'm wondering how fast things can get.

The laptop has 200MB RAM, and mozilla and a ton of xterms loaded.  IDE 
drives w/ Intel PIIX4 controller.  The Dual Athlon has 512MB RAM, and I 
forget what kind of IDE controller -- I think AMD.  IDE drives as well.

BitKeeper must scan the entire tree when doing a checkin or checkout, so 
that is impossible to optimize at the SCM level without compromising 
features...  if your source tree takes up ~190MB on disk, you have 200MB 
of RAM total, and you need to sequentially scan the entire thing, there 
is nothing that can be done at either the OS or app level... You're just 
screwed.  Things are extremely fast on the Dual Athlon because the 
entire tree is in RAM.


> Note: If you answer, you'll certainly be aiding arch development.  It
>       might be interpreted as "develop[ing] ... a product which
>       contains substantially similar capabilities of the BitKeeper
>       Software, or, in the reasonable opinion of BitMover, competes
>       with the BitKeeper Software".  So you might lose the ability to
>       use the free license.  But I'll let you decide if you want to
>       help us.


Don't be silly:  I am more than willing to help, via answering 
questions.  If I had time I would help code.  I'm not religious about 
"only BitKeeper" to the exclusion of helping open source projects.  I 
simply use what is most expedient and productive for my kernel 
development workflow.

	Jeff



