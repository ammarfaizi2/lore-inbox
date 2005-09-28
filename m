Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVI1UZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVI1UZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVI1UZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:25:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:62420 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750777AbVI1UZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:25:49 -0400
Subject: [PATCH 0/3] Demand faulting for huge pages
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Content-Type: text/plain
Organization: IBM
Date: Wed, 28 Sep 2005 15:25:41 -0500
Message-Id: <1127939141.26401.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.  Can we give hugetlb demand faulting a spin in the mm tree?
And could people with alpha, sparc, and ia64 machines give them a good
spin?  I haven't been able to test those arches yet.

-Thanks

- htlb-get_user_pages removes an optimization that is no longer valid
when demand faulting huge pages

- htlb-fault moves the fault logic from hugetlb_prefault() to
hugetlb_pte_fault() and find_get_huge_page().

- htlb-acct adds an overcommit check to maintain the no-overcommit
semantics provided by hugetlb_prefault()
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

