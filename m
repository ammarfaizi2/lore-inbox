Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSH0Vnu>; Tue, 27 Aug 2002 17:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSH0Vnu>; Tue, 27 Aug 2002 17:43:50 -0400
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:19361 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S317264AbSH0Vnt>; Tue, 27 Aug 2002 17:43:49 -0400
Date: Tue, 27 Aug 2002 23:48:07 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: linux-kernel@vger.kernel.org
Subject: [PATCH] POSIX message queues
Message-ID: <Pine.GSO.4.40.0208272306480.21077-100000@ultra60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have written (Michal Wronski & me) a patch for 2.4.18 & 2.4.19 kernel
adding POSIX message queues (mq_* family functions). In difference to
standard SysV message queues (msgsnd() etc) they allow to send messages
with different priorities, support asynchronous receive and more.

As patches are quite large here is URL to our page:
http://www.mat.uni.torun.pl/~wrona/posix_ipc

and direct links:
http://www.mat.uni.torun.pl/~wrona/posix_ipc/mqueue_patch-2.4.18.tar.gz
http://www.mat.uni.torun.pl/~wrona/posix_ipc/mqueue_patch-2.4.19.tar.gz

also there is an appropriate library:
http://www.mat.uni.torun.pl/~wrona/posix_ipc/mqueue_lib-2.0.tar.gz

I'd like to point out some issues:

1) Architecture & syscall - We have added support only for i386. But the
only one thing which is arch. dependent is a new system call. So porting
it is fairly simply. We haven't done it only because we are afraid of
making some silly bugs without any possibility to test. We know that
_new_ system call is rather "undesirable", but we can add invoking of our
code to e.g. ipc syscall.

2) SMP - I'm not SMP specialist and so everything touching SMP is done in
the simplest way. Meaning: it can be done more efficient. Also
there can be bugs - we don't have SMP box to test it on (during academic
year it can change).


Awaiting comments, feedbacks, etc. (especially about above two points)

Krzysiek Benedyczak

