Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbVD3B6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbVD3B6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 21:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVD3B6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 21:58:10 -0400
Received: from smtp2.oregonstate.edu ([128.193.4.8]:42161 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S263121AbVD3B6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 21:58:03 -0400
Date: Fri, 29 Apr 2005 18:57:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Linux 2.6.11.8
Message-ID: <20050430015732.GA8943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the -stable patch review cycle is now over, I've released the
2.6.11.8 kernel in the normal kernel.org places.  Due to some
disagreement over some of the patches in the review cycle, I've dropped
a number of them.

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.7 and 2.6.11.8, as it is small enough to do so.

And a personal thanks to OSU for letting me bore them by doing this in
their meeting.

thanks,
 
greg k-h

------

 Makefile                                 |    4 ++--
 arch/sparc/kernel/ptrace.c               |   12 ------------
 arch/sparc64/kernel/ptrace.c             |   19 -------------------
 arch/sparc64/kernel/signal32.c           |    5 ++++-
 arch/sparc64/kernel/systbls.S            |    2 +-
 arch/um/include/sysdep-i386/syscalls.h   |   12 ++++++------
 arch/um/include/sysdep-x86_64/syscalls.h |    5 -----
 arch/um/kernel/sys_call_table.c          |   11 ++++-------
 drivers/i2c/chips/it87.c                 |    2 +-
 drivers/i2c/chips/via686a.c              |    2 +-
 drivers/media/video/bttv-cards.c         |    2 --
 fs/partitions/msdos.c                    |    5 +++++
 security/keys/key.c                      |    3 ++-
 13 files changed, 26 insertions(+), 58 deletions(-)



Summary of changes from v2.6.11.7 to v2.6.11.8
==============================================

Alexander Nyberg:
  o Fix reproducible SMP crash in security/keys/key.c

David S. Miller:
  o sparc: Fix PTRACE_CONT bogosity
  o sparc64: Fix copy_sigingo_to_user32()
  o sparc64: use message queue compat syscalls

Greg Kroah-Hartman:
  o Linux 2.6.11.8

Jean Delvare:
  o I2C: Fix incorrect sysfs file permissions in it87 and via686a
    drivers

Johannes Stezenbach:
  o [fix Bug 4395] modprobe bttv freezes the computer

Paolo 'Blaisorblade' Giarrusso:
  o uml: quick fix syscall table

