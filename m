Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVCYWVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVCYWVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVCYWU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:20:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:33993 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261847AbVCYWSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:18:11 -0500
Subject: Re: [Ext2-devel] Re: OOM problems on 2.6.12-rc1 with many fsx tests
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, andrea@suse.de, mjbligh@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20050325135630.28cd492c.akpm@osdl.org>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
	 <1111607584.5786.55.camel@localhost.localdomain>
	 <20050325135630.28cd492c.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1111788665.21169.54.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2005 14:11:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 13:56, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
> > 2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
> > hours the system hit OOM, and OOM keep killing processes one by one. I
> > could reproduce this problem very constantly on a 2 way PIII 700MHZ with
> > 512MB RAM. Also the problem could be reproduced on running the same test
> > on reiser fs.
> > 
> > The fsx command is:
> > 
> > ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
> 
> I was able to reproduce this on ext3.  Seven instances of the above leaked
> 10-15MB over 10 hours.  All of it permanently stuck on the LRU.
> 
> I'll continue to poke at it - see what kernel it started with, which
> filesystems it affects, whether it happens on UP&&!PREEMPT, etc.  Not a
> quick process.

I reproduced *similar* issue with 2.6.11. The reason I say similar, is
there is no OOM kill, but very low free memory and machine doesn't
respond at all. (I booted my machine with 256M memory and ran 20 copies
of fsx on ext3).


Thanks,
Badari

