Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTBQQjV>; Mon, 17 Feb 2003 11:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBQQjV>; Mon, 17 Feb 2003 11:39:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:11942 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267154AbTBQQjH>; Mon, 17 Feb 2003 11:39:07 -0500
Date: Mon, 17 Feb 2003 08:48:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <2460000.1045500532@[10.10.2.4]>
In-Reply-To: <1045482621.29000.40.camel@passion.cambridge.redhat.com>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Added a journal to my root disk.
>> Mounted it ext3.
>> Found it scaled like crap
>> set my fstab back to ext2
>> /dev/sda2       /               ext2    defaults,errors=remount-ro      0   1
>> reboot.
>> Disk says it's mounted ext2 ("mount\n")
>> Still performs like crap.
>> 
>> Mmmmm ... it STILL mounts ext3.
>> Allegedly this is a "feature".
>> Can we please remove this stupidity?
>> 
> If I say I want ext2, I want ext2 ....

Got several replies saying more or less the same thing ...
 
> Do you expect the kernel to read your /etc/fstab before mounting the
> root file system, and then obey it?

No, but it remounts the disk read-write after it mounts it read-only.
It can switch from ext2 to ext3 at that point.
 
> Boot with 'rootfstype=ext2' 

That works, but I don't see why I should have to specify additional
commandline options.

> and/or tune2fs -O ^has_journal /dev/sda2

Can't - it refuses to touch the disk it's standing on even in single user.
This makes it extremely difficult to revert.

And in answer to some other questions:

This machine can't boot off CD, so rescue disks are not an option.
It's remote anyway, and I shouldn't have to screw around with it to do this.
I'm not using initrd

The point remains, if I say I want ext2, I should get ext2, not whatever 
some random developer decides he thinks I should have. Worst of all,
the system then lies to you and says it's mounted ext2 when it's not.

M.

