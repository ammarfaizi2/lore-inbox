Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274342AbRITGeo>; Thu, 20 Sep 2001 02:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274338AbRITGee>; Thu, 20 Sep 2001 02:34:34 -0400
Received: from [195.223.140.107] ([195.223.140.107]:6654 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274337AbRITGeV>;
	Thu, 20 Sep 2001 02:34:21 -0400
Date: Thu, 20 Sep 2001 08:34:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920083438.A1629@athlon.random>
In-Reply-To: <20010920080837.A719@athlon.random> <Pine.LNX.4.33.0109192310340.2852-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109192310340.2852-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 19, 2001 at 11:15:47PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 11:15:47PM -0700, Linus Torvalds wrote:
> and do early COW (which the write-access kind of means).

my new patch does the early COW.

> However, your patch isn't right for another reason: if we do delete it
> from the swap cache, we'd better mark it dirty so that it gets
> re-allocated a swap entry if it later on needs it.
> 
> That's why the old code went to such extremes: it marked it dirty and
> writable if it was a write access (and exclusive), and it marked it _just_
> dirty and removed it from the swap cache if it went over the swap limit.

agreed.

Andrea
