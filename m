Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbRESJ7M>; Sat, 19 May 2001 05:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbRESJ6x>; Sat, 19 May 2001 05:58:53 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:34320 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S261726AbRESJ6w>;
	Sat, 19 May 2001 05:58:52 -0400
To: bcrl@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in
 userspace
Newsgroups: linux.fsdevel,linux.kernel
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
Message-Id: <20010519094224.AD5A236DDC@hog.ctrl-c.liu.se>
Date: Sat, 19 May 2001 11:42:24 +0200 (CEST)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com> you write:
>3. Userspace partition code proposal
>
>	Given the above two bits, here's a brief explaination of a
>	proposal to move management of the partitioning scheme into
>	userspace, along with portions of raid startup, lvm, uuid and
>	mount by label code needed for mounting the root filesystem.
>
>	Consider that the device node currently known as /dev/hda5 can
>	also be viewed as /dev/hda at offset 512000 with a limit of 10GB.
>	With the extensions in fs/block_dev.c, you could replace /dev/hda5
>	with /dev/hda/offset=512000,limit=10240000000.  Now, by putting
>	the partition parsing code into a libpart and binding mount to a
>	libpart, the root filesystem mounting code can be run out of an
>	initrd image.  The use of mount gives us the ability to mount
>	filesystems by UUID, by label or other exotic schemes without
>	having to add any additional code to the kernel.

The only problem I can see with this is that it removes one useful thing,
the ability to give a user access to a whole partition.

    chown wingel /dev/hda5

won't work anymore since there is no such device node.  

  /Christer
-- 
"Just how much can I get away with and still go to heaven?"
