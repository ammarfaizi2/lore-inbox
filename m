Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHYHFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHYHFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWHYHFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:05:08 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:45518 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750721AbWHYHFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:05:06 -0400
Date: Fri, 25 Aug 2006 02:56:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review:
  kernel-level interface
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200608250300_MC3-1-C942-6359@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 15:54:47 -0700, Andrew Morton wrote:

> > > Some users have requested the ability to create a monitoring session
> > > with perfmon2 from iside the kernel using a kernel thread. Perfmon2
> > > leverages a lot of kernel mechanisms which are not easy to use for
> > > inside the kernel: e.g. file descriptor, signals, system calls.
> > 
> > Again, please drop this.  There are no planned intree kernel users
> > so far, and once we add them we can architect a proper API for them.
> > Getting rid of this should also help to collapse the tons of useless
> > abstractions layers in the current perfmon code.
> > 
> 
> Yes, I think we either need a stronger argument for including this code, or
> we drop it.

This interface is for people writing kprobes who want to do performance
monitoring within their probe code.  There will probably never be any
in-kernel users, just like there are no in-kernel users of kprobes.

> It is especially worrisome that the exports which are added here are plain
> old EXPORT_SYMBOL().

kprobes exports are all GPL, so these should be too.

-- 
Chuck

