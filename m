Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVLHQKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVLHQKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVLHQKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:10:52 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:3519 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1751222AbVLHQKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:10:52 -0500
Subject: Problem with using spinlocks when kernel is compiled without
	smp-support
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 17:10:09 +0100
Message-Id: <1134058209.24458.10.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew!

I have the following problem on 2.6.15-rc5-mm1

When compiling a module using spinlocks I get the following
error-message, when SMP is disabled in my Kernel-config:




In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
include/asm/spinlock.h:21:1: warning: "__raw_spin_is_locked" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/kobject.h:23,
                 from include/linux/device.h:16,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
include/linux/spinlock_up.h:61:1: warning: this is the location of the
previous definition
In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
include/asm/spinlock.h:51: error: syntax error before 'do'
include/asm/spinlock.h: In function '__raw_spin_lock_flags':
include/asm/spinlock.h:62: error: 'struct <anonymous>' has no member
named 'slock'
include/asm/spinlock.h:60: error: invalid lvalue in asm output 0
include/asm/spinlock.h: At top level:
include/asm/spinlock.h:65: error: syntax error before '{' token
include/asm/spinlock.h:89: error: syntax error before 'do'
In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
include/asm/spinlock.h:114:1: warning: "__raw_spin_unlock_wait"
redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/kobject.h:23,
                 from include/linux/device.h:16,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
include/linux/spinlock_up.h:71:1: warning: this is the location of the
previous definition
In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
include/asm/spinlock.h:142:1: warning: "__raw_read_can_lock" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/kobject.h:23,
                 from include/linux/device.h:16,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
include/linux/spinlock_up.h:68:1: warning: this is the location of the
previous definition
In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
include/asm/spinlock.h:148:1: warning: "__raw_write_can_lock" redefined
In file included from include/linux/spinlock.h:90,
                 from include/linux/kobject.h:23,
                 from include/linux/device.h:16,
                 from include/linux/genhd.h:15,
                 from include/linux/blkdev.h:6,
                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
include/linux/spinlock_up.h:69:1: warning: this is the location of the
previous definition
include/asm/spinlock.h: In function '__raw_read_unlock':
include/asm/spinlock.h:181: error: 'struct <anonymous>' has no member
named 'lock'
include/asm/spinlock.h:181: error: invalid lvalue in asm output 0
include/asm/spinlock.h: In function '__raw_write_unlock':
include/asm/spinlock.h:187: error: 'struct <anonymous>' has no member
named 'lock'
include/asm/spinlock.h:186: error: invalid lvalue in asm output 0



shouldn't it be possible to use spinlocks in my code even if I don't
support SMP for compatiblity ?


Dirk 

