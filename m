Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264205AbRFFWAk>; Wed, 6 Jun 2001 18:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264194AbRFFWAa>; Wed, 6 Jun 2001 18:00:30 -0400
Received: from [192.48.153.1] ([192.48.153.1]:38206 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S264192AbRFFWAY>;
	Wed, 6 Jun 2001 18:00:24 -0400
Message-ID: <3B1EA748.6B9C1194@sgi.com>
Date: Wed, 06 Jun 2001 14:57:29 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
		<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com> <m1wv6p5uqp.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> The hard rule will always be that to cover all pathological cases swap
> must be greater than RAM.  Because in the worse case all RAM will be
> in thes swap cache.  That this is more than just the worse case in 2.4
> is problematic.  I.e. In the worst case:
> Virtual Memory = RAM + (swap - RAM).

Hmmm....so my 512M laptop only really has 256M?  Um...I regularlly run
more than 256M of programs.  I don't want it to swap -- its a special, weird
condition if I do start swapping.  I don't want to waste 1G of HD (5%) for
something I never want to use.  IRIX runs just fine with swap<RAM.  In
Irix, your Virtual Memory = RAM + swap.  Seems like the Linux kernel requires
more swap than other old OS's (SunOS3 (virtual mem = min(mem,swap)).
I *thought* I remember that restriction being lifted in SunOS4 when they
upgraded the VM.  Even though I worked there for 6 years, that was
6 years ago...

> You can't improve the worst case.  We can improve the worst case that
> many people are facing.

---
    Other OS's don't have this pathological 'worst case' scenario.  Even
my Windows [vm]box seems to operate fine with swap<MEM.  On IRIX,
virtual space closely approximates physical + disk memory.

> It's worth complaining about.  It is also worth digging into and find
> out what the real problem is.  I have a hunch that this hole
> conversation on swap sizes being irritating is hiding the real
> problem.

---
    Okay, admission of ignorance.  When we speak of "swap space",
is this term inclusive of both demand paging space and
swap-out-entire-programs space or one or another?
-linda

--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338



