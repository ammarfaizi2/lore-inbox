Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292529AbSBYRpH>; Mon, 25 Feb 2002 12:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSBYRo6>; Mon, 25 Feb 2002 12:44:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293497AbSBYRot>; Mon, 25 Feb 2002 12:44:49 -0500
Date: Mon, 25 Feb 2002 09:44:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16fPGp-0005bj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202250942110.8978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Feb 2002, Alan Cox wrote:
> 
> Any kernel special cases it adds will be unswappable because they are in
> kernel space (not the semaphores here - we want them to be swappable and
> they can be)

Alan, wake up!

I'm talking about anonymous semaphores, the kernel implementation can just 
map a normal anonymous page there.

On 99.9% of all machines out there, you can have semaphores in perfectly 
normal memory.

> When you create a shared mapping by passing -1 to mmap we do

Why are you talking about shared mappings?

The most common case for any fast semaphores are for _threaded_
applications. No shared memory, no nothing.

		Linus

