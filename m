Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUJBSTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUJBSTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUJBSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:19:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7103 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267474AbUJBSTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:19:07 -0400
Message-ID: <415EF069.7090902@watson.ibm.com>
Date: Sat, 02 Oct 2004 14:16:09 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>	<415ED4A4.1090001@watson.ibm.com> <20041002105305.2caf97ae.pj@sgi.com>
In-Reply-To: <20041002105305.2caf97ae.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:
> Hubertus wrote:
> 
>>Marc, cpusets lead to physical isolation.
> 
> 
> This is slightly too terse for my dense brain to grok.
> Could you elaborate just a little, Hubertus?  Thanks.
> 

A minimal quote from your website :-)

"CpuMemSets provides a new Linux kernel facility that enables system 
services and applications to specify on which CPUs they may be 
scheduled, and from which nodes they may allocate memory."

Since I have addressed the cpu section it seems obvious that
in order to ISOLATE different workloads, you associate them onto
non-overlapping cpusets, thus technically they are physically isolated
from each other on said chosen CPUs.

Given that cpuset hierarchies translate into cpu-affinity masks,
this desired isolation can result in lost cycles globally.

I believe this to be orthogonal to share settings. To me both
are extremely desirable features.

I also pointed out that if you separate mechanism from API, it
is possible to move the CPU set API under the CKRM framework.
I have not thought about the memory aspect.

-- Hubertus


