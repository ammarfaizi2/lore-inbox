Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271502AbRHZTjt>; Sun, 26 Aug 2001 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271501AbRHZTja>; Sun, 26 Aug 2001 15:39:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39944 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271498AbRHZTjZ>; Sun, 26 Aug 2001 15:39:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 21:46:04 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <pcg@goof.com>, Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108261538190.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108261538190.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826193933Z16469-32384+567@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 08:39 pm, Rik van Riel wrote:
> On Sun, 26 Aug 2001, Daniel Phillips wrote:
> 
> > There's an obvious explanation for the high loadavg people are seeing
> > when their systems go into thrash mode: when free is exhausted, every
> > task that fails to get a block in __alloc_pages will become
> > PF_MEMALLOC and start scanning.
> 
> If you ever tested this, you'd know this is not true.

Look at this, supplied by Nicolas Pitre in the thread "What version of the 
kernel fixes these VM issues?":

> A couple sysrq-P at random intervals shows the CPU looping in the following
> functions:
> 
> PC value	System.map
> --------	----------
> c0040d84	zone_inactive_plenty
> c0041024	try_to_swap_out
> c00216e0	cpu_sa1100_cache_clean_invalidate_range
> c00216d0	cpu_sa1100_cache_clean_invalidate_range
> c0041304	swap_out_mm
> c0041168	swap_out_pmd
> c0044324	__get_swap_page
> c0040d60	zone_inactive_plenty
> c0041128	swap_out_pmd
> c0040fec	try_to_swap_out

--
Daniel
