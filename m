Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313717AbSDHSAW>; Mon, 8 Apr 2002 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313718AbSDHSAV>; Mon, 8 Apr 2002 14:00:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12606 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313717AbSDHSAV>; Mon, 8 Apr 2002 14:00:21 -0400
To: "Philippe Elie" <phil.el@wanadoo.fr>
Cc: "Bill Davidsen" <davidsen@tmr.com>,
        "John Levon" <movement@marcelothewonderpenguin.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <Pine.LNX.3.96.1020408104259.21476B-100000@gatekeeper.tmr.com>
	<00a801c1df17$55295ae0$95dc0e50@machine1>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Apr 2002 11:53:38 -0600
Message-ID: <m1g026m5zx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Philippe Elie" <phil.el@wanadoo.fr> writes:

> From: "Bill Davidsen" <davidsen@tmr.com>
> Sent: Monday, April 08, 2002 4:48 PM
> 

> >   For legitimate use, if any, a compile-time optional system call could be
> > added requiring a capability to use, and programs which are currently
> > doing that (AFS?) can be converted to use another f/s interface. I have
> > seen a few mentions of software which DO use that capability, I'm not sure
> > I've seen one which can be done no other way.
> 
> As stated oprofile needs it, there is no other efficient way to track exec,
> mmap and other sys call needed for profiler. I hope a consensus can
> be reach : explain than unloading module wich patch the sys call table
> are unsafe on SMP, discourage the use of sys call table patch, but do
> not forbid that.

In times past when people were working on the vm86 system call you needed
a modified version of insmod, that could read System.map.

If you are going to be doing strange things I don't see why that shouldn't
still be required.

Though I am wondering if the sane approach for a profiler might not to be
have a kernel conditional compilation directive that simply patches
the syscall path.  The overhead is probably less as well.

Eric
