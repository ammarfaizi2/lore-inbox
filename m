Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWE3MmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWE3MmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWE3MmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:42:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:57290 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751493AbWE3MmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:42:06 -0400
X-Authenticated: #14349625
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if
	CONFIG_LOCKDEP, i386
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060530122950.GA10216@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer>
	 <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu>
	 <1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu>
	 <1148992098.8700.2.camel@homer>  <20060530122950.GA10216@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:44:24 +0200
Message-Id: <1148993064.7743.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:29 +0200, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > > > BUG: warning at kernel/lockdep.c:2398/check_flags()
> > > 
> > > this one could be related to NMI. We are already disabling NMI on 
> > > x86_64, but i thought i had it fixed up for i386 - apparently not.
> > 
> > Booted with nmi_watchdog=0, no warning and no deadlock.
> 
> ok, great. The patch below turns off NMI on i386 automatically.

All is well.  Back to nmi_watchdog=1, no warning, no lock.

	-Mike 

