Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRARAkI>; Wed, 17 Jan 2001 19:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRARAj7>; Wed, 17 Jan 2001 19:39:59 -0500
Received: from [129.94.172.186] ([129.94.172.186]:18671 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130024AbRARAjs>; Wed, 17 Jan 2001 19:39:48 -0500
Date: Thu, 18 Jan 2001 01:28:13 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0101180126240.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Linus Torvalds wrote:

> I looked at it a year or two ago myself, and came to the
> conclusion that I don't want to blow up our page table size by a
> factor of three or more, so I'm not personally interested any
> more. Maybe somebody else comes up with a better way to do it,
> or with a really compelling reason to.

OTOH, it _would_ get rid of all the balancing issues in one
blow. And it would fix the aliasing issues and possibly the
memory fragmentation problem too.

And using something like Davem's lower-overhead reverse
mapping layer, we might just be able to pull off all (or most)
of the advantages with lower overhead ;)

[this is something I will be looking into for 2.5]

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
