Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268415AbUH3Bx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbUH3Bx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUH3Bx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:53:28 -0400
Received: from Jupiter.Toms.NET ([64.32.223.162]:56762 "EHLO jupiter.toms.net")
	by vger.kernel.org with ESMTP id S268415AbUH3BxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:53:08 -0400
Date: Sun, 29 Aug 2004 21:52:50 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minix fix - ? does this fix "du" bug ?!?
In-Reply-To: <UTC200408202121.i7KLLCO04775.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0408292151290.19310@jupiter.toms.net>
References: <UTC200408202121.i7KLLCO04775.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will this patch fix the fact that 'du' is broken on minix, as a
few of us have been reporting?  (Assume yes:  Yippeedoo! Thanks!) -Tom

> In 2.5.18 some minix-specific stuff was moved to the minix
> subdirectory where it belonged. However, a typo crept in.
> A few people have complained, but so far not sufficiently loudly.
>
> The bug is of a type that automated tools might discover:
> a value res is computed, but not used.
>
> Andries
>
> Signed-off-by: Andries Brouwer
>
> diff -uprN -X /linux/dontdiff a/fs/minixdiff -uprN -X /linux/dontdiff a/fs/minix/itree_common.c b/fs/minix/itree_common.c
> --- a/fs/minix/itree_common.c	2003-12-18 03:59:05.000000000 +0100
> +++ b/fs/minix/itree_common.c	2004-08-20 23:02:26.000000000 +0200
> @@ -358,5 +358,5 @@ static inline unsigned nblocks(loff_t si
>  		res += blocks;
>  		direct = 1;
>  	}
> -	return blocks;
> +	return res;
>  }
> -
