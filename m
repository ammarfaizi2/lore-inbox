Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbTCNVvR>; Fri, 14 Mar 2003 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbTCNVvR>; Fri, 14 Mar 2003 16:51:17 -0500
Received: from zeke.inet.com ([199.171.211.198]:153 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S262632AbTCNVvP>;
	Fri, 14 Mar 2003 16:51:15 -0500
Message-ID: <3E725156.5000102@inet.com>
Date: Fri, 14 Mar 2003 16:01:58 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>	<3E723DBF.6040304@inet.com> <20030314125354.409ca02a.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Eli Carter <eli.carter@inet.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/
>>
>>[snip]
>>
>>>kgdb.patch
>>
>>I'm interested in this patch in your tree.
> 
> 
> You're brave.

Heh.  Insane might be more like it. ;)

> The kgdb patch is pretty nasty-looking code.  I've managed to keep it working
> for every kernel since 2.4.0-test10 while avoiding actually looking at it. 
> (I turn the monitor off when the patch needs fixing).  Fed it through Lindent
> once.
> 
> George Anzinger is maintaining another strain of the stub, and that mostly
> works OK and has improved features.  But the diff is larger and I once had a
> couple of problems with it and need to spend more time testing it.  It's up
> to date though.

If I can feed you changes to kgdb, would you be interested in taking 
them?  What was the last patch you shipped with George's version?  Which 
do you think would be the right place to start?


>>Would breaking the arch-independent parts out to linux/kernel/gdbstub.c 
>>be a reasonable change or is that a dumb question? ;)
> 
> 
> That would be a fantastic thing to do.  Note that there are already about ten
> kgdb stubs in the shipped kernel at present.  If you can identify exactly
> which functions need to be provided by the architecture, pull that out into
> struct kgdb_operations, etc then it would make maintenance and addition of
> new support much easier.

I guess I'll go hunting. :)

> We might even end up with something we could submit for inclusion without
> first having to set up an itwasntmenobodysawmedoit@yahoo.com account.

"We"... I like that word.  ;)  If you can act as 'upstream' for my 
changes and answer quick questions, I'll feed you patches.  Some testing 
of x86 would be wonderful too.  (And while I'm at it, can I send you my 
Christmas wishlist? ;) )  I have to warn you, I don't know how far I'll 
get.  But I'll give it a shot.  My current concern is getting it working 
under ARM, and there is a kgdb patch for 2.4 ARM I can draw from.

I'm thinking I'll try to wind up with 2 or 3 patches, kgdb.patch, 
kgdb-arm.patch, and kgdb-ia32.patch.  Maybe.

Are you feeling "brave"? 8)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

