Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVJKSY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVJKSY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVJKSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:24:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47782 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932255AbVJKSY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:24:28 -0400
Subject: [PATCH 0/3] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, David Gibson <david@gibson.dropbear.id.au>,
       ak@suse.de, hugh@veritas.com
Content-Type: text/plain
Organization: IBM
Date: Tue, 11 Oct 2005 13:24:17 -0500
Message-Id: <1129055057.22182.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the next iteration of these patches.  I think I've handled
the truncate() case by comparing the hugetlbfs inode's i_size with the
mapping offset of the requested page to make sure it hasn't been
truncated.  Can anyone confirm or deny that I have the locking correct
for this?  The other patches are still unchanged.  Andrew: Did Andi
Kleen's explanation of huge_pages_needed() satisfy?
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

