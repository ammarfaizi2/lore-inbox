Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280808AbRKLOtK>; Mon, 12 Nov 2001 09:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRKLOtB>; Mon, 12 Nov 2001 09:49:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22868 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280814AbRKLOss>; Mon, 12 Nov 2001 09:48:48 -0500
Date: Mon, 12 Nov 2001 15:48:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru,
        Thorsten Kukuk <kukuk@suse.de>
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112154825.X1381@athlon.random>
In-Reply-To: <8F913E94424@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <8F913E94424@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Nov 12, 2001 at 03:33:03PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 03:33:03PM +0000, Petr Vandrovec wrote:
> On 12 Nov 01 at 15:20, Andrea Arcangeli wrote:
> 
> Hi Andrea,
>   does it compile? It looks to me like that you are using ret_from_fork,
> ret_from_smp and ret_from_smpfork interchangably in the patch. You renamed

ret_from_smpfork must disappear, to fix any compilation trouble you only
need to replace it with ret_from_fork in any possible place that I
forgotten.

as said I don't know what PSR_PIL means so that is more important part
to check for runtime correctness (compilations details are trivial to
solve instead).

thanks for the review,
Andrea
