Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129333AbRBFCUv>; Mon, 5 Feb 2001 21:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbRBFCUl>; Mon, 5 Feb 2001 21:20:41 -0500
Received: from [211.100.91.213] ([211.100.91.213]:33520 "EHLO
	marvin.zhlinux.com") by vger.kernel.org with ESMTP
	id <S129333AbRBFCUZ>; Mon, 5 Feb 2001 21:20:25 -0500
Date: Tue, 6 Feb 2001 10:20:48 +0800
From: Wenzhuo Zhang <wenzhuo@zhmail.com>
To: reiserfs-list@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: mongo.sh 2.2.18: do_try_to_free_pages failed ...
Message-ID: <20010206102048.A816@zhmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got the VM error "VM: do_try_to_free_pages failed for mongo_read..."
and then I couldn't log into the system, when stress testing
reiserfs+raid0 setup on a 2.2.18 box using the reiserfs benchmark
mongo.sh. The problem was reporduceable on each run of mongo.sh.

./mongo.sh reiserfs /dev/md0 /mnt/testfs raid0-rfs 3

Thinking the raid code might cause the problem, I tested on reiserfs
only, but I got the same error message. Later, I found the same
problem running mongo.sh on an ext2 partition (stock kernel without
any patches).

I guess this problem is not reiserfs specific. What can I do now to
solve the problem?

Here is the hardware configuration of my test box:
PIII 600, 256M, Adaptec AIC-7896 SCSI controller, two Quantum SCSI
disks.

Regards,
-- 
Wenzhuo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
