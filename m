Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTJ1Lmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 06:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTJ1Lme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 06:42:34 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:19664 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263936AbTJ1Lmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 06:42:33 -0500
Date: Tue, 28 Oct 2003 22:41:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@suse.cz>
Cc: felipe_alfaro@linuxmail.org, mochel@osdl.org, george@mvista.com,
       pavel@suse.cz, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
Message-Id: <20031028224101.3220e0a6.sfr@canb.auug.org.au>
In-Reply-To: <20031028093233.GA1253@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	<1067329994.861.3.camel@teapot.felipe-alfaro.com>
	<20031028093233.GA1253@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 10:32:33 +0100 Pavel Machek <pavel@suse.cz> wrote:
>
> Not sure... We do not want applications to know. Certainly we can't
> send a signal; SIGPWR already has some meaning and it would be bad to
> override it.

And SIGPWR is a bad choice anyway as the default action for SIGPWR
is to terminate the process - I can't see people being amused if all
their processes are killed when they suspend their laptop :-)

We could invent a new signal whose default action is ignore ... Solaris
has SIGFREEZE and SIGTHAW (the comment in the header file says used by CPR
- whatever that is).  SIGSUSPEND and SIGRESUME?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
