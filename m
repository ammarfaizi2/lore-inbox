Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbQL1SUl>; Thu, 28 Dec 2000 13:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQL1SUb>; Thu, 28 Dec 2000 13:20:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22535 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131406AbQL1SUU>; Thu, 28 Dec 2000 13:20:20 -0500
Date: Thu, 28 Dec 2000 09:49:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4B563C.DAE31010@innominate.de>
Message-ID: <Pine.LNX.4.10.10012280948530.12064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Daniel Phillips wrote:
> 
> It's logical that PageDirty should never be get for ramfs, and a ramfs
> page should never have buffers on it.

What?

No no no.

You're obviously right that ramfs will never have buffers on the page, but
why shouldn't a ramfs page be dirty?

Of _course_ a ramfs page is dirty - that's the only thing that tells the
VM that it can't be thrown out.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
