Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSBSTJV>; Tue, 19 Feb 2002 14:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSBSTJM>; Tue, 19 Feb 2002 14:09:12 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:29700 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S288958AbSBSTIx>;
	Tue, 19 Feb 2002 14:08:53 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202191908.WAA28390@ms2.inr.ac.ru>
Subject: Re: Moving fasync_struct into struct file?
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 19 Feb 2002 22:08:11 +0300 (MSK)
Cc: davem@redhat.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <E16d4XU-0003VI-00@wagner.rustcorp.com.au> from "Rusty Russell" at Feb 19, 2 06:18:12 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	Stephen Rothwell pointed out that if you set up SIGIO from an
> fd, fork, and exit, and PIDs wrap, the new process may be clobbered by
> the SIGIO.  IMVHO the best way to clean this up is to check the
> fasync_list in sys_close, and if pid == filp->f_owner.pid and fd ==
> fasync_list->fa_fd, unregister the SIGIO.
> 
> 	This means we need a move the "struct fasync_struct
> fasync_list" into struct file (up from all the subsystems which use
> it, eg. struct socket).
> 
> See any problems with this?

I do not see.

It is a long known piece of shit in the kernel crying about repair.
I remember Al Viro planned to do something with this for 2.4,
but this has been forgotten again.

Alexey
