Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbQKDRXo>; Sat, 4 Nov 2000 12:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbQKDRXe>; Sat, 4 Nov 2000 12:23:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129285AbQKDRX0>; Sat, 4 Nov 2000 12:23:26 -0500
Date: Sat, 4 Nov 2000 09:22:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <E13s0y9-0004TB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011040919550.3864-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2000, Alan Cox wrote:
>
> > Even 2.2.x can be fixed to do the wake-one for accept(), if required. 
> 
> Do we really want to retrofit wake_one to 2.2. I know Im not terribly keen to
> try and backport all the mechanism. I think for 2.2 using the semaphore is a 
> good approach. Its a hack to fix an old OS kernel. For 2.4 its not needed

We don't need to backport of the full exclusive wait queues: we could do
the equivalent of the semaphore inside the kernel around just accept(). It
wouldn't be a generic thing, but it would fix the specific case of
accept().

Otherwise we're going to have old binaries of apache lying around forever
that do the wrong thing..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
