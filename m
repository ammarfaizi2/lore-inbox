Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278384AbRJSNDU>; Fri, 19 Oct 2001 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278387AbRJSNDK>; Fri, 19 Oct 2001 09:03:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9738 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278384AbRJSNC4>;
	Fri, 19 Oct 2001 09:02:56 -0400
Date: Fri, 19 Oct 2001 11:03:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] free more swap space on exit()
In-Reply-To: <Pine.LNX.4.21.0110191157110.939-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0110191100570.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001, Hugh Dickins wrote:

> Please just find_get_page and TryLockPage within
> free_swap_and_swap_cache?

I really don't like the idea of sprinkling the magic all
around the VM subsystem, but prefer to keep the code
easier to maintain instead.

About the "undoes some inlining", I guess we might as
well mark __find_get_page() inline then so it gets
included into __find_lock_page(), after all it's the
equivalent code so it should end up the same as before.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

