Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJPV4z>; Tue, 16 Oct 2001 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRJPV4p>; Tue, 16 Oct 2001 17:56:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:46604 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276753AbRJPV4c>;
	Tue, 16 Oct 2001 17:56:32 -0400
Date: Tue, 16 Oct 2001 19:56:49 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [UNTESTED PATCH] Throttle VM allocators
In-Reply-To: <Pine.LNX.4.21.0110161600110.10214-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0110161955420.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Marcelo Tosatti wrote:

> +	/*
> +	 * We're possibly going to eat memory from the min<->low
> +	 * "reversed" area. Throttling page reclamation using

"reserved"  ;)

> +	 * the allocators which reach this point will give us a
> +	 * fair system.
> +	 */
> +
> +	if ((gfp_mask & __GFP_WAIT))
> +		vm_throttle(classzone, gfp_mask, order);

It might be an idea to also test for PF_MEMALLOC here,
otherwise bad things will happen.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

