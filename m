Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSGXS4K>; Wed, 24 Jul 2002 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSGXS4K>; Wed, 24 Jul 2002 14:56:10 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:62008 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S317491AbSGXS4J>; Wed, 24 Jul 2002 14:56:09 -0400
Date: Wed, 24 Jul 2002 14:59:19 -0400
From: Kareem Dana <kareemy@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: loop.o device busy after umount
Message-Id: <20020724145919.01c79fce.kareemy@earthlink.net>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've noticed in kernel 2.4.18 that my loop module remains busy after I umount the device using it. For example

mount -t iso9660 -o loop file.iso /mnt
* loop module gets loaded
* lsmod shows "loop                    7952   1 (autoclean)"
* ps ax shows [loop0] process

then
umount /mnt
lsmod shows the same thing - specifically the use of loop as 1 and the [loop0] process remains open. Trying to rmmod loop gives me a device or resource busy error.

lsof gives the following output:

loop0     3765 root  cwd    DIR        8,1    4096         2 /
loop0     3765 root  rtd    DIR        8,1    4096         2 /

So I'm wondering why the loop module still remains in use after I umount the file that required it? Should it stay in use? Is there a way to change that behavoir or be able to rmmod the module without a reboot?

(Please CC replies to me personally)

Thank You
Kareem

