Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWHRS6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWHRS6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWHRS6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:58:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53163 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161074AbWHRS5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:57:53 -0400
Date: Fri, 18 Aug 2006 11:56:24 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: akpm@osdl.org, riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, hch@infradead.org, saw@sw.ru,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, ak@suse.de, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, xemul@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060818115624.fd875624.pj@sgi.com>
In-Reply-To: <1155925065.26155.17.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
	<20060817084033.f199d4c7.akpm@osdl.org>
	<20060818120809.B11407@castle.nmd.msu.ru>
	<1155912348.9274.83.camel@localhost.localdomain>
	<20060818094248.cdca152d.akpm@osdl.org>
	<1155925065.26155.17.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> In order to minimize this effect, resource controllers should be
> providing both minimum and maximum amount of resources available for a
> resource group.

No - not "should be."  Rather "could also be."

The fair sharing model (such as in CKRM) that strives for maximum
utilization of resources respecting priorities and min/max limits is
(I suppose) quite useful for certain workloads and customers.

The hardwall NUMA placement model (such as in cpusets) that strives
for maximum processor and memory isolation between jobs, preferring
to leave allocated resources unused rather than trying to share them,
is also quite useful for some.  Customers with 256 thread, one or
two day long run time, -very- tightly coupled huge OpenMP Fortran
jobs that need to complete within a few percent of the same time,
every runtime, demand it.

Don't presume that fair sharing -should- always be preferred to
hardwall NUMA placement.

Just not so.

Besides -- what benefit would CKRM gain from Andrew's latest
brainstorm?  Doesn't CKRM already have whatever means it needs to
define and share pools of memory?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
