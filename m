Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131105AbRAaOlB>; Wed, 31 Jan 2001 09:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbRAaOkw>; Wed, 31 Jan 2001 09:40:52 -0500
Received: from web118.mail.yahoo.com ([205.180.60.99]:57093 "HELO
	web118.yahoomail.com") by vger.kernel.org with SMTP
	id <S131105AbRAaOkj>; Wed, 31 Jan 2001 09:40:39 -0500
Message-ID: <20010131144038.26689.qmail@web118.yahoomail.com>
Date: Wed, 31 Jan 2001 06:40:38 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Why isn't init PID 1?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a bootable linux CD that runs a custom init. 
Under most versions of linux init runs as process ID
one.  Under my bootable CD, it runs as process ID 15. 
I need it to run as PID 1 so that I can execute a
kill(-1,15) without killing init.

The boot CD uses and initrd image to load drivers. 
The linuxrc file looks like:

#!/bin/sash

aliasall

echo "Loading aic7xxx module"
insmod /lib/aic7xxx.o
echo "Loading ips module"
insmod /lib/ips.o ips=ioctlsize:512000
echo "Loading sg module"
insmod /lib/sg.o
echo "Loading FAT modules"
insmod /lib/fat.o
insmod /lib/vfat.o

echo "Mounting /proc"
mount -t proc /proc /proc
init
umount /proc

Does it run as PID 15 because I execute insmod and
mount before running init?

Thanks,
Paul

__________________________________________________
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
