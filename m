Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUHFP5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUHFP5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUHFPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:54:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4272 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268148AbUHFPyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:54:07 -0400
Message-ID: <4113A950.1050502@watson.ibm.com>
Date: Fri, 06 Aug 2004 11:52:48 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Erich Focht <efocht@hpce.nec.com>, lse-tech@lists.sourceforge.net,
       Paul Jackson <pj@sgi.com>, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <267050000.1091806507@[10.10.2.4]>
In-Reply-To: <267050000.1091806507@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:
>>There's no relation to PAGG but I think cpusets and CKRM should be
>>made to come together. One of CKRM's user interfaces is a filesystem
>>with the file-tree representing the class hierarchy. It's the same for
>>cpusets. 
> 
> 
> OK, that makes sense ...
> 
> 
>>I'd vote for cpusets going in soon. CKRM could be extended by
>>a cpusets controller which should be pretty trivial when using the
>>infrastructure of this patch. It simply needs to create classes
>>(cpusets) and attach processes to them. The enforcement of resources
>>happens automatically. When CKRM is mature to enter the kernel, one
>>could drop /dev/cpusets in favor of the CKRM way of doing it.
> 
> 
> But I think that's dangerous. It's very hard to get rid of existing user
> interfaces ... I'd much rather we sorted out what we're doing BEFORE
> putting either in the kernel.
> 
> M.
> 

We, CKRM, can put this on our stack, once we have settled how we are 
going to address the structural requirements that came out of the kernel 
summit.

As indicated above, this would mean to create a resource controller
and assign mask to them, which is not what we have done so far, as
our current controllers are more share focused. This should be a good 
excercise.

While we are on the topic, do you envision these sets to be somewhat 
hierarchical or simply a flat hierarchy ?

-- Hubertus Franke

