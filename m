Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbQJ3Xen>; Mon, 30 Oct 2000 18:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbQJ3Xed>; Mon, 30 Oct 2000 18:34:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:65030 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129837AbQJ3XeU>;
	Mon, 30 Oct 2000 18:34:20 -0500
Date: Tue, 31 Oct 2000 00:32:57 +0100
Message-Id: <200010302332.AAA15959@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com> you wrote:


> We should just link it in the order specified:

> 	ld -r usbdrv.o $(obj-y)
>
> [...]
>
> Then we change the meaning of OX_OBJS, and instead of saying
>
> 	ALL_O = $(OX_OBJS) $(O_OBJS)
>
> we just say
>
> 	ALL_O = $(O_OBJS)
>
> and the meaning of $OX_OBJS is the _subset_ of object file that have
> SYMTAB objects.
>
> This should all work pretty much as-is, with som every simple
> modifications to existing old-style Makefiles,

It is simple - but a change in _every_ makefile is required.
And it is not really needed for old-style makefiles.

Would you accept a patch that makes the new-styles include
a separated Makefile library (e.g. $(TOPDIR)/Makefile.inc)
and leaves the old-style one as is (in hope of eleminating
them fast)?

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
