Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSIBC20>; Sun, 1 Sep 2002 22:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSIBC20>; Sun, 1 Sep 2002 22:28:26 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:54949 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318208AbSIBC2Z>; Sun, 1 Sep 2002 22:28:25 -0400
Date: Sun, 1 Sep 2002 23:32:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Con Kolivas <conman@kolivas.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
In-Reply-To: <3D72C6F9.6000302@wmich.edu>
Message-ID: <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002, Ed Sweetman wrote:

> Wouldn't the majority (to an undeniable extent) of the "responsiveness"
> of desktop usage be on X's code? if we are talking about that.  The
> problem with finding a benchmark is that first you have to have a
> definition of what you're benchmarking.  The "system responsiveness"
> term is far too vague. When there's a definition to the term there can
> be a benchmark made to measure it.

Agreed. Things like system responsiveness are fairly complex
though and in many cases the average numbers measured by
benchmarks don't mean anything to users.

I wish we had a way to measure this stuff, but I'll happily
philosophise with you guys until we come up with a useful
definition of something we could measure...

> I mean, besides making the kernel with as low latency as possible, what
> is bad about the responsiveness in the kernel?  If there's any lag in
> responsiveness that i see it's always something X related, particularly
> Xfree86.

"low latency" != responsiveness

Any latency which is below the point the user can notice
is effectively zero, so whether the 10000 wakeups/minute
that the user doesn't notice are 2ms or 5ms don't really
matter.

What does matter are the wakeups that make the user's
mp3 skip, even if these don't influence the statistics
at all because there's only 1 every few minutes, or none,
if the VM is balanced right ;)

Another responsiveness thing is how fast you can swap in
Mozilla when the user comes in in the morning. More of a
throughput than a latency thing in this case ... but you
still have to make sure the mp3 doesn't skip while mozilla
is being loaded.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

