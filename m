Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWRIV>; Thu, 23 Nov 2000 12:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWRIL>; Thu, 23 Nov 2000 12:08:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:47881 "EHLO ns.caldera.de")
        by vger.kernel.org with ESMTP id <S129097AbQKWRHy>;
        Thu, 23 Nov 2000 12:07:54 -0500
Date: Thu, 23 Nov 2000 17:37:11 +0100
Message-Id: <200011231637.RAA25892@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: tori@tellus.mine.nu (Tobias Ringstrom)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Too long network device names corrupts kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.21.0011231642110.32263-100000@svea.tellus>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0011231642110.32263-100000@svea.tellus> you wrote:
> Btw, does anyone know of a C function that works like strncpy, but does
> add a terminating null character, event if the string does not fit, ro
> does one have to do str[5]=0 first, and then strncpy(str,src,4)?

strlcpy.

Check 'http://www.FreeBSD.org/cgi/man.cgi?query=strlcpy&apropos=0&sektion=0&
manpath=OpenBSD+2.6&format=html' for details.

Originally for OpenBSD, most UNICES (NetBSD, FreeBSD, Solaris,
UnixWare, OpenServer) have it in libc now.

Glibc is missing it because my patch did not get accepted.

If there is interest in having this in the kernel I could come up with a patch.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
