Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRAABKx>; Sun, 31 Dec 2000 20:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRAABKn>; Sun, 31 Dec 2000 20:10:43 -0500
Received: from mail.inconnect.com ([209.140.64.7]:47279 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S130337AbRAABKc>; Sun, 31 Dec 2000 20:10:32 -0500
Date: Sun, 31 Dec 2000 17:40:05 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-prerelease IEEE1394 problem
In-Reply-To: <87bstskv6z.fsf@penny.ik5pvx.ampr.org>
Message-ID: <Pine.SOL.4.30.0012311651550.477-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't been able to compile IEEE1394 into the kernel since test12.

I get the error:

ld: cannot open drivers/ieee1394/ieee1394.a: No such file or directory
make: *** [vmlinux] Error 1
[root@thud linux]#

When I compile it completely modular, it works fine.


This works:

# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

This doesn't:

# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
