Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129205AbQKOA5R>; Tue, 14 Nov 2000 19:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKOA5G>; Tue, 14 Nov 2000 19:57:06 -0500
Received: from [213.8.185.152] ([213.8.185.152]:20233 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129047AbQKOA4v>;
	Tue, 14 Nov 2000 19:56:51 -0500
Date: Wed, 15 Nov 2000 02:25:38 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.10.10011141546140.972-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011150216460.28006-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Linus Torvalds wrote:

> On Wed, 15 Nov 2000, Dan Aloni wrote:
> >
> > summery: dev_3c501.name shouldn't be NULL, or we get oops
> 
> Note that these days "name" is not a pointer at all, but an array, and as
> such cannot be NULL any more. Not initializing it will just cause it to be
> empty (ie is the same as initializing it to "").

Agreed. BTW, after grepping for IFNAMSIZ references I've noticed some
architectures (sparc64, mips64) define IFNAMSIZ for themsleves, for
example, arch/sparc64/kernel/ioctl32.c, which defines it to 16, the
same include/linux/if.h does. But if they are not the same?

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
