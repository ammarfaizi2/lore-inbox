Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUBFDd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUBFDd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:33:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:48587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266414AbUBFDdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:33:10 -0500
Date: Thu, 5 Feb 2004 19:34:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: lord@xfs.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-Id: <20040205193449.5a8b8c0b.akpm@osdl.org>
In-Reply-To: <402308B6.3060802@cyberone.com.au>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
	<4021AC9F.4090408@xfs.org>
	<20040205191240.13638135.akpm@osdl.org>
	<402308B6.3060802@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >Was it a highmem box?  If so, was the filesystem in question placing
>  >directory pagecache in highmem?  If so, that was really bad on older 2.4:
>  >the directory pagecache in highmem pins down all directory inodes.
>  >
>  >
> 
>  2.6.2-mm1 should fix this I think.

2.6.anything should fix it.  It used to, anyway.

>  In particular, this hunk in vm-shrink-zone.patch

That's on the direct reclaim path - for sane workloads most of the freeing
activity is via kswapd.

