Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271753AbRICRIF>; Mon, 3 Sep 2001 13:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271754AbRICRHy>; Mon, 3 Sep 2001 13:07:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56451 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271753AbRICRHm>;
	Mon, 3 Sep 2001 13:07:42 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Sep 2001 17:07:28 GMT
Message-Id: <200109031707.RAA36835@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [PATCH] cleanup in fs/super.c (do_kern_mount())
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +#define MS_NOUSER    (1<<31)

>> a pity to waste a bit

> No, it's not useful for userland ;-) For internal use.

Hmm. Bad style, but acceptable if you never do it again :-)

[I mean: as soon as we start using more than 16 mount flags
we have the top 16 bits, but only 2^16 - 1 values are available
since 0xc0ed is a conventional value; now if the bits are
completely independent then it is strange to forbid one
particular random combination, and it is cleaner to use
only 15 bits with 2^15 values. If the top bit is never used
from user space then it is available for internal purposes.]

Andries
