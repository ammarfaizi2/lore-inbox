Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRIPT5g>; Sun, 16 Sep 2001 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272730AbRIPT50>; Sun, 16 Sep 2001 15:57:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11792 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272732AbRIPT5P>;
	Sun, 16 Sep 2001 15:57:15 -0400
Date: Sun, 16 Sep 2001 16:57:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <9o2vct$889$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109161655250.21279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Linus Torvalds wrote:

> The desribed behaviour has nothing to do with limiting the cache or
> anything else "cannot get enough information", except for the fact that
> the kernel obviously cannot know what will happen in the future.
>
> The kernel _correctly_ swapped out tons of pages that weren't touched in
> a long long time. That's what you want to happen - the fact that they
> then all became active on logout is sad.

The problem is that a too large cache reliably makes the
system unsuitable for interactive use. In that case its
probably worth it to make evicting pages from that cache
more likely than evicting pages from user processes,
while still giving the truly busy cache pages a chance to
stay resident.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

