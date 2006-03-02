Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWCBHnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWCBHnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWCBHnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:43:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750980AbWCBHnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:43:40 -0500
Date: Wed, 1 Mar 2006 23:42:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301234215.62010fec.akpm@osdl.org>
In-Reply-To: <20060301221429.c61b4ae6.pj@sgi.com>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
	<20060301202058.42975408.akpm@osdl.org>
	<20060301221429.c61b4ae6.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > It'd be interesting to see if just the data structure expansion:
> 
> Nice guess.
> 
> It still crashes on boot.
> 

OK.   This is awful.   I cannot see it.

If someone passes get_cpu_sysdev() a -ve cpu number then ugly things will
happen, but it's unlikely to be that.  Pretty sad coding though.

> Unable to handle kernel NULL pointer dereference (address 0000000000000058)
> ...
> ip is at sysfs_create_group+0x30/0x2a0

Are you able to determine which pointer deref this is faulting at?  I
couldn't find any fields which look like they're 0x58 bytes into anything.

Thanks for persisting with this.
