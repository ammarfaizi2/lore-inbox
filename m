Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQLEULc>; Tue, 5 Dec 2000 15:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLEULW>; Tue, 5 Dec 2000 15:11:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50838 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129562AbQLEULN>;
	Tue, 5 Dec 2000 15:11:13 -0500
Date: Tue, 5 Dec 2000 14:40:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: check_lock() in d_move() and switch_names()?
In-Reply-To: <Pine.LNX.4.21.0012051913021.1493-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012051437430.12284-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Tigran Aivazian wrote:

> Hi,
> 
> The check for BKL in d_move() and switch_names() seem to be unnecessary as
> d_move() takes dcache_lock and switch_names() is only called by
> d_move(). So, if the callers take BKL just for the sake of d_move() they
> do not need to, but if, for other reasons, then that is fine. In any case,
> the checks in both functions can be removed, imho. Opinions?

Tigran, _please_ stop it. d_move() needs BKL. Test in question is a
sanity check _and_ reminder of that fact, so please leave it in place. 
Microoptimizations are OK when they make the code cleaner, but here...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
