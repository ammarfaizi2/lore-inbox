Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266831AbRGLVx4>; Thu, 12 Jul 2001 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266830AbRGLVxr>; Thu, 12 Jul 2001 17:53:47 -0400
Received: from sncgw.nai.com ([161.69.248.229]:22400 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266795AbRGLVxi>;
	Thu, 12 Jul 2001 17:53:38 -0400
Message-ID: <XFMail.20010712145643.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 12 Jul 2001 14:56:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleaned /dev/epoll patch ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The /dev/epoll patch has been cleaned and slightly changed :


1) moved the file callback list handling from fs/file.c to fs/fcblist.c

2) moved the functions definitions from include/linux/file.h to
        include/linux/fcblist.h

3) renamed the patch from /dev/poll to /dev/epoll ( event poll )

4) renamed the devpoll.c(.h) files into eventpoll.c(.h)

5) configuration variable from CONFIG_DEVPOLL to CONFIG_EVENTPOLL

6) fixed a locking issue on SMP

7) kmalloc/vmalloc switch for big chunks of mem

8) increased the maximum number of fds to 128000 ( maybe I'll change this to be
        unbounded )

9) changed device MINOR to 124




You can find the patch and the test software here :

http://www.xmailserver.org/linux-patches/nio-improve.html




- Davide

