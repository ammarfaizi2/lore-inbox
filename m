Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315189AbSEDTOz>; Sat, 4 May 2002 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315186AbSEDTOy>; Sat, 4 May 2002 15:14:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57082 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315180AbSEDTOx>;
	Sat, 4 May 2002 15:14:53 -0400
Date: Sat, 4 May 2002 15:14:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Koenig <ChristianK.@t-online.de>
cc: linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: [PATCH] initramfs
In-Reply-To: <1744hw-0EYlYuC@fwd01.sul.t-online.com>
Message-ID: <Pine.GSO.4.21.0205041509300.23892-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 May 2002, Christian Koenig wrote:

> It isn't complete yet, because off the following unresolved topics:
> 1. For the moment it only supports files,dirs and symlinks.
> 2. It still needs the "RAM disk" and "initrd" support compiled in the Kernel.
> 3. I haven't tried to support hardlinks.
> 4. Since i use the ramdisk for decompression the cpio image must be a 
> multiple of BLOCK_SIZE bytes.
> 5. The cpio crc field is ignored.

Uhh....  Why?  I can post initramfs patches tonight - unpacking and populating
initramfs is trivial and I can't think of any reason why initrd would be
useful here (BTW, you could have picked uncpio code from l-k posting -
3Kb, deals with links properly, doesn't mess with ramdisk at all).
 
Anyway, the real problem with iniramfs is on the build side.  I.e. what
do we want in makefiles for early userland/what do we want to use as
libc?

Until that is done the ungzip/uncpio part is pretty much pointless...  It
can go into the kernel anytime, but what would it give us if we don't have
stuff to put in there?

