Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbRLEVQq>; Wed, 5 Dec 2001 16:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284738AbRLEVQ1>; Wed, 5 Dec 2001 16:16:27 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:5900 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284737AbRLEVQR>; Wed, 5 Dec 2001 16:16:17 -0500
Date: Wed, 5 Dec 2001 13:27:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] task_struct + kernel stack colouring ( set size ) ...
Message-ID: <Pine.LNX.4.40.0112051317350.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The previous patch picked up colour bits that already had an implicit
colouring.

http://www.xmailserver.org/linux-patches/misc.html#TskStackCol
http://www.xmailserver.org/linux-patches/tsstackcol-2.5.0-0.5.diff



[diffstat]
arch/i386/kernel/entry.S     |    7 ++---
arch/i386/kernel/head.S      |    2 -
arch/i386/kernel/init_task.c |   14 +++++++---
arch/i386/kernel/irq.c       |    2 -
arch/i386/kernel/process.c   |   60 +++++++++++++++++++++++++++++++++++++++++--
arch/i386/kernel/smpboot.c   |    2 -
arch/i386/kernel/traps.c     |    2 -
arch/i386/lib/getuser.S      |    3 ++
include/asm-i386/current.h   |    6 ++--
include/asm-i386/hw_irq.h    |    3 +-
include/asm-i386/processor.h |   21 ++++++++++-----
include/linux/sched.h        |   16 ++++++++++-
init/main.c                  |    6 ++++
kernel/ksyms.c               |    2 -
14 files changed, 120 insertions, 26 deletions





- Davide




