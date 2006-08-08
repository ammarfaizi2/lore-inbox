Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWHHJ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWHHJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWHHJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:58:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6314 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964773AbWHHJ6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:58:40 -0400
To: Jes Sorensen <jes@sgi.com>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>
	<yq0d5bbva98.fsf@jaguar.mkp.net>
From: Andi Kleen <ak@suse.de>
Date: 08 Aug 2006 11:58:39 +0200
In-Reply-To: <yq0d5bbva98.fsf@jaguar.mkp.net>
Message-ID: <p737j1jpn00.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> writes:
> 
> Using that argument, all you need to do is to add the alignment
> ____cacheline_aligned_in_smp to the definition of
> struct futex_hash_bucket and the problem is solved, given that the
> internode cacheline in a NUMA system is defined to be the same as the
> SMP cacheline size.

Yes but it would waste quite a lot of memory and cache.
Wasted cache = slow.

-Andi
