Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUKDAkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUKDAkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKDAcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:32:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56244 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262022AbUKDAbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:31:18 -0500
Date: Thu, 4 Nov 2004 10:28:15 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: truncate issues in 2.6.10-rc1-mm2 ?
Message-ID: <20041103232815.GA7478@frodo>
References: <1099518398.21024.24.camel@dyn318077bld.beaverton.ibm.com> <20041103142928.609a9c64.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103142928.609a9c64.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:29:28PM -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I seem to be running into truncate issues on 2.6.10-rc1-mm2.
> > Kernel compile hangs. Here is the sysrq-t output for the
> > process. Do you know ?
> 
> Beats me.  If we can find a workload which reproduces it in a sane amount
> of time I can do a binary search.

I have also had a report of this on a very recent SLES9 updates
kernel, from looking through the patches the SUSE folks have and
those in the -mm, the invalidate_inode_pages2 patch is in both
so it could be the cause, but thats just a guess so far (patch
name in -mm is invalidate_inode_pages-mmap-coherency-fix.patch).

I don't have a reproducible test case yet either.

cheers.

-- 
Nathan
