Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUCBWdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCBWcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:32:43 -0500
Received: from [66.62.77.7] ([66.62.77.7]:57737 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262228AbUCBWcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:32:08 -0500
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
From: Dax Kelson <dax@gurulabs.com>
To: Peter Nelson <pnelson@andrew.cmu.edu>
Cc: Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@oss.software.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
In-Reply-To: <4044B787.7080301@andrew.cmu.edu>
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com>
	 <4044B787.7080301@andrew.cmu.edu>
Content-Type: text/plain
Message-Id: <1078266793.8582.24.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 02 Mar 2004 15:33:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 09:34, Peter Nelson wrote:
> Hans Reiser wrote:
> 
> I'm confused as to why performing a benchmark out of cache as opposed to 
> on disk would hurt performance?

My understanding (which could be completely wrong) is that reieserfs v3
and v4 are algorithmically more complex than ext2 or ext3. Reiserfs
spends more CPU time to make the eventual ondisk operations more
efficient/faster.

When operating purely or mostly out of ram, the higher CPU utilization
of reiserfs hurts performance compared to ext2 and ext3.

When your system I/O utilization exceeds cache size and your disks
starting getting busy, the CPU time previously invested by reiserfs pays
big dividends and provides large performance gains versus more
simplistic filesystems.  

In other words, the CPU penalty paid by reiserfs v3/v4 is more than made
up for by the resultant more efficient disk operations. Reiserfs trades 
CPU for disk performance.

In a nutshell, if you have more memory than you know what do to with,
stick with ext3. If you spend all your time waiting for disk operations
to complete, go with reiserfs.

Dax Kelson
Guru Labs

