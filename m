Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJQAti>; Tue, 16 Oct 2001 20:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJQAtT>; Tue, 16 Oct 2001 20:49:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24580 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273261AbRJQAtR>;
	Tue, 16 Oct 2001 20:49:17 -0400
Date: Tue, 16 Oct 2001 22:49:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Patrick McFarland <unknown@panax.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <20011017013856.R2380@athlon.random>
Message-ID: <Pine.LNX.4.33L.0110162247210.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001, Andrea Arcangeli wrote:

> I was also surprised that mainline was swapping more, it shouldn't
> really be the case. Infact in 2.4.13pre3aa1 I'm using shrink_cache to
> probe when it's time to start paging, instead of waiting shrink_cache to
> fail, this to avoid being too aggressive against the cache. So with
> those recent changes it should start swapping earlier and it should swap
> more.  But if it's now swapping too much it will be very easy to turn it
> down the swap rate as worse with a few liner that removes such
> cache-probe early-swap logic.

This is exactly why I am so religious about page aging
on objects which are being used.  With just the referenced
bit you'll end up almost needing code tweaks to make the
system behave well under various different loads.

The VM just doesn't have the information it needs to
determine what to do...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

