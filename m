Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291849AbSBYQOL>; Mon, 25 Feb 2002 11:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293414AbSBYQOB>; Mon, 25 Feb 2002 11:14:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59913 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291849AbSBYQNv>; Mon, 25 Feb 2002 11:13:51 -0500
Date: Mon, 25 Feb 2002 08:11:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16fKxl-0004qL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202250808150.3268-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Alan Cox wrote:
>
> 	fd = open("/dev/shm/sem....");

Hmm.. Yes. Except I would allow a NULL backing store name for the
normal(?) case of just wanting private anonymous memory.

At the same time, I have to admit that I like the notion that Rusty had of
libraries being able to just put their semaphores anywhere (on the stack
etc), as it does work for many architectures. Ugh.

		Linus

