Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264750AbSJUGpf>; Mon, 21 Oct 2002 02:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbSJUGpf>; Mon, 21 Oct 2002 02:45:35 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:16556 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264750AbSJUGpe>; Mon, 21 Oct 2002 02:45:34 -0400
Message-ID: <3DB3A732.2080405@kegel.com>
Date: Mon, 21 Oct 2002 00:05:22 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: re: [patch] sys_epoll ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide wrote:
 >asmlinkage int sys_epoll_create(int maxfds);
 >asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
 >asmlinkage int sys_epoll_wait(int epfd, struct pollfd **events, int timeout);

Hey Davide,
I've always been a bit bothered by the need to specify maxfds in
advance.  What's the preferred way to handle the situation
where you guess wrong on the value of maxfds?  Create a new
epoll and register all the old fds with it?  (Sounds like
a good job for a userspace wrapper library.)

Regardless, thanks for pushing /dev/epoll along towards inclusion
in 2.5.  I'm looking forward to seeing it it integrated.
Even if the interface doesn't please everyone, the performance
should...
- Dan

