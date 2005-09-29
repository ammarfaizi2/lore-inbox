Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVI2JpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVI2JpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVI2JpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:45:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:32390 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751295AbVI2JpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:45:23 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: agl@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3 htlb-acct] Demand faulting for huge pages
References: <1127939141.26401.32.camel@localhost.localdomain>
	<1127939593.26401.38.camel@localhost.localdomain>
	<20050928232027.28e1bb93.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Sep 2005 11:45:12 +0200
In-Reply-To: <20050928232027.28e1bb93.akpm@osdl.org>
Message-ID: <p73k6h0jjh3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

(having written the original SLES9 code I will chime in ...) 

> > +unsigned long
> > +huge_pages_needed(struct address_space *mapping, struct vm_area_struct *vma)
> > +{
> 
> What does this function do?  Seems to count all the present pages within a
> vma which are backed by a particular hugetlbfs file?  Or something?

It counts how many huge pages are still needed to fill up a mapping completely.
In short it counts the holes. I think the name fits.

-Andi

