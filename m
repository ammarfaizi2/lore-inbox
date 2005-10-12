Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVJLQFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVJLQFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVJLQFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:05:15 -0400
Received: from mail.gmx.de ([213.165.64.21]:23529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751473AbVJLQFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:05:14 -0400
Date: Wed, 12 Oct 2005 18:05:12 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: raa.lkml@gmail.com, trond.myklebust@fys.uio.no, boi@boi.at,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0510121138450.4391@chaos.analogic.com>
Subject: =?ISO-8859-1?Q?Re:_blocking_file_lock_functions_(lockf,flock,fcntl)_do_no?=
 =?ISO-8859-1?Q?t_return_after_timer_signal?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <26148.1129133112@www39.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Also, using a 'C' runtime library call like write() in a signal-
> >> handler is a bug.
> >
> > But this is not correct.  write() is async-signal-safe (POSIX
> > requires it).
> 
> Then tell it to the doom-sayers who always excoriate me when
> I use a 'C' runtime library call in test signal code. I have
> been told that the __only__ thing you can do in a signal handler
> is access global memory and/or execute siglongjmp().

Nevertheless, it is not so.  The problem that some may 
complain about is not C RTL code, but perhaps using 
printf() (wrong) instead of write()


From:
http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_04.html#tag_02_04

    The following table defines a set of functions that shall 
    be either reentrant or non-interruptible by signals and 
    shall be async-signal-safe. Therefore applications may 
    invoke them, without restriction, from signal-catching 
    functions:
    [...]
    write()

Cheers,

Michael

-- 
NEU: Telefon-Flatrate fürs dt. Festnetz! GMX Phone_Flat: 9,99 Euro/Mon.*
Für DSL-Nutzer. Ohne Providerwechsel! http://www.gmx.net/de/go/telefonie
