Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129570AbRBLJzB>; Mon, 12 Feb 2001 04:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBLJyw>; Mon, 12 Feb 2001 04:54:52 -0500
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:7997 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S129261AbRBLJys>; Mon, 12 Feb 2001 04:54:48 -0500
From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-pre2(&3) loopback fs hang
Reply-To: klink@clouddancer.com
Message-Id: <20010212095446.28D4466945@mail.clouddancer.com>
Date: Mon, 12 Feb 2001 01:54:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>mount -o loop=/dev/loop1 net.i /var/mnt/image/

ends up in an uninterruptable sleep state (system cannot umount /
during shutdown).

The test system is a 100MHz 486 Planar wall mount, same problem with
or without modules.  The proper fs support is present in the kernel,
while CONFIG_DEVFS_FS is not set.  The linux distribution base was a
fresh slackware-current, it meets all requirements mentioned in
linux/Documentation/Changes.  Everything else tested has worked fine
so far, the 2.2.18 kernel did not have this loopback problem.


How do I track this down?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
