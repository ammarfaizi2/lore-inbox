Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRAaVCN>; Wed, 31 Jan 2001 16:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbRAaVCD>; Wed, 31 Jan 2001 16:02:03 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:12920 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132438AbRAaVBs>; Wed, 31 Jan 2001 16:01:48 -0500
Date: Wed, 31 Jan 2001 15:58:30 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Rik van Riel <riel@conectiva.com.br>
cc: Gabor Lenart <lgb@lgb.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <Pine.LNX.4.21.0101311846110.1321-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101311557080.1261-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would it be possible to grow and shring that buffer on demand?
> > Let's say we have a default size and let it grow to a maximum
> > value. After some timeout, buffer size can be shrinked to
> > default value if it's enough at that moment. Or something
> > similar.
> 
> And when you can't allocate memory for expanding the
> printk() ringbuffer?  Print a message? ;)

;)
but seriously, we normally need a big printk buffer only because 
of boot messages.  no reason I know we couldn't shrink it down
to something quite modest (4k?  plenty for a few oopses) after boot.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
