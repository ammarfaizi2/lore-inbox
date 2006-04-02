Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWDBJQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWDBJQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDBJQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:16:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:12694 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932302AbWDBJQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:16:01 -0400
Date: Sun, 2 Apr 2006 14:47:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures dynamically
Message-ID: <20060402091745.GC13423@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060401185644.GC25971@in.ibm.com> <442F2B52.6000205@yahoo.com.au> <20060401233512.B8662@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401233512.B8662@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 11:35:13PM -0800, Siddha, Suresh B wrote:
> Only thing I see in this is, even if there are very few cpus in the
> exclusive cpuset, we end up allocating NR_CPUS groups and waste memory.

I had realized that, but used NR_CPUS just to keep it simple (as is
being done in the case of NUMA - where they simply allocate for
MAX_NODES). I can take a shot at optimizing the memory allocation size
(for NUMA as well) and send another patch later, if people think so.

-- 
Regards,
vatsa
