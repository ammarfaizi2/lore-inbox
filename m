Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRANJny>; Sun, 14 Jan 2001 04:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131329AbRANJnp>; Sun, 14 Jan 2001 04:43:45 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:5894 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131231AbRANJnh>; Sun, 14 Jan 2001 04:43:37 -0500
Date: Sun, 14 Jan 2001 09:43:21 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: <11983.979431680@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0101140922430.4887-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Keith Owens wrote:

> This is becoming more important as the kernel moves towards hot
> plugging devices, especially for binary only drivers.  It is far better
> for the kernel community if modutils can say "cannot load module foo
> because its interfaces do not match the kernel, upgrade module foo".
> That forces the maintenance load back onto the binary supplier and
> removes the questions from l-k, including many of the oops reports with
> binary only drivers in the module list.

No. The correct response to that is _already_ "You have a binary-only
module. Even in the kernel it was compiled against, you are not supported.
Goodbye".

To quote our Lord and Master:

(http://lwn.net/1999/0211/a/lt-afs.html)
>> I will strive for binary compatibility for modules, but I _expect_
>> that it will be broken.  It's just too easy to have to make changes
>> that break binary-only modules, and I have too little incentive to try
>> to avoid it.
>>
>> If people feel this is a problem, I see a few alternatives:
>>  - don't use stuff with binary-only modules. Just say no.
>>  - work hard at making a source-version of the thing available (it
>>    doesn't have to be under the GPL if it's a module, but it has to be
>>    available as source so that it can be recompiled).
>>  - don't upgrade
>>  - drop Linux

(http://lwn.net/1999/0211/a/lt-binary.html)
>> Basically, I want people to know that when they use binary-only
>> modules, it's THEIR problem.  I want people to know that in their
>> bones, and I want it shouted out from the rooftops.  I want people to
>> wake up in a cold sweat every once in a while if they use binary-only
>> modules.


kaos@ocs.com.au wrote:
> Ignore the fact that the existing module symbol version implementation
> is broken as designed.  http://gear.torque.net/kbuild/archive/1280.html
> lists the major problems with make dep, genksyms has all those problems
> plus several of its own.  As part of the Makefile rewrite for 2.5, I am
> redesigning module symbol versions from scratch.
>
> I agree that inter_module_xxx does not check ABI.  That was not for
> lack of trying, but it cannot be done in 2.4, it needs a major redesign
> of module symbols and the makefiles.  It will be possible in 2.5.

This is a good thing, as long as it doesn't get in the way of real
functionality. We don't _need_ to make life easier for people running
binary-only modules. But if we can do it without making life harder for
real people, then that's nice.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
