Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJ1ULr>; Mon, 28 Oct 2002 15:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbSJ1ULr>; Mon, 28 Oct 2002 15:11:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:8383 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261273AbSJ1ULq>;
	Mon, 28 Oct 2002 15:11:46 -0500
Date: Mon, 28 Oct 2002 12:10:49 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: torvalds@transmeta.com
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       davidel@xmailserver.org, lse-tech@lists.sourceforge.net,
       linux-aio@kvack.org
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <72840000.1035835849@w-hlinder>
In-Reply-To: <53100000.1035832459@w-hlinder>
References: <53100000.1035832459@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, October 28, 2002 11:14:19 -0800 Hanna Linder <hannal@us.ibm.com> wrote:

> ps- Did I mention there is a web site? http://lse.sf.net/epoll/index.html
> 
> -----
> diff -Nru linux-2.5.44.vanilla/arch/i386/kernel/entry.S linux-2.5.44.epoll/arch/i386/kernel/entry.S

Forgot to include the diffstat for Davide's sys_epoll patch (v11):


 arch/i386/kernel/entry.S  |    4
 drivers/char/Makefile     |    4
 drivers/char/eventpoll.c  | 1136 ++++++++++++++++++++++++++++++++++++++++++++++ fs/Makefile               |    4
 fs/fcblist.c              |  135 +++++
 fs/file_table.c           |    4
 fs/pipe.c                 |   36 +
 include/asm-i386/poll.h   |    1
 include/asm-i386/unistd.h |    3
 include/linux/eventpoll.h |   51 ++
 include/linux/fcblist.h   |   73 ++
 include/linux/fs.h        |    4
 include/linux/list.h      |    5
 include/linux/pipe_fs_i.h |    4
 include/linux/sys.h       |    2
 include/net/sock.h        |   12
 net/ipv4/tcp.c            |    4
 17 files changed, 1471 insertions(+), 11 deletions(-)

