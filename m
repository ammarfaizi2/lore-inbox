Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBQQWC>; Sat, 17 Feb 2001 11:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBQQVw>; Sat, 17 Feb 2001 11:21:52 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:48908 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129227AbRBQQVl>;
	Sat, 17 Feb 2001 11:21:41 -0500
Date: Sat, 17 Feb 2001 17:21:18 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: mason@suse.com, reiser@namesys.com
Subject: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010217172118.A5737@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

Well, subject says it all... When I try to compile mozilla (CVS version) with
the '--enable-elf-dynstr-gc' option, the compile fails with a segfault:

../../dist/bin/elf-dynstr-gc ../../dist/lib/components/libsample.so
make[2]: *** [install] Segmentation fault (core dumped)

compiling the same codebase on an ext2 filesystem does not produce this
segfault. When I compare the produced library (libsample.so), there is a
consistent difference between the one compile on the reiserfs and the ext2
filesystem. Running objdump on the reiserfs-compiled library also produces
errors (some assertion failures, a lot of 'invalid string offset' errors, and
finally a 'Memory exhausted' error), while objdump happily disassebles the
ext-produced binary.

These problems occur on:

 2.4.1
 2.4.2-pre4
 2.4.2-pre4 with Chris Mason's 'reiserfs fix for null bytes in small files'

So, there's something quite wrong here.

If anyone wants me to try something, do tell...

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
