Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUEOAA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUEOAA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUENX7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:59:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:5846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264571AbUENX6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:58:36 -0400
Date: Fri, 14 May 2004 16:58:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040514165834.D21045@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040514235628.GA877@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040514235628.GA877@samarkand.rivenstone.net>; from jhf@rivenstone.net on Fri, May 14, 2004 at 07:56:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joseph Fannin (jhf@rivenstone.net) wrote:
> On Thu, May 13, 2004 at 03:27:36AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm2/
> 
> > +rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
> 
>     The above patch includes linux/mqueue.h from
> arch/*/kernel/init_task.c for each arch.  Building the kernel fails on
> ppc because ppc doesn't have an init_task.c; the setting of
> CONFIG_POSIX_MQUEUE doesn't matter.  I added the include to
> arch/ppc/kernel/process.c and the resulting kernel boots ok, but this
> is probably not the correct place to put it.

It is.  Needs to go with INIT_TASK.

>     cris and m68k don't have an init_task.c either.

Thanks!  Will spin up a patch.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
