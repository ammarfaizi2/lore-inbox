Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUBPNc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUBPNc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:32:57 -0500
Received: from dp.samba.org ([66.70.73.150]:39326 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265528AbUBPNcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:32:55 -0500
Date: Mon, 16 Feb 2004 22:42:44 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dirk Morris <dmorris@metavize.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
Message-Id: <20040216224244.3928d477.rusty@rustcorp.com.au>
In-Reply-To: <402D3DFF.4040609@metavize.com>
References: <402D3DFF.4040609@metavize.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 13:13:35 -0800
Dirk Morris <dmorris@metavize.com> wrote:

> In reference to this previous post:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/1966.html
> 
> I also get:
> Feb 13 11:43:52 timmy kernel: Call Trace:
> Feb 13 11:43:52 timmy kernel:  [<c01387e1>] futex_wait+0x191/0x1a0
> Feb 13 11:43:52 timmy kernel:  [<c011e9e0>] default_wake_function+0x0/0x20
> Feb 13 11:43:52 timmy kernel:  [<c011e9e0>] default_wake_function+0x0/0x20
> Feb 13 11:43:52 timmy kernel:  [<c0138abb>] do_futex+0x6b/0x80
> Feb 13 11:43:52 timmy kernel:  [<c0138be6>] sys_futex+0x116/0x130
> Feb 13 11:43:52 timmy kernel:  [<c010959f>] syscall_call+0x7/0xb
> 
> I get this in 2.6.1 and 2.6.2.
> In userland a call to sem_wait returns with -1, and errno = -EINTR

Yes...

	Please send your config.  What's happening at the time?

(Andrew's patch was buggy, I fixed it and can send you an update).

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
