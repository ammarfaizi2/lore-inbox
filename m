Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129064AbQJ3Wwa>; Mon, 30 Oct 2000 17:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbQJ3WwU>; Mon, 30 Oct 2000 17:52:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129064AbQJ3WwD>; Mon, 30 Oct 2000 17:52:03 -0500
Date: Mon, 30 Oct 2000 14:51:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: <11037.972945717@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10010301447490.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Keith Owens wrote:
> 
> obj-y is used together with export-objs to split objects into O_OBJS
> (no export symbol) and OX_OBJS (export symbol).  If usbcore.o (multi)
> is not replaced by its components then usb.o (in export-objs) is not
> added to OX_OBJS so usb.c gets compiled with the wrong flags which
> causes incorrect module symbols.  Multi's in obj-y have to replaced by
> their components before being split into O_OBS and OX_OBJS.

Your honour, I object.

What would be wrong with just splitting it the other way, ie make OX_OBJS
be the expanded (but not ordered) list?

That should take care of it, no?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
