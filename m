Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUF2LWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUF2LWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUF2LWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:22:47 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64451 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265703AbUF2LWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:22:44 -0400
Date: Tue, 29 Jun 2004 04:21:40 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Sylvain <sylvain.jeaugey@bull.net>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
Subject: [patch 1/8] cpusets v3 - Table of Contents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set is being offered for review and comment.

Shortly, not yet, I expect to be requesting Andrew to consider it
for inclusion in *-mm.  Andrew will be glad to hear that this patch
set (outside of Matthew Dobson's nodemask patch) has _much_ less
impact on existing kernel code than my previous cpumask patch set ;).

First I still need to perform further testing, obtain more feedback,
and do some more documentation and a man page, before asking to get
it into *-mm.  My thanks to those who have reviewed it so far.

The bulk of the code and much of the design work in this patch has
been done by Simon Derr <Simon.Derr@bull.net> of Bull (France).
The nodemask patch is a preliminary draft of work by Matthew
Dobson, based on my cpumask patches.

This version of the cpuset patch set is against 2.6.7-mm4.

These patches provide the essential kernel support for cpusets, which
enable identifying a hierarchy of subsets of system CPU and Memory Node
resources and attaching tasks to these subsets.  Tasks may only request
to use (sched_setaffinity, mbind and set_mempolicy) the CPUs and Memory
Nodes allowed to it by its cpuset.  Cpusets may be strictly exclusive
(other non-ancestral cpusets may not overlap).  One can list which
tasks are in which cpusets, and change which cpuset a task is in.
No new system calls are used; all access and modification is via a
cpuset virtual file system.

See further the Cpuset Overview, item [2/9] of this email set.

==> I recommend that first time readers look first at items (2) Overview
    and (7) Kernel Hooks PATCH, for a better understanding of what this
    cpuset kernel patch is intended to do, and the very small kernel
    footprint required to accomplish this.

Now I have several email messages to present.  Items 2 through 8
will be sent as replies to this first message.

  1) This table of contents.
  2) Overview of kernel cpusets - a small text document.
  3) [patch] cpumask_consts - minor fix to my cpumask patch set
  4) [patch] nodemask - nodemask patch (draft of Matthew Dobson's patch)
  5) [patch] cpuset_bitmap_lists - add bitmap lists format
  6) [patch] cpuset_new_files - Main cpuset patch - cpuset.c, cpuset.h
  7) [patch] cpuset_kernel_hooks - The few, small kernel hooks needed
  8) [patch] cpuset_proc_hooks - One more hook, for /proc/<pid>/cpuset.

Your feedback is welcome.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
