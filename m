Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbREWP34>; Wed, 23 May 2001 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263127AbREWP3p>; Wed, 23 May 2001 11:29:45 -0400
Received: from pm489-31.dialip.mich.net ([198.110.188.41]:20154 "HELO
	tabris.domedata.com") by vger.kernel.org with SMTP
	id <S263126AbREWP30>; Wed, 23 May 2001 11:29:26 -0400
Message-ID: <3B0BD750.4010306@lycosmail.com>
Date: Wed, 23 May 2001 11:29:20 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac3 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Loopback, unable to release
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.4-ac3 (as well as in 2.4.3*) I have found it impossible to 
unmap a loopback

strace losetup -d /dev/loop0 (relevant portion)

open("/dev/loop0", O_RDONLY)            = 3
ioctl(3, LOOP_CLR_FD, 0)                = -1 EBUSY (Device or resource busy)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT 
(No such file or directory)
write(2, "ioctl: LOOP_CLR_FD: Device or re"..., 44ioctl: LOOP_CLR_FD: 
Device or resource busy) = 44
_exit(1)                                = ?

also I have loop.o as module, and use count never decreases, in fact 
right now it is at 294.

