Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbULZAet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbULZAet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 19:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbULZAet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 19:34:49 -0500
Received: from mail.aknet.ru ([217.67.122.194]:8209 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261598AbULZAer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 19:34:47 -0500
Message-ID: <41CE0723.8030008@aknet.ru>
Date: Sun, 26 Dec 2004 03:34:43 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: bug: cd-rom autoclose no longer works in 2.6.9/2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

CD-ROM autoclose stopped working for
me quite some time ago. I used to type
only "mount /mnt/cdrom" and that took
care about closing, but now I am getting
this:
---
$ mount /mnt/cdrom
mount: No medium found
---
so I have to do "eject -t" first.
I can reproduce this problem on 2
completely different machines, so I
don't think this have something to
do with the particular hardware.
The configuration haven't changed
either:

$ cat /proc/sys/dev/cdrom/autoclose
1

$ cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17
 
drive name:             hdd
drive speed:            50
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           0
Can write DVD-R:        0
Can write DVD-RAM:      0
Can read MRW:           1
Can write MRW:          1
Can write RAM:          1

