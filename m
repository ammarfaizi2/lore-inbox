Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbRLQWIG>; Mon, 17 Dec 2001 17:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLQWH4>; Mon, 17 Dec 2001 17:07:56 -0500
Received: from [213.97.199.90] ([213.97.199.90]:12160 "HELO fargo")
	by vger.kernel.org with SMTP id <S282902AbRLQWHr> convert rfc822-to-8bit;
	Mon, 17 Dec 2001 17:07:47 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Mon, 17 Dec 2001 23:07:03 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Loopback deadlock again
Message-ID: <Pine.LNX.4.33.0112172246400.558-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Even with the Andrea/Monchil patch applied against 2.4.17-rc1, i'm still
hitting the loopback deadlock. Doing a 'cp -a' to a loop device leaves cp
and the loop kernel thread in D state.

I don't know if it's useful, but i did a strace of cp, and the process is
deadlocked in a mkdir call. Sometimes, a 'sync' finish the deadlock, other
times sync also hangs:

[...]
589 tty1     S      0:00 bash
594 ?        DW<    0:00 [loop0]
620 tty1     D      0:00 sync

And a reboot is the only way to kill the tasks.


Thanks

David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



