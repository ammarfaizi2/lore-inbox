Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbRESLKx>; Sat, 19 May 2001 07:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbRESLKn>; Sat, 19 May 2001 07:10:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16077 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261758AbRESLK3>;
	Sat, 19 May 2001 07:10:29 -0400
Date: Sat, 19 May 2001 13:09:43 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191109.NAA53719.aeb@vlet.cwi.nl>
To: bcrl@redhat.com, torvalds@transmeta.com
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben LaHaise <bcrl@redhat.com>

    3. Userspace partition code proposal

        Given the above two bits, here's a brief explaination of a
        proposal to move management of the partitioning scheme into
        userspace, along with portions of raid startup, lvm, uuid and
        mount by label code needed for mounting the root filesystem.

        Consider that the device node currently known as /dev/hda5 can
        also be viewed as /dev/hda at offset 512000 with a limit of 10GB.
        With the extensions in fs/block_dev.c, you could replace /dev/hda5
        with /dev/hda/offset=512000,limit=10240000000.  Now, by putting
        the partition parsing code into a libpart and binding mount to a
        libpart, the root filesystem mounting code can be run out of an
        initrd image.  The use of mount gives us the ability to mount
        filesystems by UUID, by label or other exotic schemes without
        having to add any additional code to the kernel.

    I'm going to stop writing this now.  I need sleep...

Hmm. You know that I wrote this long ago?
And that it has been part of the kernel for a long time?
And that there are user space utilities that use it?

In util-linux, look at the partx subdirectory.
In the kernel, read drivers/block/blkpg.c.

Andries
