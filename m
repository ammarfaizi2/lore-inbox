Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJLSUn>; Sat, 12 Oct 2002 14:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJLSUn>; Sat, 12 Oct 2002 14:20:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13477 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261327AbSJLSUm>;
	Sat, 12 Oct 2002 14:20:42 -0400
Date: Sat, 12 Oct 2002 14:26:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.42: build nfsd as module broken
In-Reply-To: <871y6vwmft.fsf@goat.bogus.local>
Message-ID: <Pine.GSO.4.21.0210121423500.6898-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Oct 2002, Olaf Dietsche wrote:

> +EXPORT_SYMBOL(cache_fresh);
> +EXPORT_SYMBOL(cache_flush);
> +EXPORT_SYMBOL(cache_unregister);
> +EXPORT_SYMBOL(cache_check);
> +EXPORT_SYMBOL(cache_clean);
> +EXPORT_SYMBOL(cache_register);
> +EXPORT_SYMBOL(cache_init);
> +EXPORT_SYMBOL(add_word);
> +EXPORT_SYMBOL(add_hex);
> +EXPORT_SYMBOL(get_word);

Ahem.  Non-static objects called add_word and get_word?  Even the cache_...()
stuff is a namespace pollution (which kind of cache?), but that...

