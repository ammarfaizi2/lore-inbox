Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSEAEsV>; Wed, 1 May 2002 00:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315296AbSEAEsU>; Wed, 1 May 2002 00:48:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30966 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315293AbSEAEsU>;
	Wed, 1 May 2002 00:48:20 -0400
Date: Wed, 1 May 2002 00:48:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export path_lookup()
In-Reply-To: <E172jFe-0006YM-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0205010047150.10523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Apr 2002, Paul Menage wrote:

> 
> path_lookup() is no longer an inline function, and needs to be exported 
> for jffs2, nfsd and af_unix to load as modules.
> 
> diff -aur linux-2.5.12/kernel/ksyms.c linux-2.5.12-export/kernel/ksyms.c
> --- linux-2.5.12/kernel/ksyms.c	Tue Apr 30 17:08:45 2002
> +++ linux-2.5.12-export/kernel/ksyms.c	Tue Apr 30 18:40:30 2002
> @@ -144,6 +144,7 @@
>  EXPORT_SYMBOL(follow_up);
>  EXPORT_SYMBOL(follow_down);
>  EXPORT_SYMBOL(lookup_mnt);
> +EXPORT_SYMBOL(path_lookup);
>  EXPORT_SYMBOL(path_init);
>  EXPORT_SYMBOL(path_walk);
>  EXPORT_SYMBOL(path_release);

Seconded - it is needed, indeed.

