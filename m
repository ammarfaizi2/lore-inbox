Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280017AbRKDQhG>; Sun, 4 Nov 2001 11:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280022AbRKDQg4>; Sun, 4 Nov 2001 11:36:56 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:60936 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280017AbRKDQgw>;
	Sun, 4 Nov 2001 11:36:52 -0500
Date: Sun, 4 Nov 2001 14:36:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] vm_swap_full
In-Reply-To: <20011104152341.A4C289E898@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Ed Tomlinson wrote:

> -/* Swap 50% full? Release swapcache more aggressively.. */
> -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
> +/* Free swap less than inactive pages? Release swapcache more aggressively.. */
> +#define vm_swap_full() (nr_swap_pages < nr_inactive_pages)

> Comments?

Makes absolutely no sense for systems which have more
swap than RAM, eg. a 64MB system with 200MB of swap.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

