Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQLBS37>; Sat, 2 Dec 2000 13:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLBS3s>; Sat, 2 Dec 2000 13:29:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28404 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129538AbQLBS3o>;
	Sat, 2 Dec 2000 13:29:44 -0500
Date: Sat, 2 Dec 2000 12:59:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <20001202173959.A10166@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0012021255330.28923-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Petr Vandrovec wrote:

[I wrote:]

> > ed fs/buffer.c <<EOF
> > /unmap_buffer/
> > /}/i
		spin_lock(&lru_list_lock);
> > 		remove_inode_queue(bh);
		spin_unlock(&lru_list_lock);
> > .
> > wq
> > EOF

Damn. I claim the sudden idiocy attack - didn't look at the locking
rules for the ->b_inode_buffers. My apologies.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
