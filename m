Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278514AbRJPEBo>; Tue, 16 Oct 2001 00:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278517AbRJPEBf>; Tue, 16 Oct 2001 00:01:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278514AbRJPEBU>; Tue, 16 Oct 2001 00:01:20 -0400
Date: Mon, 15 Oct 2001 21:01:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.GSO.4.21.0110152308440.11608-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110152053080.8668-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Oct 2001, Alexander Viro wrote:
>
> I don't.  ->f_pos is an entry number.  That's it.

Ahh, ok, I did indeed misread your code. Fair enough, then that's pretty
much equivalent to what I was asking for.

The reason I like sub-positions is that I worry that some application does
an lseek() to a position it already held earlier.

But you're probably right that it doesn't really matter, and as we really
have "pipe"  semantics we might as well dis-allow any lseek except to the
beginning (I know that there have been apps out there that avoid
re-opening /proc files by lseek'ing to zero and re-reading - they may not
be common enough to matter, though).

Ok, I'll re-read your patch with this in mind. But it sounds like I'm
going to approve of it with this background...

		Linus


