Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271019AbRHTE5L>; Mon, 20 Aug 2001 00:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271064AbRHTE5A>; Mon, 20 Aug 2001 00:57:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46070 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271019AbRHTE4p>;
	Mon, 20 Aug 2001 00:56:45 -0400
Date: Mon, 20 Aug 2001 00:56:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: chuckw@ieee.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Question on coding style in networking code
In-Reply-To: <20010819124442.G2388@ieee.org>
Message-ID: <Pine.GSO.4.21.0108200046580.1313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Aug 2001 chuckw@ieee.org wrote:

> 	struct x y = {
> 		member1: x,
> 		member2: y,
> 		member3: z
> 	};
> 
> What is the deal with this?  Does the second way have any advantage over the previous?

_Much_ easier to grep for. Less pain in the ass when fields are added/removed/
reordered.

For anything with many fields (usually method tables) it's more convenient.
And no, it's not just networking - filesystem-related code, etc. uses it
all over the place.

