Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264454AbSIQSY1>; Tue, 17 Sep 2002 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264457AbSIQSY1>; Tue, 17 Sep 2002 14:24:27 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:29193
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264454AbSIQSY0>; Tue, 17 Sep 2002 14:24:26 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032271821.11913.10.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com> 
	<1032250378.969.112.camel@phantasy>  <1032253191.4592.15.camel@phantasy> 
	<1032271821.11913.10.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 14:29:18 -0400
Message-Id: <1032287359.4588.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 10:10, Steven Cole wrote:

> I booted that so-patched kernel and it got much further than before,
> up to where syslogd was able to write some stuff to /var/log/messages.

That is what is happening to me... if you trace when you lockup, its due
to the printk.  My machines in these cases are only livelocked, I can
still ping etc.
 
> Trace; c011c51b <put_files_struct+bb/d0>
> Trace; c011d08b <do_exit+35b/370>
> Trace; c012d67f <do_munmap+11f/130>
> Trace; c012d6c5 <sys_munmap+35/60>
> Trace; c010918f <syscall_call+7/b>

Ugh this looks like the exit path which should not be triggered.

	Robert Love

