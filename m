Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBCItx>; Sat, 3 Feb 2001 03:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbRBCIte>; Sat, 3 Feb 2001 03:49:34 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:60681 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129035AbRBCItc>; Sat, 3 Feb 2001 03:49:32 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <12656.981169803@ocs3.ocs-net>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 03 Feb 2001 08:48:54 +0000
In-Reply-To: <12656.981169803@ocs3.ocs-net> (Keith Owens's message of "Sat, 03 Feb 2001 14:10:03 +1100")
Message-ID: <m2d7d0up6x.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

>   Basically, that symlink should not be a symlink.  It's a symlink for
>   historical reasons, none of them very good any more (and haven't been
>   for a long time), and it's a disaster unless you want to be a C
>   library developer.  Which not very many people want to be.
> 
>   The fact is, that the header files should match the library you link
>   against, not the kernel you run on."

So what is your advice?  Would the "correct" action be to take a
snapshot of the appropriate kernel directories against which glibc is
built? (ie to copy the directories (or those files needed) to
/usr/include/asm and /usr/include/linux)

On the other hand, if you are building "system level" tools (eg which
communicate with device drivers directly using IOCTLs) you may need to
use the kernel header files, in which case I suppose you should
include them from the kernel source tree not /usr/include.

In both case, I think the problem is not so much in code which you
write yourself (where you control include paths etc) but in building
3rd party applications which may not have used the "correct" include
paths and therefore will not build "out of the box".
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
