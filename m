Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264828AbSJVTUU>; Tue, 22 Oct 2002 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbSJVTUT>; Tue, 22 Oct 2002 15:20:19 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:37531 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264828AbSJVTUO>; Tue, 22 Oct 2002 15:20:14 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 12:35:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Charles 'Buck' Krasic" <krasic@acm.org>
cc: Mark Mielke <mark@mark.mielke.cc>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <xu48z0ql3hy.fsf@brittany.cse.ogi.edu>
Message-ID: <Pine.LNX.4.44.0210221231330.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002, Charles 'Buck' Krasic wrote:

> So maybe epoll's moment of utility is only transient.  It should have
> been in the kernel a long time ago.  Is it too late now that AIO is
> imminent?

This is not my call actually. But beside comparing actual performance
between AIO and sys_epoll, one of the advantages that the patch had is
this :

arch/i386/kernel/entry.S  |    4
drivers/char/Makefile     |    4
fs/Makefile               |    4
fs/file_table.c           |    4
fs/pipe.c                 |   36 +
include/asm-i386/poll.h   |    1
include/asm-i386/unistd.h |    3
include/linux/fs.h        |    4
include/linux/list.h      |    5
include/linux/pipe_fs_i.h |    4
include/linux/sys.h       |    2
include/net/sock.h        |   10
net/ipv4/tcp.c            |    4

That is, it has a very little "intrusion" in the original code by plugging
in the existing architecture.



- Davide


