Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRAUXWg>; Sun, 21 Jan 2001 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbRAUXW0>; Sun, 21 Jan 2001 18:22:26 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:12548 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130238AbRAUXWP>; Sun, 21 Jan 2001 18:22:15 -0500
Date: Sun, 21 Jan 2001 23:21:28 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201124090.10317-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101212319010.1574-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Linus Torvalds wrote:

> There's no no-no here: you can even create the "struct page"s on demand,
> and create a dummy local zone that contains them that they all point back
> to. It should be trivial - nobody else cares about those pages or that
> zone anyway.
> 
> This is very much how the MM layer in 2.4.x is set up to work.
> 
> That said, nobody has actually done this in practice yet, so there may be
> details to work out, of course. I don't see any fundamental reasons it
> wouldn't easily work, but..

If I follow you correctly, this is how I was planning to provide 
execute-in-place support for filesystems on flash chips - allocating 
'struct page's and adding them to the page cache on read_inode().

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
