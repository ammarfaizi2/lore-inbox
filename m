Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131046AbRCJS1m>; Sat, 10 Mar 2001 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRCJS1c>; Sat, 10 Mar 2001 13:27:32 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:63758 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S131046AbRCJS1P>; Sat, 10 Mar 2001 13:27:15 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Kernel 2.4.1 on RHL 6.2
Date: Sat, 10 Mar 2001 18:28:09 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <98drnp$qq0$1@ncc1701.cistron.net>
In-Reply-To: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii> <200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com>
X-Trace: ncc1701.cistron.net 984248889 27456 195.64.65.67 (10 Mar 2001 18:28:09 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com>,
Stephen "M." Williams  <rootusr@midsouth.rr.com> wrote:
>Make sure you have the following symlinks in your /usr/include
>directory, assuming you're on an x86 machine:
>
>asm -> /usr/src/linux/include/asm-i386/
>linux -> /usr/src/linux/include/linux/

Note! You only have to have those symlinks on broken systems such
as Redhat.

Sane systems such as Debian have a copy of the kernel header files
that the C library was compiled against in /usr/include/{linux,asm}
instead of symlinks to the kernel source. Do not play the symlink
trick on those systems.

Before this turns into a flamewar: this has been discussed 20 or
so times before, and both Linus and the glibc developers agree
that you a distribution should do the latter. The headers you use
to compile userland binaries should be the same as the C library
was compiled against.

If you need to compile a standalone module use -I/usr/src/linux/include

Mike.
-- 
Go not unto the Usenet for advice, for you will be told both yea and nay (and
quite a few things that just have nothing at all to do with the question).
	-- seen in a .sig somewhere

