Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRKFHKh>; Tue, 6 Nov 2001 02:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRKFHKS>; Tue, 6 Nov 2001 02:10:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21691 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278358AbRKFHKP>;
	Tue, 6 Nov 2001 02:10:15 -0500
Date: Tue, 6 Nov 2001 02:10:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <200111060635.fA66ZIH20196@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0111060204161.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Richard Gooch wrote:

> Yep, as I've long ago admitted, there are races in the old devfs
> code, which couldn't be fixed without proper locking. And that's why
> I've been wanting to add said locking for ages, and have been
> frustrated at interruptions which delayed that work. And I'm very
> happy to get the first cut of the new code released.

BTW, new code still has both aforementioned races - detaching entries
from the tree doesn't help with that.

> That said, try to understand (before getting emotional and launching
> off a tirade such as the one last week) that different people have
> different priorities, and mine was to provide functionality first, and
> worry about hostile attacks/exploits later. This is not unreasonable
> if you consider that the initial target machines for devfs were:
> - my personal boxes (which are not public machines)
> - big-iron machines sitting behind a firewall
> - small university group sitting behind a firewall (and I know where
>   all the users live:-)

That's nice, but that had stopped being the case as soon as you've proposed
devfs for inclusion into the tree...

