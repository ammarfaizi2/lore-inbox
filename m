Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbQLEKtt>; Tue, 5 Dec 2000 05:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbQLEKtj>; Tue, 5 Dec 2000 05:49:39 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:45201 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130695AbQLEKt3>; Tue, 5 Dec 2000 05:49:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Dec 2000 02:18:59 -0800
Message-Id: <200012051018.CAA01847@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Any good reason why these is so much memory "reserved"?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Recently, I have had occasion to build a system on a floppy
for a 4MB machine that we use as a router.  In the past, the kernels
that we have listed something like 400kB as the amount of memory "reserved"
when they boot.  Now, they claim to reserved 4MB when configured with
CONFIG_HIGHMEM4G and 2MB when configured with CONFIG_NOHIGHMEM.  The
initial ramdisk then does not have enough space to decompress and the
system halts (out of memory and no killable process).  I am tracking
this down and fix it (because the problem of building a small system
has broader application than just this box).  My current suspicion is
that it is some problem with the "bootmem" changes of about six
months ago.  However, I thought I should post this message, in case
there is some reason why the kernel really does need have to reserve
all of this memory and that I should not try to change things back.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
