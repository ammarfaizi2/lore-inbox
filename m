Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUHEU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUHEU7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUHEU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:58:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35569 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267973AbUHEU6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:58:25 -0400
Date: Thu, 05 Aug 2004 13:55:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>, Dan Higgins <djh@sgi.com>,
       linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       lse-tech@lists.sourceforge.net, Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <256150000.1091739330@flay>
In-Reply-To: <20040805101038.3740.52850.89920@sam.engr.sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805101038.3740.52850.89920@sam.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cpusets extend the usefulness of, the existing placement support that
> was added to Linux 2.6 kernels: sched_setaffinity() for CPU placement,
> and mbind and set_mempolicy for memory placement.  On smaller or
> dedicated use systems, the existing calls are often sufficient.
> 
> On larger NUMA systems, running more than one, performance critical,
> job, it is necessary to be able to manage jobs in their entirety.
> This includes providing a job with exclusive CPU and memory that no
> other job can use, and being able to list all tasks currently in a
> cpuset.

I'm not sure I understand the rationale behind this ... perhaps you could
explain it further. We already have mechanisms to bind a process to 
particular CPUs or node's memory. 

To provide exclusivity seems valuable ... ie to stop the default 
allocations using node X's memory, or CPU Y, and potentially even to
migrate existing users off that.

But that'd seem to be a whole lot simpler than this patch ... what else
are we gaining from CPU sets? The patch is massive, so hard to see exactly
what you're doing ... is the point to add back virtualized memory and 
CPU numbering sets specific to each process or group of them, a la 
cpumemsets thing you were posting a year or two ago?

M.


