Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274338AbRITGio>; Thu, 20 Sep 2001 02:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274345AbRITGie>; Thu, 20 Sep 2001 02:38:34 -0400
Received: from [195.223.140.107] ([195.223.140.107]:9214 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274338AbRITGiZ>;
	Thu, 20 Sep 2001 02:38:25 -0400
Date: Thu, 20 Sep 2001 08:38:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920083842.B1629@athlon.random>
In-Reply-To: <20010920082602.A701@athlon.random> <Pine.LNX.4.33.0109192326070.2852-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109192326070.2852-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 19, 2001 at 11:31:45PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 11:31:45PM -0700, Linus Torvalds wrote:
> So I would suggest:
> 
> 	if (exclusive_swap_page(page)) {
> 		if (vma->vm_flags & VM_WRITE)
> 			pte = pte_mkwrite(pte);
> 		pte = pte_mkdirty(pte);
> 		delete_from_swap_cache_nolock(page);
> 	}
> 
> or similar.

indeed, agreed.

Andrea
