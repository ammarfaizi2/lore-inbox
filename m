Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVAGAOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVAGAOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVAGAFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:05:09 -0500
Received: from holomorphy.com ([207.189.100.168]:41921 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263124AbVAFX7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:59:04 -0500
Date: Thu, 6 Jan 2005 15:58:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Andi Kleen <ak@muc.de>, Hugh Dickins <hugh@veritas.com>,
       Ray Bryant <raybry@sgi.com>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050106235830.GE9636@holomorphy.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <41DDCD2B.4060709@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DDCD2B.4060709@mvista.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> You need lazy hugetlbfs to use it (= allocate at page fault time,
>> not mmap time). Otherwise the policy can never be applied. I implemented 
>> my own version of lazy allocation for SLES9, but when I wanted to 
>> merge it into mainline some other people told they had a much better 
>> singing&dancing lazy hugetlb patch. So I waited for them, but they 
>> never went forward with their stuff and their code seems to be dead
>> now. So this is still a dangling end :/
>> If nothing happens soon regarding the "other" hugetlb code I will
>> forward port my SLES9 code. It already has NUMA policy support.
>> For now you can remove the hugetlb policy code from mainline if you
>> want, it would be easy to readd it when lazy hugetlbfs is merged.

On Thu, Jan 06, 2005 at 03:43:39PM -0800, Steve Longerbeam wrote:
> if you don't mind I'd like to. Sounds as if lazy hugetlbfs would be
> able to make use of the generic file mapping->policy instead of a
> hugetlb-specific policy anyway. Same goes for shmem.

If Andi's comments refer to my work, it already got permavetoed.

Anyway, using the vma's is a minor change. Please include this as a
patch separate from other changes (fault handling, consolidations, etc.)


-- wli
