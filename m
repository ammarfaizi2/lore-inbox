Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbQLWHmb>; Sat, 23 Dec 2000 02:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbQLWHmV>; Sat, 23 Dec 2000 02:42:21 -0500
Received: from c1075343-a.spngfld1.il.home.com ([24.14.189.192]:3591 "EHLO
	bastion.yi.org") by vger.kernel.org with ESMTP id <S129998AbQLWHmJ>;
	Sat, 23 Dec 2000 02:42:09 -0500
Message-ID: <20001223021615.A8201@bastion.sprileet.net>
Date: Sat, 23 Dec 2000 02:16:15 -0600
From: Damacus Porteng <kernel@bastion.yi.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Arg.  File > 2GB removal
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For grins, I did `dd if=/dev/zero of=testfile bs=1024 count=4000000` 

Obviously, with the limits of ext2, this isn't allowed, however, dd continued
marrily on its way, tho it spouted an error...

I cancelled the dd and went to remove the file, though the following occured:
root@obfuscated:/home/ftp# rm testfile
rm: cannot remove `testfile': Value too large for defined data type     

'ls' complains about the same.  I ran e2fsck -f /dev/hde6 (the partition of
/home) and it didn't 'find' the problem.

How do I remove this file and reclaim the HDD space?

Thanks,

D.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
