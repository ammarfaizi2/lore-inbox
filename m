Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274001AbRISEdR>; Wed, 19 Sep 2001 00:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRISEdH>; Wed, 19 Sep 2001 00:33:07 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:39177 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274001AbRISEcw>; Wed, 19 Sep 2001 00:32:52 -0400
X-Apparently-From: <swansma@yahoo.com>
Message-ID: <3BA7FF92.D6477904@yahoo.com>
Date: Tue, 18 Sep 2001 22:14:42 -0400
From: Mark Swanson <swansma@yahoo.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.8-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Request: removal of fs/fs.h/super_block.u to enable partition locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why?

So I can write and distribute a GPL'd 'inuse' filesystem module
that essentially registers a partition as in-use.

I am writing an application that uses raw I/O and I need
some way of locking a partition. The only
way I know of (sortof) doing this is by registering a filesystem
for the partition so system utilities won't overwrite the partition
because they will see it is busy by examining /proc/partitions.

lockf()
on /dev/hda1 doesn't stop root from mounting the partition
as a swap partition or accidentally formatting it
even though the root partition was mounted with 'mand' to 
enable mandatory locking and a 'chmod 2660 /dev/hda1' was done 
to enable mandatory locking on the file.

I'm trying to look out for tired sys-admins who might 
destroy my application's partition not knowing
what a particular empty-looking partition is used for.

Thoughts?

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

