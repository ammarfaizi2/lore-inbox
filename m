Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbQJ3WY4>; Mon, 30 Oct 2000 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbQJ3WYq>; Mon, 30 Oct 2000 17:24:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61956 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129032AbQJ3WYe>; Mon, 30 Oct 2000 17:24:34 -0500
Date: Mon, 30 Oct 2000 14:24:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <39FDEFB0.B99B7E68@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10010301423070.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Jeff Garzik wrote:
> 
> Ya know, sorting those lists causes this problem, too...  usb.o is
> listed first in the various lists, as is usbcore.o.  Is it possible to
> avoid sorting?  Doing so will fix this, and also any other link order
> breakage like this that exists, too.

This is the right fix. We MUST NOT sort those things.

The only reason for sorting is apparently to remove the "multi-objs"
things, and replace them with the object files they are composed of.

To which I say "Why?"

It makes more sense to just leave the multi's there.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
