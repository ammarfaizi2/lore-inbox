Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWHHKHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWHHKHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWHHKHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:07:49 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:43952 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S964781AbWHHKHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:07:48 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>
	<yq0d5bbva98.fsf@jaguar.mkp.net> <p737j1jpn00.fsf@verdi.suse.de>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Aug 2006 06:07:47 -0400
In-Reply-To: <p737j1jpn00.fsf@verdi.suse.de>
Message-ID: <yq07j1jv8uk.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Andi> Jes Sorensen <jes@sgi.com> writes:
>>  Using that argument, all you need to do is to add the alignment
>> ____cacheline_aligned_in_smp to the definition of struct
>> futex_hash_bucket and the problem is solved, given that the
>> internode cacheline in a NUMA system is defined to be the same as
>> the SMP cacheline size.

Andi> Yes but it would waste quite a lot of memory and cache.  Wasted
Andi> cache = slow.

Compared to the extra level of indirection, I doubt it would be
measurable. The cache space is barely wasted, we're talking
approximately half a cacheline per futex hash bucket in use.

Jes
