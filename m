Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130265AbQKPNYD>; Thu, 16 Nov 2000 08:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQKPNXx>; Thu, 16 Nov 2000 08:23:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24511 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129186AbQKPNXm>;
	Thu, 16 Nov 2000 08:23:42 -0500
Date: Thu, 16 Nov 2000 07:53:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_empty_inode() cleanup
In-Reply-To: <Pine.LNX.4.21.0011161242330.1530-100000@saturn.homenet>
Message-ID: <Pine.GSO.4.21.0011160745580.11017-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Tigran Aivazian wrote:

> on the other hand, even 1 minute's thought reveals that making strict
> logical separation between "consumers of inode with sb" and "consumers of
> inode without sb" is probably worth the overhead of an extra function
> call. So, I don't strongly feel about the above... maybe you are right :)

It's not the with sb/without sb thing. Everything is much simpler -
changing the get_empty_inode() prototype means mandatory changes in
all 3rd-party code. Code freeze and all such...

IOW, unmodified code doesn't break from the addition of helper function,
but changing get_empty_inode() will break (albeit in a trivial way)
every bloody filesystem out there. Not a problem for 2.5, but doing that
now for no good reason...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
