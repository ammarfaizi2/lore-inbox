Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277687AbRJIB21>; Mon, 8 Oct 2001 21:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277688AbRJIB2R>; Mon, 8 Oct 2001 21:28:17 -0400
Received: from cx739861-a.dt1.sdca.home.com ([24.5.164.61]:24325 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S277687AbRJIB2I>; Mon, 8 Oct 2001 21:28:08 -0400
Date: Mon, 8 Oct 2001 18:28:20 -0700
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, kernelnewbies@nl.linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH *] faster cache reclaim
Message-ID: <20011008182820.A6361@gnuppy>
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 08:38:27PM -0300, Rik van Riel wrote:
> It also reduces the distance between inactive_shortage and
> inactive_plenty, so kswapd should spend much less time rolling
> over pages from zones we're not interested in.
> 
> This patch is meant to fix the problems where heavy cache
> activity flushes out pages from the working set, while still
> allowing the cache to put some pressure on the working set.

Rik,

It work well when I pressure it under some intensive IO operations under
dpkg and made progress when previous VMs basically froze. I did have two
running programs that have large working sets which created a lot of
contention and some CPU choppiness, but possibly some per process thrash
control should allow for both to make progress. ;-)

Good work.

bill

