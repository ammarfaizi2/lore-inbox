Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRAOBM5>; Sun, 14 Jan 2001 20:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130803AbRAOBMh>; Sun, 14 Jan 2001 20:12:37 -0500
Received: from anime.net ([63.172.78.150]:64007 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130461AbRAOBM3>;
	Sun, 14 Jan 2001 20:12:29 -0500
Date: Sun, 14 Jan 2001 17:14:11 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101141706180.30626-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2001, Linus Torvalds wrote:
> That's not the point of sendfile(). The point of sendfile() is to be
> faster than the _combination_ of:
> 	addr = mmap(file, ...len...);
> 	write(fd, addr, len);
> or
> 	read(file, userdata, len);
> 	write(fd, userdata, len);

And boy is it ever. It blows both away by more than double.
Not only that the mmap one grinds my box into the ground with swapping,
while the sendfile() case you can't even tell its running except that the
drive is going like mad.

> Does anybody but apache actually use it?

I wonder why samba doesn't use it.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
