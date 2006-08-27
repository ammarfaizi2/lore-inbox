Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWH0X6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWH0X6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWH0X6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:58:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51396 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932302AbWH0X6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:42 -0400
Message-Id: <20060827214734.252316000@klappe.arndb.de>
Date: Sun, 27 Aug 2006 23:47:34 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 0/7] kill __KERNEL_SYSCALLS__
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, next try. This time a full series that tries to kill
off __KERNEL_SYSCALLS__, _syscallX() and the global errno
for good.

Practically no testing so far, so please check if this
makes sense first before applying.

I'd especially like the arch maintainers to provide
better implementations of kernel_execve, since I had to
rely on the inline assembly provided from _syscall3 to
implement them instead of doing it the right way.

	Arnd <><

