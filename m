Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVJLPhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVJLPhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVJLPhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:37:05 -0400
Received: from mail.gmx.net ([213.165.64.21]:7099 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964817AbVJLPhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:37:04 -0400
Date: Wed, 12 Oct 2005 17:37:02 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: raa.lkml@gmail.com, trond.myklebust@fys.uio.no, boi@boi.at,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com>
Subject: =?ISO-8859-1?Q?Re:_blocking_file_lock_functions_(lockf,flock,fcntl)_do_no?=
 =?ISO-8859-1?Q?t_return_after_timer_signal?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <16960.1129131422@www39.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
> An: "Alex Riesen" <raa.lkml@gmail.com>
> Kopie: "Trond Myklebust" <trond.myklebust@fys.uio.no>, <boi@boi.at>,
> "Linux kernel" <linux-kernel@vger.kernel.org>
> Betreff: Re: blocking file lock functions (lockf,flock,fcntl) do not
> return after timer signal

[...]

> Datum: Wed, 12 Oct 2005 11:20:26 -0400
> As I told you, you use sigaction(). Also flock() will not block
> unless there is another open on the file. The code will run to
> your blocking read(), wait 10 seconds, get your "timeout" from
> the signal handler, then read() will return with -1 and ERESTARTSYS
> in errno as required.

I was just trying to write a message to say the same ;-).

> Also, using a 'C' runtime library call like write() in a signal-
> handler is a bug.

But this is not correct.  write() is async-signal-safe (POSIX 
requires it).

Cheers,

Michael

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
