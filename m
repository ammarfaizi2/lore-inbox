Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVAURjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVAURjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVAURjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:39:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:45008 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262429AbVAURjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:39:06 -0500
Date: Fri, 21 Jan 2005 09:39:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@cpushare.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121093902.O469@build.pdx.osdl.net>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121120325.GA2934@elte.hu>; from mingo@elte.hu on Fri, Jan 21, 2005 at 01:03:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Andrea Arcangeli <andrea@cpushare.com> wrote:
> 
> > This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
> > Cpushare (until trusted computing will hit the hardware market). 
> > [...]
> 
> why do you need any kernel code for this? This seems to be a limited
> ptrace implementation: restricting untrusted userspace code to only be
> able to exec read/write/sigreturn.
> 
> So this patch, unless i'm missing something, duplicates in essence what
> ptrace can do already here and today, on any Linux box, on any CPU. You
> can implement your client based on ptrace alone, just like UML does it -
> and UML has much more complex needs than secure isolation.

Only difference is in number of context switches, and number of running
processes (and perhaps ease of determining policy for which syscalls
are allowed).  Although it's not really seccomp, it's just restricted
syscalls...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
