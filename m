Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277229AbRJQVYT>; Wed, 17 Oct 2001 17:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277230AbRJQVYJ>; Wed, 17 Oct 2001 17:24:09 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:64268 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S277229AbRJQVYD>; Wed, 17 Oct 2001 17:24:03 -0400
Date: Wed, 17 Oct 2001 22:23:37 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <20011017222108.C12055@athlon.random>
Message-ID: <Pine.LNX.4.33.0110172220230.2072-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Oct 2001, Andrea Arcangeli wrote:

> I think with directory readahead Marcelo meant a transparent kernel
> heuristic in the readdir path. ext2_get_page is completly synchronous
> and it's reading one page at time, that's bad but it can be improved
> transparently to userspace, just like we do with the files, and also
> like the old code was doing before the directory in pagecache IIRC.

Do the -ac kernels have the directory in pagecache patch? If not, it could
explain why the -ac kernel performed _much_ better for the
creat()/stat()/unlink() tests in bonnie++.

Cheers
Chris

