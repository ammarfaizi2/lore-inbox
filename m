Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272869AbRIMFtD>; Thu, 13 Sep 2001 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272870AbRIMFsx>; Thu, 13 Sep 2001 01:48:53 -0400
Received: from [203.35.254.67] ([203.35.254.67]:33545 "EHLO
	once-ler.syd.bluefishwireless.com") by vger.kernel.org with ESMTP
	id <S272867AbRIMFsi>; Thu, 13 Sep 2001 01:48:38 -0400
Date: Thu, 13 Sep 2001 15:48:55 +1000
From: Matt <matt@bluefishwireless.com>
To: linux-kernel@vger.kernel.org
Cc: procps-bugs@redhat.com
Subject: struct_task->start_time, jiffies or hz_to_std(jiffies)
Message-ID: <20010913154855.B628@bluefishwireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-OperatingSystem: Linux version 2.4.9-ac10 (root@ham) (gcc version 2.95.4 20010902 (Debian prerelease))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

given

2.4.9-ac10 linux/kernel/fork.c:658
        p->start_time = jiffies;

is this

2.4.9-ac10 linux/fs/proc/array.c
                task->start_time,

correct? or should it be
		hz_to_std(task->start_time),

??

i know this will affect libproc, however libproc appears to be broken
anyway; i changed HZ and CLOCKS_PER_SEC to 1024 in include/asm/param.h
on x86 and top / ps etc are giving me very whacked out numbers.. the
machine itself is stable however and appears to be working just fine.

	matt

