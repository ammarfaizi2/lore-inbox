Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVAVSLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVAVSLB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:08:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:19627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262624AbVAVSCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 13:02:04 -0500
Date: Sat, 22 Jan 2005 10:02:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Pollable Semaphores
Message-ID: <20050122100203.N24171@build.pdx.osdl.net>
References: <20050121212212.GA453910@firefly.engr.sgi.com> <521xceqx90.fsf@topspin.com> <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com> <a36005b5050121194377026f39@mail.gmail.com> <20050121215203.S469@build.pdx.osdl.net> <20050121230504.T469@build.pdx.osdl.net> <a36005b50501212339405ca4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a36005b50501212339405ca4a7@mail.gmail.com>; from drepper@gmail.com on Fri, Jan 21, 2005 at 11:39:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulrich Drepper (drepper@gmail.com) wrote:
> On Fri, 21 Jan 2005 23:05:04 -0800, Chris Wright <chrisw@osdl.org> wrote:
> > Yeah, here it is.  I refreshed it against a current kernel.  It passes my
> > same old test, where I select on /proc/<pid>/status fd in exceptfds.
> 
> Looks certainly attractive to me.  Nice small patch.  How quickly
> after the death of the process is proc_pid_flush() called?

I don't think it's called until it's reaped.

> If this could go in and the futex stuff is handled, there is "only"
> async I/O to handle.  After that we could finally create a uniform
> event mechanism at userlevel which binds all these events (I/O,
> process/thread termination, sync primitives) together.  Maybe support
> for legacy sync primitives (SysV semaphores, msg queues) is needed as
> well, don't know yet.  Note that I assume that polling of POSIX
> mqueues works as it did the last time I tried it.

It should, AFAIK nothing there has changed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
