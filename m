Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUH3Rik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUH3Rik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUH3RhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:37:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:52717 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268650AbUH3RgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:36:10 -0400
X-Authenticated: #18607860
Message-ID: <4133659B.1000704@gmx.de>
Date: Mon, 30 Aug 2004 19:36:27 +0200
From: k7avenger <k7avenger@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: crash on 2.6.8.1 (reproducible)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel crash on the (afaik) latest kernel version 2.6.8.1, 
which is reproducible.
The kernel doesn't log anything about the crash.
It occurs when you are unmounting a ext2/3 filesystem which is prepared 
in a special way:
load it into debugfs read-write and create an inode with the number 2 ( 
mi <2> , I used to give creation time = 0 and link count = 1), then link 
that inode to . ( link <2> . ). You can mount that image now, should 
only see a directory named <2> and your system should crash immediately 
when you are unmounting that image.
I created such an image, which should work:
www.gaming-elite.de/upload/unsortiert/proof.tar.gz   ( 2.6 KB)

My ver_linux output:
______________________________________________________________
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux k7 2.6.8.1 #1 Sun Aug 22 23:27:20 CEST 2004 i686 Pentium III 
(Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
xfsprogs               2.6.3
PPP                    2.4.1
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         loop nvidia ipv6 ppp_async crc_ccitt ppp_generic 
slhc sg floppy rtc usbcore vfat fat ide_cd sr_mod scsi_mod cdrom unix
______________________________________________________________

If you have any more questions about my environment, send me an email: 
k7avenger@gmx.de
