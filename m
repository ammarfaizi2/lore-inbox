Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbSIZMzs>; Thu, 26 Sep 2002 08:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbSIZMzs>; Thu, 26 Sep 2002 08:55:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59535 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262512AbSIZMzs>;
	Thu, 26 Sep 2002 08:55:48 -0400
Date: Thu, 26 Sep 2002 18:35:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020926183558.D18906@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D92BE07.B6CDFE54@digeo.com> <20020926175445.B18906@in.ibm.com> <20020926122909.GN3530@holomorphy.com> <20020926181052.C18906@in.ibm.com> <20020926124244.GO3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926124244.GO3530@holomorphy.com>; from wli@holomorphy.com on Thu, Sep 26, 2002 at 05:42:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:42:44AM -0700, William Lee Irwin III wrote:
> This is only aggravated by cacheline bouncing on SMP. The reductions
> of system cpu time will doubtless be beneficial for all.

On SMP, I would have thought that only sharing the fd table
while cloning tasks (CLONE_FILES) affects performance by bouncing the rwlock
cache line. Are there a lot of common workloads where this happens ?

Anyway the files_struct_rcu patch for 2.5.38 is up at
http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=112473

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
