Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUBKWoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBKWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:44:37 -0500
Received: from web9602.mail.yahoo.com ([216.136.129.181]:54337 "HELO
	web9602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266221AbUBKWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:44:34 -0500
Message-ID: <20040211224433.92148.qmail@web9602.mail.yahoo.com>
Date: Wed, 11 Feb 2004 14:44:33 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Vfat increases file permissions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am wondering about something. Why is it that when I mount a
vfat floppy disk and copy a file to the disk, it becomes
executable?

[root@linux fd_test]# umask 277
[root@linux fd_test]# touch test.txt
[root@linux fd_test]# ls -l test.txt
-r--------    1 root     root            0 Feb 11 17:20 test.txt
[root@linux fd_test]# cp test.txt /mnt/floppy/
[root@linux fd_test]# ls -l /mnt/floppy/test.txt
-rwxrwxrwx    1 root     root            0 Feb 11 17:20
/mnt/floppy/test.txt

In the DOS world, not every file is executable. It uses the file
extention to decide if the file is executable. A text file is not
implicitly executable unless it has a .bat file extention.

Is the Linux implementation interpreting something that doesn't
actually exist in the original?

I am concerned about world writeable, executable files existing
on my floppies or USB devices that are formatted vfat. This seems
like a security concern to me.

Thanks,
Steve Grubb

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
