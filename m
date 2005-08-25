Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVHYEc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVHYEc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVHYEc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:32:57 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:26067 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S964786AbVHYEc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:32:57 -0400
Date: Thu, 25 Aug 2005 00:32:50 -0400 (EDT)
Message-Id: <200508250432.j7P4WoGe020067@ms-smtp-02.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13c
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >It uses 50% of total memory for tmpfs, but it would be nice to have
   >an option (tmpfs_size=90% etc.) that you could pass to the kernel.
   >>that's just because of the tmpfs default; you can remount to change
   >>that if it's not suitable once your up and running in your
   >>init-scripts or whatever
   
Right, but it would be nice to have that option if initramfs
using tmpfs becomes part of the kernel.
   
   >You need to add this to init/main.c for it to compile.
   >#include <asm/uaccess.h>
   >>hmm... really? i'll rediff it at some point and test it maybe. i
   >>really don't like the explicity shm init though, i'd like to think of
   >>a cleaner way to do that

You get this error without it.   
   init/main.c: In function `overmount_rootfs':
init/main.c:663: warning: implicit declaration of function `get_fs'
init/main.c:663: error: incompatible types in assignment
init/main.c:664: warning: implicit declaration of function `set_fs'
init/main.c:664: error: `KERNEL_DS' undeclared (first use in this function)
init/main.c:664: error: (Each undeclared identifier is reported only once
init/main.c:664: error: for each function it appears in.)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
   
