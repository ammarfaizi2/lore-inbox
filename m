Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbREOFEd>; Tue, 15 May 2001 01:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbREOFEX>; Tue, 15 May 2001 01:04:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46581 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262633AbREOFEN>;
	Tue, 15 May 2001 01:04:13 -0400
Date: Tue, 15 May 2001 01:04:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142130480.23663-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105150102070.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Linus Torvalds wrote:

> The current page cache is completely non-coherent (with _anything_: it's
> not coherent with other files using a page cache because they have a
> different index, and it's not coherent with the buffer cache because that
> one isn't even in the same name space).

Unfortunately, we have cases when disk block migrates from buffer cache
to page cache. Source of serious PITA and (IMO) the only serious reason
to take indirect blocks into page cache.

