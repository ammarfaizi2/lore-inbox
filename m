Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTAJDpe>; Thu, 9 Jan 2003 22:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbTAJDpe>; Thu, 9 Jan 2003 22:45:34 -0500
Received: from holomorphy.com ([66.224.33.161]:24470 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262604AbTAJDpd>;
	Thu, 9 Jan 2003 22:45:33 -0500
Date: Thu, 9 Jan 2003 19:54:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Tinsley <btinsley@emageon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110035412.GJ23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Tinsley <btinsley@emageon.com>, linux-kernel@vger.kernel.org
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E410E.5050905@emageon.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
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
