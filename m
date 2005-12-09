Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVLIRI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVLIRI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVLIRI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:08:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1941 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964799AbVLIRI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:08:27 -0500
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix
	coding style
From: Adam Litke <agl@us.ibm.com>
To: Mark Rustad <MRustad@mac.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 11:05:43 -0600
Message-Id: <1134147943.25408.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 10:39 -0600, Mark Rustad wrote:
> This patch makes the function make_huge_pte non-static, so it can be used
> by drivers that want to mmap huge pages. Consequently, a prototype for the
> function is added to hugetlb.h. Since I was looking here, I noticed some
> coding style problems in the function and fix them with this patch.
> 
> Signed-off-by: Mark Rustad <MRustad@mac.com>

Call me crazy, but I cringe when I think of any old driver directly
mucking with huge_ptes.  Forgive me if I am missing something, but why
can't you just call do_mmap with a hugetlbfs file like everyone else?
Otherwise, the CodingStyle cleanups look alright.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

