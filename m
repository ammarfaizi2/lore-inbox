Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271507AbRH1PqB>; Tue, 28 Aug 2001 11:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271572AbRH1Ppx>; Tue, 28 Aug 2001 11:45:53 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58884 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271507AbRH1Ppj>;
	Tue, 28 Aug 2001 11:45:39 -0400
Date: Tue, 28 Aug 2001 12:45:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: find_get_swapcache_page() question
In-Reply-To: <Pine.LNX.4.21.0108281154030.1015-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0108281244550.26170-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Hugh Dickins wrote:

> 		if (!PageSwapCache(found))
> 			BUG();
> 		if (found->mapping != &swapper_space)
> 			BUG();
> are not safe, since there may a concurrent remove_from_swap_cache(),
> either from try_to_unuse() or from Rik's new vm_swap_full() deletion.
> Those tests would be safe if the page were locked, but it's not.

vm_swap_full() is called with the page locked,
remove_from_swap_cache() also seems to want the
page locked...

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

