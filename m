Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270933AbTGVQvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270939AbTGVQvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 12:51:48 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:61906 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S270933AbTGVQvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 12:51:04 -0400
Date: Tue, 22 Jul 2003 19:06:06 +0200
From: Kurt Roeckx <Q@ping.be>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-ID: <20030722170606.GA14680@ping.be>
References: <20030721142259.GA4315@ping.be> <20030722022424.7480af8e.sfr@canb.auug.org.au> <20030721180032.GA26786@ping.be> <20030722095105.5ed2379a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722095105.5ed2379a.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 09:51:05AM +1000, Stephen Rothwell wrote:
> Hi Kurt,
> 
> On Mon, 21 Jul 2003 20:00:32 +0200 Kurt Roeckx <Q@ping.be> wrote:
> >
> > linux/types.h has:
> > #ifdef __KERNEL__
> > typedef __kernel_uid32_t        uid_t;
> > #else
> > typedef __kernel_uid_t          uid_t;
> > #endif /* __KERNEL__ */
> > 
> > And __kernel_uid_t is an "unsigned short"
> 
> Anywhere this should be used (i.e. only in the kernel), uid_t will be
> __kernel_uid32_t.  The change to this part of the siginfo_t structure has
> not yet propogated to the glibc headers and when it does, it is up to the
> glibc maintainers to make sure it matches what is used inside the kernel.

I'm still using libc5, and plan to do so for as long as I can.


Kurt

