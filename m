Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbTBIAsh>; Sat, 8 Feb 2003 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTBIAsh>; Sat, 8 Feb 2003 19:48:37 -0500
Received: from dp.samba.org ([66.70.73.150]:39115 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267142AbTBIAsg>;
	Sat, 8 Feb 2003 19:48:36 -0500
Date: Sun, 9 Feb 2003 11:57:37 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: heavy handed exit() in latest BK
Message-ID: <20030209005737.GD20110@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>From BK late last night (has everything except the most recent 2
sound changesets)

kernel BUG at kernel/exit.c:710!

which is:

do_exit()
...
        schedule();
        BUG();
        /* Avoid "noreturn function does return".  */
        for (;;) ;
}

Oops. In a police lineup Id finger the signal changes.

Anton
