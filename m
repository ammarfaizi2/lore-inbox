Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbQLXWjg>; Sun, 24 Dec 2000 17:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbQLXWj0>; Sun, 24 Dec 2000 17:39:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14604 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130194AbQLXWjT>; Sun, 24 Dec 2000 17:39:19 -0500
Date: Sun, 24 Dec 2000 14:08:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A46578C.5FF7AD4F@innominate.de>
Message-ID: <Pine.LNX.4.10.10012241405570.4404-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2000, Daniel Phillips wrote:
> 
> It looks like PG_dirty is now being used only for swap_cache pages, and
> not for buffer cache and page cache pages, is that correct?

No. PG_dirty is used for all memory mapped pages - be they anonymous or
not.  

These days the buffer dirty bits are only used by "write()", because
write() can obviously dirty smaller areas than one page.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
