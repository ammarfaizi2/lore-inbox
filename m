Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275211AbRIZOJJ>; Wed, 26 Sep 2001 10:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275209AbRIZOIu>; Wed, 26 Sep 2001 10:08:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43020 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275211AbRIZOI3>;
	Wed, 26 Sep 2001 10:08:29 -0400
Date: Wed, 26 Sep 2001 11:08:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Out of memory handling broken
In-Reply-To: <20010926160306.D7290@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L.0109261106550.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Pavel Machek wrote:

> > > I need to allocate as much memory as possible (but not more).
> > > Okay, so I use out_of_memory, right?
> >
> > Nope, out_of_memory() is about virtual memory handling,
> > not at all about physical memory.
>
> Yes, so... What happens at physical memory exhaustion? System crash?

We swap something out.

But indeed, when the kernel needs memory for itself
and no more memory is available, we'd crash. This is
not something I've ever seen any system get close to,
however...

> Okay, okay. Is there any solution (in 2.4.10) in doing what I want to
> do?

GPF_ATOMIC and giving kswapd a chance to run whenever the
atomic allocations fail ?

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

