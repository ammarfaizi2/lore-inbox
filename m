Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274906AbTHAAyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274910AbTHAAyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:54:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59066 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S274906AbTHAAyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:54:41 -0400
Date: Thu, 31 Jul 2003 17:57:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <393910000.1059699469@flay>
In-Reply-To: <20030801005310.GM15452@holomorphy.com>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com> <390810000.1059698875@flay> <20030801005310.GM15452@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, I wrote:
>>>         pgd_cache = kmem_cache_create("pgd",
>>>                                 PTRS_PER_PGD*sizeof(pgd_t),
>>>                                 0,
>>>                                 SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
>>>                                 pgd_ctor,
>>>                                 PTRS_PER_PMD == 1 ? pgd_dtor : NULL);
> 
> On Thu, Jul 31, 2003 at 05:47:55PM -0700, Martin J. Bligh wrote:
>> I think this was just virgin -mm1, I can go back and double check ...
>> Not sure what the stuff about backing out other peoples patches was
>> all about, I just pointed out the crash.
> 
> pgd_dtor() will never be called on PAE due to the above code (thanks to
> the PTRS_PER_PMD check), _unless_ mingo's patch is applied (which backs
> out the PTRS_PER_PMD check).

OK, might have made a mistake ... I can rerun it if you want, but the 
latest kernel seems to work now.

M.

