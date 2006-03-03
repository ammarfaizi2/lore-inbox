Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752003AbWCCGp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbWCCGp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCCGp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:45:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752003AbWCCGp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:45:56 -0500
Date: Thu, 2 Mar 2006 22:44:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au, steiner@sgi.com,
       hawkes@sgi.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060302224428.66eb29af.akpm@osdl.org>
In-Reply-To: <20060302223348.56f661ad.pj@sgi.com>
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
	<20060301234215.62010fec.akpm@osdl.org>
	<20060302111201.cf61552f.pj@sgi.com>
	<20060302135227.012134f9.akpm@osdl.org>
	<20060302223348.56f661ad.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
>  > From: Andrew Morton <akpm@osdl.org>
>  > 
>  > We presently ignore the return values from initcalls.  But that can carry
>  > useful debugging information.  So print it out if it's non-zero.
>  > 
>  > Also make that warning message more friendly by printing the name of the
>  > initcall function.
> 
>  I tried this patch on my sicko kernel, and the following
>  additional line came out, as expected:
> 
>    initcall at 0xa0000001007cc4c0: topology_init+0x0/0x280(): returned with error code -12

Yes, I've just been looking at the output.  There are quite a few ENODEV's
of course.  But it's pretty obvious what's going on from the name of the
function.  It does remind you that you have drivers in vmlinux which aren't
doing anything useful.

We'll see how it goes.
