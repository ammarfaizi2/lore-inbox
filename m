Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVIILl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVIILl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVIILl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:41:57 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:46218 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030259AbVIILl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:41:57 -0400
Date: Fri, 09 Sep 2005 20:38:49 +0900 (JST)
Message-Id: <20050909.203849.33293224.taka@valinux.co.jp>
To: pj@sgi.com
Cc: magnus.damm@gmail.com, kurosawa@valinux.co.jp, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050908225539.0bc1acf6.pj@sgi.com>
References: <20050909013804.1B64B70037@sv1.valinux.co.jp>
	<aec7e5c305090821126cea6b57@mail.gmail.com>
	<20050908225539.0bc1acf6.pj@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> magnus wrote:
> > Maybe it is possible to have an hierarchical model and keep the
> > framework simple and easy to understand while providing guarantees,
> 
> Dinakar's patches to use cpu_exclusive cpusets to define dynamic
> sched domains accomplish something like this.
> 
> What scheduler domains and resource control domains both need
> are non-overlapping subsets of the CPUs and/or Memory Nodes.
> 
> In the case of sched domains, you normally want the subsets
> to cover all the CPUs.  You want every CPU to have exactly
> one scheduler that is responsible for its scheduling.
> 
> In the case of resource control domains, you perhaps don't
> care if some CPUs or Memory Nodes have no particular resources
> constraints defined for them.  In that case, every CPU and
> every Memory Node maps to _either_ zero or one resource control
> domain.
> 
> Either way, a 'flat model' non-overlapping partitioning of the
> CPUs and/or Memory Nodes can be obtained from a hierarchical
> model (nested sets of subsets) by selecting some of the subsets
> that don't overlap ;).  In /dev/cpuset, this selection is normally
> made by specifying another boolean file (contains '0' or '1')
> that controls whether that cpuset is one of the selected subsets.

What do you think if you make cpusets for sched domain be able to
have their siblings, which have the same attribute and share
their resources between them.

I guess it would be simple.

Thanks,
Hirokazu Takahashi.
