Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbREWQKR>; Wed, 23 May 2001 12:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbREWQKH>; Wed, 23 May 2001 12:10:07 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:16105 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S263145AbREWQKA>; Wed, 23 May 2001 12:10:00 -0400
Date: Wed, 23 May 2001 12:09:36 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: debugging xterm. 
In-Reply-To: <Pine.LNX.4.33.0105220926100.1590-100000@asdf.capslock.lan>
Message-ID: <Pine.GSO.4.33.0105231205310.22273-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > gdb seems to get lost when calling getuid), any idea?
> >Is there something special about getuid() I'm missing?
> >
> >(gdb) next
> >1612                uid_t ruid = getuid();
> >2: screen->respond = 1448543468
> >(gdb) next
> >1613                gid_t rgid = getgid();
> >2: screen->respond = Cannot access memory at address 0x4

> This has nothing to do with the Linux kernel whatsoever.  Please
> send your request to xpert@xfree86.org for help.

It is easy to flame people.

In this particular case you really couldn't tell. It COULD have been
kernel, it could have been GDB, or it could have been GCC. Kernel was as
good guess as any other. (it is unlikely though it could have been X).

In this particular case it turns out it was either gdb or gcc. Since while
man page says you can use "-g" and "-O2" together, in practice I had to
remove the "-O2" in order to unconfuse gdb in the above example.

This or other way, when I got past this problem, I finally managed to fix
the decade old bug in XTERM which I was hunting after. For those curious
patch is at http://www.eax.com/patches/xterm2.diff

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

