Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281694AbRKQDqW>; Fri, 16 Nov 2001 22:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281695AbRKQDqM>; Fri, 16 Nov 2001 22:46:12 -0500
Received: from f207.law9.hotmail.com ([64.4.9.207]:49416 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S281694AbRKQDpz>;
	Fri, 16 Nov 2001 22:45:55 -0500
X-Originating-IP: [216.41.49.127]
From: "Jeff Long" <jeffwlong@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Zombies with 2.4.15pre5 (exit.c)
Date: Sat, 17 Nov 2001 03:45:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F207EKzlO329qhXbGE400017908@hotmail.com>
X-OriginalArrivalTime: 17 Nov 2001 03:45:49.0951 (UTC) FILETIME=[593430F0:01C16F1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.15pre5 (UP) on i386, running UML 2.4.14-2.
UML processes create threads on the host system that don't
die.  Threads are stuck at do_exit( ), so I backed out the
patch to kernel/exit.c @ 539 (in 2.4.15pre5 patch):

  p->state = TASK_DEAD;

and things work fine.  I do not see zombies with anything
other than UML processes/native threads.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

