Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRACS7f>; Wed, 3 Jan 2001 13:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRACS7Z>; Wed, 3 Jan 2001 13:59:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130172AbRACS7I>; Wed, 3 Jan 2001 13:59:08 -0500
Date: Wed, 3 Jan 2001 10:28:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <428710000.978539866@tiny>
Message-ID: <Pine.LNX.4.10.10101031027090.1896-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Chris Mason wrote:
> 
> Just noticed the filemap_fdatasync code doesn't check the return value from
> writepage.  Linus, would you take a patch that redirtied the page, puts it
> back onto the dirty list (at the tail), and unlocks the page when writepage
> returns 1?

I don't see how that would help. It's just asking for endless loops.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
