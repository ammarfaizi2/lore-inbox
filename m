Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHNPJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHNPJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 11:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUHNPJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 11:09:41 -0400
Received: from jade.spiritone.com ([216.99.193.136]:19345 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S263664AbUHNPJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 11:09:38 -0400
Date: Sat, 14 Aug 2004 08:09:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Lawrence E. Freil" <lef@freil.com>, linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Message-ID: <102660000.1092496160@[10.10.2.4]>
In-Reply-To: <200408140211.i7E2BNSg027992@dogwood.freil.com>
References: <200408140211.i7E2BNSg027992@dogwood.freil.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. I have discovered an issue with the Linux 2.6.7 kernel when HIMEM is
>    enabled which exhibits itself as a slowdown in directory access regardless
>    of filesystem used.  When HIMEM is disabled the performance returns to
>    normal.  The test I ran was a simple "/usr/bin/time ls -l" of a directory
>    with 3000 empty files.  With HIMEM enabled in the kernel this takes
>    approximately 1.5 seconds.  Without HIMEM it takes 0.03 seconds.  The
>    time is 100% CPU and no I/O operations are done to disk.  "time" reports
>    there are 460 "minor" page faults with zero "major" page faults.
>    I believe the issue here is the mapping of pages between high-mem and
>    lowmem in the kernel paging code.  This increase in time for directory
>    accesses doubles to triples times for applications using samba.
>    I have also tested this on another system which had only 512Meg of RAM
>    but with HIMEM set in the kernel and did not experience the problem.
>    I believe it only effects the performance when the paging buffers end
>    up in highmem.

Does time indicate more systime or user time? If it's systime (probably is)
please take a kernel profile of each (see Documentation/basic_profiling.txt).
That'll give us a much better clue what's going on.

M.

