Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUEUHGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUEUHGC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbUEUHGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:06:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27819 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265418AbUEUHGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:06:00 -0400
Date: Fri, 21 May 2004 03:05:52 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
In-Reply-To: <20040520155217.7afad53b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405210305030.24392@devserv.devel.redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
 <20040520155217.7afad53b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 May 2004, Andrew Morton wrote:

> >  asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
> > -			  struct timespec __user *utime, u32 __user *uaddr2)
> > +			  struct timespec __user *utime, u32 __user *uaddr2,
> > +			  int val3)
> 
> Is it safe to go adding a new argument to an existing syscall in this manner?
> 
> It'll work OK on x86 because of the stack layout but is the same true of
> all other supported architectures?

we added a new futex paramater once before (the original requeue patch) -
so if it broke anything, it didnt break loud enough for anyone to notice
:-|

	Ingo
