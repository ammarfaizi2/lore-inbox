Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbUKEKpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbUKEKpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUKEKpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:45:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:23747 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262615AbUKEKpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:45:47 -0500
Date: Fri, 5 Nov 2004 11:38:01 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105103801.GA8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105102204.GA4730@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:22:04AM +0100, Ingo Molnar wrote:
> 
> * Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> 
> > On Friday 05 November 2004 09:13, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> > 
> > ------------[ cut here ]------------
> > kernel BUG at mm/memory.c:156!
> 
> > Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
> 
> reproducible here too, just running LTP's shmt04 directly triggers it
> immediately. Looks like there's interaction of 4-level pagetables with
> ipc/shm.c or mm/shmem.c.

I tested LTP at one point on i386/x86-64 and and it didn't oops for me. 
Perhaps I messed up a later merge. Will investigate.

-Andi
