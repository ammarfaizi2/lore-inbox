Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTLCPTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTLCPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:19:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:43273 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264589AbTLCPTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:19:08 -0500
To: lkml-031128@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com>
	<87d6bc2yvq.fsf@devron.myhome.or.jp>
	<20031129170034.10522.qmail@mailshell.com>
	<1070242158.1110.150.camel@buffy> <3FCBAE6F.1090405@myrealbox.com>
	<20031201213624.18232.qmail@mailshell.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 04 Dec 2003 00:18:52 +0900
In-Reply-To: <20031201213624.18232.qmail@mailshell.com>
Message-ID: <871xrmudyb.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031128@amos.mailshell.com writes:

> After I added Ogawa's line, "head -1 /proc/net/tcp" stopped
> freezing my machine but PPP failed to work.
> 
> Also after adding Ogawa's line, PPP works fine (as it is now, as
> I write this message) as long as I don't try "head -1 /proc/net/tcp"
> after boot. If I'll try "head -1 /proc/net/tcp" now PPP will stop
> working.

Can you reproduce the fail of PPP? I couldn't reproduce it.
What reason is the fail of PPP? (the "debug" option of pppd may be helpful)

Of course, the following message is easy reproducible. But it's
debugging message, not the real problem. And probably it's unrelated
to the fail of PPP.

> >>> Badness in local_bh_enable at kernel/softirq.c:121
> >>> Call Trace:
> >>>  [<c011df25>] local_bh_enable+0x85/0x90
> >>>  [<c02315e2>] ppp_async_push+0xa2/0x180
> >>>  [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
> >>>  [<c0202638>] pty_unthrottle+0x58/0x60
> >>>  [<c01ff0fd>] check_unthrottle+0x3d/0x40
> >>>  [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
> >>>  [<c0202a47>] pty_flush_buffer+0x67/0x70
> >>>  [<c01fba41>] do_tty_hangup+0x3f1/0x460
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
