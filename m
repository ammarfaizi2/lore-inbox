Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKTWDW>; Wed, 20 Nov 2002 17:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSKTWCT>; Wed, 20 Nov 2002 17:02:19 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.23]:10432 "EHLO
	mhw.ulib.iupui.edu") by vger.kernel.org with ESMTP
	id <S261733AbSKTV6j>; Wed, 20 Nov 2002 16:58:39 -0500
Date: Wed, 20 Nov 2002 17:05:45 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: One more time:  /usr/include/linux, /usr/include/asm
Message-ID: <Pine.LNX.4.33.0211201643180.359-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built a new glibc.  (Yes, I do that.)  Recalling that the
above-mentioned paths are (according to Linus and many others) not
supposed to be links to /usr/src/linux or any other kernel-kit-du-jour, I
resolved to be a good boy and get rid of those links.  For some reason I
expected that 'make install' for glibc would create directories there and
put into them whatever it wanted.  I recall that that was discussed....

No dice.  glibc 2.3.1 still installs headers into /usr/include/{VARIOUS}
which refer to /usr/include/linux and /usr/include/asm but does not supply
that to which they refer.  *sigh*  After rummaging through several long
threads in the archives, I still don't have an answer to the following:

1. What is supposed to be in /usr/include/linux and /usr/include/asm?
2. Where does the information come from?
3. Who is responsible for putting it there?

(Just to get my system back to a state in which I can compile userspace
stuff, I made the following assumptions:

1. Everything from linux/include/linux resp. linux/include/asm-$ARCH .
2. The kernel kit which supplied the headers used to build glibc.
3. The person building glibc.

IOW I just copied wholesale those two directories from the kernel kit
which I had nominated with configure --with-headers, to /usr/include.)

I note that the glibc 2.3.1 instructions *still* instruct the reader to
symlink these paths into "the 2.2 kernel sources".  (See "Specific advice
for GNU/Linux systems" in INSTALL.)  I'll happily submit a glibc bug
report, or documentation patches, or some such, just so long as someone
can give me answers which work both for the kernel and for the library.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

