Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTA1Rdi>; Tue, 28 Jan 2003 12:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTA1Rdh>; Tue, 28 Jan 2003 12:33:37 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13069
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267481AbTA1Rdg>; Tue, 28 Jan 2003 12:33:36 -0500
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
From: Robert Love <rml@tech9.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128173949.GA23077@nevyn.them.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com>
	 <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
	 <20030128154541.GA7269@nevyn.them.org> <1043774823.9069.59.camel@phantasy>
	 <20030128173949.GA23077@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043775771.9069.63.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Jan 2003 12:42:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 12:39, Daniel Jacobowitz wrote:

> That wasn't my point.  All of the other threads have already terminated
> without dumping core at tis point; I don't think it's possible for two
> threads of a CLONE_THREAD application to both dump core.  See
> fs/exec.c:coredump_wait.
> 
> Also, once one thread gets into do_coredump it clears mm->dumpable;
> nothing else will dump core from that MM anyway.

Are you telling me only one thread per thread group can coredump,
period?  So if two of them segfault (say concurrently on two different
processors) only one will win the race to dump and the others will
simply exit?

If so, I did not know that.  You are right, then.

> I think using ->tgid is a good idea.

I think it is, too - even if what I said is true - as a format option.

Anyhow, I stand corrected.

	Robert Love

