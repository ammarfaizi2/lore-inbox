Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291979AbSBYRIR>; Mon, 25 Feb 2002 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292400AbSBYRII>; Mon, 25 Feb 2002 12:08:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293440AbSBYRH6>; Mon, 25 Feb 2002 12:07:58 -0500
Date: Mon, 25 Feb 2002 09:06:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16fOAO-0005Ml-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202250905090.3392-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Alan Cox wrote:
> > > 	fd = open("/dev/shm/sem....");
> >
> > Hmm.. Yes. Except I would allow a NULL backing store name for the
> > normal(?) case of just wanting private anonymous memory.
>
> unlink()

Sure, but that, together with making up a unique temporary name etc just
adds extra overhead for no actual gain.

> > At the same time, I have to admit that I like the notion that Rusty had of
> > libraries being able to just put their semaphores anywhere (on the stack
> > etc), as it does work for many architectures. Ugh.
>
> _alloca
> mmap
>
> Still fits on the stack 8)

.. but is slow as hell.

		Linus

