Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVKOOz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVKOOz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVKOOz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:55:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:26077 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751440AbVKOOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:55:24 -0500
Message-Id: <20051115205347.395355000@localhost>
Date: Tue, 15 Nov 2005 15:53:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: akpm@osdl.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, mnutter@us.ibm.com
Subject: [PATCH 0/5] SPU file system for 2.6.15-rc-mm
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to have the SPU file system included in the -mm kernel
to get broader review and eventually have it merged in 2.6.16.

This version now puts all the spufs files under
arch/powerpc/platforms/cell/spufs instead of fs/spufs, since it
is really specific to that platform.

The interface has now stabilized on a set of files per logical
SPU that can be accessed with read/write and sometime poll
or mmap but not ioctl as well as two new system calls, spu_run
and spu_create.

As discussed, the system call numbers that I am using here
conflict with those from the perfmon patches, so I'm moving
the perfmon syscall range to start at 280. This means that
the first patch gets to be applied on top of
perfmon2-reserve-system-calls-reserve-spu-slots.patch.

	Arnd <><

--

