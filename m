Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319272AbSH2R1K>; Thu, 29 Aug 2002 13:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319273AbSH2R1K>; Thu, 29 Aug 2002 13:27:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319272AbSH2R1J>;
	Thu, 29 Aug 2002 13:27:09 -0400
Date: Thu, 29 Aug 2002 10:30:14 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "Mikolaj J. Habryn" <dichro-evo@rcpt.to>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.32 floppy init and misc fixes
In-Reply-To: <15725.63043.601068.257742@kim.it.uu.se>
Message-ID: <Pine.LNX.4.33L2.0208291008050.2390-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Mikael Pettersson wrote:

| Floppy has many more problems.
| Repeadedly loading and unloading the floppy.o module corrupts
| sys_device data structures.
| Writing to floppy can give ENOSPC errors even though space exists.
| Writing to floppy can OOPS the kernel due to a NULL pointer error.
| VFS-over-floppy corrupts data since 2.5.13.
| Putting lilo on ext2 on floppy can cause a kernel hang due to an
| infinite loop of "buffer layer error".
|
| I have a patch which fixes the {,un}register_sys_device() bugs, NULL
| queue bug, zero i_size bug, and fixes read/write enough that raw media
| access (e.g. tar or dd to/from /dev/fd0) works. It's in the 2.5-dj tree,
| and separately in <http://www.csd.uu.se/~mikpe/linux/patches/2.5/>.
|
| I havent' pushed this to Linus since it's meaningless as long as
| the VFS data corruption exists. It was broken by blkdev/VFS changes,
| but those responsible haven't yet bothered to repair it.

I would add one more: select delay timings are same as in 2.4:
#define SEL_DLY (2*HZ/100)
but HZ is not the same as in 2.4...

-- 
~Randy

