Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313560AbSDZA0g>; Thu, 25 Apr 2002 20:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313562AbSDZA0f>; Thu, 25 Apr 2002 20:26:35 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:45409 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313560AbSDZA0d>; Thu, 25 Apr 2002 20:26:33 -0400
Subject: [BK-Patch-2.5.10] NTFS 2.0.2 submission for kernel inclusion
From: Anton Altaparmakov <aia21@cantab.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 01:26:31 +0100
Message-Id: <1019780791.10304.115.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I would like to submit the new NTFS driver to you for inclusion into the
2.5 kernel series.

Al Viro had a look over the code a few months ago and I would like to
thank him for all the feedback/comments/criticisms which resulted in a
much cleaner driver in the end. He said yesterday that if I don't hear
from him until today, I can assume he is ACKing the new driver for
inclusion. I haven't heard from him, so I guess this is a good sign. (-:

The driver is read-only at present but once it is included in the
kernel, we will begin developing write support. Otherwise the new driver
is a major improvement over the old one - it is a complete rewrite using
the page cache to its full extent both for data and metadata, doesn't
use the big kernel lock at all, is fully SMP, preemption, and endianness
safe, and I haven't had a single bug report in over a month, but I have
had several good reports, so I think it is ready to be added to the
kernel.

No core kernel code is modified at all, except for adding an export for
fs/buffer.c::end_buffer_io_sync() to kernel/ksyms.c.

It would be great if you would do a bk pull from the ntfs tng bkbits
repository:

        http://linux-ntfs.bkbits.net/ntfs-tng-2.5

If you would prefer a bitkeeper patch inline with an email, please let
me know and I will generate one and email it to you ASAP...

Best regards,

        Anton

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/
