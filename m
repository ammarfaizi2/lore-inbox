Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278346AbRJMS3q>; Sat, 13 Oct 2001 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278348AbRJMS3g>; Sat, 13 Oct 2001 14:29:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:22794 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278347AbRJMS3X>;
	Sat, 13 Oct 2001 14:29:23 -0400
Date: Sat, 13 Oct 2001 15:29:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Patrick McFarland <unknown@panax.com>
Cc: "M. Edward Borasky" <znmeb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
In-Reply-To: <20011013141709.L249@localhost>
Message-ID: <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Patrick McFarland wrote:

> Hmm, I see that as very bad. There should be a bunch of sysctls to do
> that easily.

See /proc/sys/vm/* and the documentation ;)

> Also, I heard that 2.4 (and I'm assuming 2.2 as well) swaps pages on a
> last-used-age basis, instead of either a number-of-times-used or a
> hybrid of the two. That kinda seems stupid,

Don't worry since it's not true, at least the VM in the -ac
kernels _does_ use a hybrid of access recency and frequency
to determine page replacement.

The -linus kernel, however only has LRU-like selection.

At the moment the -linus kernel is faster than the -ac kernel
for some workloads. This may have something to do with better
clusterable IO ... when page replacement is less precise the
chance that IO is clusterable is probably larger due to the
way we scan.

I plan to do more explicit IO clustering in -ac to try and
remedy this difference.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

