Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135959AbRD0AXE>; Thu, 26 Apr 2001 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135961AbRD0AWo>; Thu, 26 Apr 2001 20:22:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:27660 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135959AbRD0AWc>; Thu, 26 Apr 2001 20:22:32 -0400
Date: Thu, 26 Apr 2001 17:19:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010427020524.A678@athlon.random>
Message-ID: <Pine.LNX.4.31.0104261717540.4310-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Andrea Arcangeli wrote:
> +		__label__ here;
> +	here:
> +		printk(KERN_ERR "IO error or racy use of wait_on_buffer() from %p\n", &&here);

Detail nit: don't do this. Use "current_text_addr()" instead. Simpler to
read, and gcc will actually do the right thing wrt inlining etc.

		Linus

