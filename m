Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbTAJSYc>; Fri, 10 Jan 2003 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbTAJSYc>; Fri, 10 Jan 2003 13:24:32 -0500
Received: from [193.158.237.250] ([193.158.237.250]:45191 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265628AbTAJSYa>; Fri, 10 Jan 2003 13:24:30 -0500
Date: Fri, 10 Jan 2003 19:33:11 +0100
Message-Id: <200301101833.h0AIXBl02976@mail.intergenia.de>
To: <3E1E410E.5050905@emageon.com>
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IMHO multiprogramming is as valid a use for memory as any other. Or
>> even otherwise, it's not something I care to get in design debates
>> about, it's just how the things are used.

On Thu, Jan 09, 2003 at 09:42:06PM -0600, Brian Tinsley wrote:
> I agree with the philosophy in general, but if I sit down to write a 
> threaded application for Linux on IA-32 and wind up with a design that 
> uses 800+ threads in any instance (other than a bug, which was our 
> case), it's time to give up the day job and start riding on the back of 
> the garbage truck ;)

I could care less what userspace does: mechanism, not policy. Userspace
wants, and I give if I can, just as the kernel does with system calls.

800 threads isn't even a high thread count anyway, the 2.5.x testing
was with a peak thread count of 100,000. 800 threads, even with an 8KB
stack, is no more than 6.4MB of lowmem for stacks and so shouldn't
stress the system unless many instances of it are run. I suspect your
issue is elsewhere. I'll submit accounting patches for Marcelo's and/or
Andrea's trees so you can find out what's actually going on.


William Lee Irwin III wrote:
>> Only you, if anyone. My intentions and patchwriting efforts on the 64GB
>> and highmem multiprogramming fronts are long since public, and publicly
>> stated to be targeted at 2.7. Since there isn't a 2.7 yet, 2.5-CURRENT
>> must suffice until there is.

On Thu, Jan 09, 2003 at 09:42:06PM -0600, Brian Tinsley wrote:
> In all honesty, I would enjoy nothing more than contributing to kernel 
> development. Unfortunately it's a bit out of my scope right now (but not 
> forever). If I only believed aliens seeded our gene pool with clones, I 
> could hook up with those folks that claim to have cloned a human and get 
> one of me made! ;)

I don't know what to tell you here. I'm lucky that this is my day job
and that I can contribute so much. However, there are plenty who
contribute major changes (many even more important than my own) without
any such sponsorship. Perhaps emulating them would satisfy your wish.


Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

