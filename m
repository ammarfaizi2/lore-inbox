Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCPOMm>; Fri, 16 Mar 2001 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130129AbRCPOMd>; Fri, 16 Mar 2001 09:12:33 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:5812 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S130457AbRCPOMX>;
	Fri, 16 Mar 2001 09:12:23 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AB21DB5.7030105@ksu.ru>
Date: Fri, 16 Mar 2001 17:05:41 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk@arm.linux.org.uk>, Mike Galbraith <mikeg@wen-online.de>
Subject: union mounts WAS: pivot_root & linuxrc problem
In-Reply-To: <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One more thing I was wondering about,

is the pivot_root call the *final* implementation of the "root 
filesystem changer" for kernle 2.4.*?

I've read about a new VFS extension, that allows multiple filesystems to be
stacked at a single mount point. As I have understood it allows to 
*just* mount
a new filesystem over the old one and unmount the old one.
Is it finally going to come instead of pivot_root?

The reason I'm so interested is the opportunity
to freely change root, for example,
from initrd to harddrive, from harddrive to nfs-mount and so on..

For now I think (am I right?) I can modify sysV init with pivot_root and 
chroot calls,
so that before going to runlevel 1  it will pivot_root & chroot to some 
ramdisk for example,
and for runlevel 2 to nfs-mount. Just examples.

But what if I want to change the other partitions like /usr?
Like if workstation does not boot, because of harddrive messup,
I don't make user wait until it get fixed,
but mount all partitions  over nfs (identical to those on harddrive), 
let the user do his work,
and after localdrive fixup just mount the *real* partitions over the 
nfs-mounted, and unmount nfs, all *transparently* to user.
In my understanding thats what a new VFS extension should offer. Am I right?
If so, does anybody know when it is planned to implement that if its not 
yet?
I've seen new options for "mount" like --bind, --over, but didn't really 
get how
they work or are they implemented at all.

Would be glad if anybody could help me with this question.

Thanks,
Art. 

