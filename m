Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287997AbSAHMfx>; Tue, 8 Jan 2002 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287995AbSAHMfn>; Tue, 8 Jan 2002 07:35:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56744 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287997AbSAHMfc>;
	Tue, 8 Jan 2002 07:35:32 -0500
Date: Tue, 8 Jan 2002 15:32:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: [patch] O(1) scheduler, -E1, 2.5.2-pre10, 2.4.17
In-Reply-To: <20020108113251.GB20897@krispykreme>
Message-ID: <Pine.LNX.4.33.0201081503250.6793-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the latest update of the O(1) scheduler:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre10-E1.patch

        http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-E1.patch

now that Linus has put the -D2 patch into the 2.5.2-pre10 kernel, the
2.5.2-pre10-E1 patch has become quite small :-)

The patch compiles, boots & works just fine on my UP/SMP boxes.

Changes since -D2:

 - make rq->bitmap big-endian safe. (Anton Blanchard)

 - documented and cleaned up the load estimator bits, no functional
   changes apart from small speedups.

 - do init_idle() before starting up the init thread, this removes a race
   where we'd run the init thread on CPU#0 before init_idle() has been
   called.

	Ingo

