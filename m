Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274622AbSITB4q>; Thu, 19 Sep 2002 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274627AbSITB4q>; Thu, 19 Sep 2002 21:56:46 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:34694 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S274622AbSITB4p>; Thu, 19 Sep 2002 21:56:45 -0400
Date: Thu, 19 Sep 2002 23:01:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
Message-ID: <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Ulrich Drepper wrote:

>    Initial confirmations were test runs with huge numbers of threads.
>    Even on IA-32 with its limited address space and memory handling
>    running 100,000 concurrent threads was no problem at all,

So, where did you put those 800 MB of kernel stacks needed for
100,000 threads ?

If you used the standard 3:1 user/kernel split you'd be using
all of ZONE_NORMAL for kernel stacks, but if you use a 2:2 split
you'll end up with a lot less user space (bad if you want to
have many threads in the same address space).

Do you have some special solutions up your sleeve or is this
in the category of as-of-yet unsolved problems ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

