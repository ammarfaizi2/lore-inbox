Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKMQiv>; Mon, 13 Nov 2000 11:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQKMQim>; Mon, 13 Nov 2000 11:38:42 -0500
Received: from relay.lep-philips.fr ([212.208.209.250]:7051 "EHLO
	relay.lep-philips.fr") by vger.kernel.org with ESMTP
	id <S130023AbQKMQie>; Mon, 13 Nov 2000 11:38:34 -0500
Message-ID: <3A101A47.A549082A@lep-philips.fr>
Date: Mon, 13 Nov 2000 17:43:51 +0100
From: Guillaume Jaunet <jaunet@lep-philips.fr>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: fr, en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: mount -o loop  problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm working on an ARM Linux box, using kernel 2.4.0-test9 and
util-linux-2.10p

I'm trying to mount an image of a ramdisk in order to modify it. I
entered
the following command :

mount -o loop -t ext2 ramdisk_ks /mnt/ramdisk

But this command fails. I get no output messages, loose control over
the box but I'm sure the scheduler is still running.

I thought about memory lack (the kernel would do calls to free some) but
I've still got 12Mb of available memory to mount a 8Mb ramdisk.

I've compiled kernel with loopback support, the ramdisk_ks file is the
decompressed image of my ramdisk and the mount point exists.

I've debugged the mount program with gdb, and it seems that the problem
is in the kernel : I can get to the mount system call, and then it
"hangs".

I've seen this specific point as been worked on recently and was
wondering if there wasn,t something wrong with it.

Guillaume J.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
