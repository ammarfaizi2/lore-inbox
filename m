Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUEBLyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUEBLyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 07:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUEBLyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 07:54:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:38862 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263001AbUEBLyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 07:54:04 -0400
Date: Sun, 2 May 2004 13:53:04 +0200 (MEST)
Message-Id: <200405021153.i42Br4qt007808@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [CFT] updated gcc-3.4.0 fixes patch for 2.4.27-pre1
Cc: marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is now an updated patch for compiling 2.4.27-pre1
with gcc-3.4.0. It's 50KB+ so I'm not inlining it in
this message; instead get it from:

http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v2-2.4.27-pre1

The changes since the first version are:
- updates for the x86_64 and ppc kernels
- more drivers corrected (parport_pc, fbcon, hid-core, ...)
- corrected evaluation order in UP version of __IRQ_STAT

Tested with gcc-3.4.0 on i386 UP and SMP, x86_64 UP and SMP,
and ppc UP. Regression tested with gcc-2.95.3 on i386 SMP.

Please test if you have any interest in being able to
use gcc-3.4.0 with 2.4 kernels.

There was a question about why I disabled -funit-at-a-time.
This is taken from the 2.6.6-rc3 kernel. It's not only a
workaround for gcc rewriting sprintf "%s" to strcpy() while
also failing to inline strcpy(). 2.6.6-rc3 claims that it
substantially increases stack usage, which is unacceptable
in the kernel.

/Mikael
