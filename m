Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRJNATF>; Sat, 13 Oct 2001 20:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJNASz>; Sat, 13 Oct 2001 20:18:55 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:33176 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S272244AbRJNASn>; Sat, 13 Oct 2001 20:18:43 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 13 Oct 2001 17:19:13 -0700
Message-Id: <200110140019.RAA12016@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Documentation on address_space_operations?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I would appreciate any specific pointers to documentation
on the exact semantics of the functions declared in struct
address_space_operations.  The exact division of labor between
writepage, sync_page, prepare_write, commit_write, and direct_IO
is not obvious to me, to say the least.

	This is especially relevant to me because the ramdisk code
was changed to use struct address_space_operations around 2.4.11-pre6,
causing my change that allowed the ramdisk contents to be usable even
if filesystems that had different block sizes were compiled into the
kernel (for example, if you compile in cramfs and romfs with the stock
kernels, you initial ramdisk cannot be in romfs format because the
block size change between cramfs and romfs will cause all data to be lost).
A couple of years ago, I had posted my fix for this to linux-kernel based
on old IO method, but the change was never integrated into the official
kernels.  I would like to try to develop and updated fix for the new
ramdisk code.  (I would also like to port the change that somebody made
around 2.3.43 to have the ramdisk driver drop pages that consists of all
zeroes, although that is less important.)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
