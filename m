Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUEGIcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUEGIcG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUEGIcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:32:06 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:22503 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S262960AbUEGIb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:31:58 -0400
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: <linux-kernel@vger.kernel.org>
Subject: Strange Linux behaviour!?
Date: Fri, 7 May 2004 10:33:02 +0200
Organization: linux-kernel.at
Message-ID: <013001c4340d$e9860470$d50110ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <409B4494.5253316B@melbourne.sgi.com>
Importance: Normal
X-MailScanner-Information-linux-kernel.at: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner-linux-kernel.at: Found to be clean
X-MailScanner-From: oliver@linux-kernel.at
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

Strange things are happinging some times, and here we have a new. :-)

We have a machine with five partitions mounted. One of those partitions
is /usr. We can created files on /usr, but we cannot created
directories. mkdir says, that there is no space left on device, but
there actually IS space as you can see and files can be created, so why
NO directories? Is it the kernel, is it the filesystem, is it the full
moon high in the sky? :-) I have no clue, but maybe you have... Any
help/idea is welcome!

Please have a look at this log:

uname -a
Linux apache2.dev.xxx.at 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686
unknown

mount -l
/dev/sda7 on / type ext3 (rw) [/]
none on /proc type proc (rw)
/dev/sda1 on /boot type ext3 (rw) [/boot]
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
/dev/sda6 on /tmp type ext3 (rw) [/tmp]
/dev/sda2 on /usr type ext3 (rw) [/usr]
/dev/sda5 on /var/log type ext3 (rw) [/var/log]

df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda7              10G  1.9G  8.0G  19% /
/dev/sda1              38M   15M   21M  40% /boot
none                  504M     0  503M   0% /dev/shm
/dev/sda6             243M  103M  128M  45% /tmp
/dev/sda2             4.8G  703M  3.8G  16% /usr
/dev/sda5             648M   19M  597M   3% /var/log
/usr

cd /usr
mkdir test
mkdir: cannot create directory `test': No space left on device

cd /tmp
mkdir test
ls
drwxr-xr-x    2 root     root         1024 May  7 09:08 test

mkdir --version
mkdir (fileutils) 4.1
Written by David MacKenzie.

Copyright (C) 2001 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

Best regards,
 Oliver

PS: Please CC answers to dh@uptime.at

