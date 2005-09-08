Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVIHVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVIHVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVIHVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:15:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28848 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751405AbVIHVP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:15:58 -0400
Subject: [UPDATE] [PATCH 0/3] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: agl@us.ibm.com
Content-Type: text/plain
Organization: IBM
Date: Thu, 08 Sep 2005 16:15:45 -0500
Message-Id: <1126214145.28895.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this out again after incorporating the feedback from Yanmin
Zhang and Dave Hansen.  Are we ready to go for -mm yet?  The only patch
which has seen any recent changes is #2 below so I assume people agree
with #1 and #3 now :)

The three patches:
 1) Remove a get_user_pages() optimization that is no longer valid for
demand faulting
 2) Move fault logic from hugetlb_prefault() to hugetlb_pte_fault()
 3) Apply a simple overcommit check so demand fault accounting behaves
in a manner in line with how prefault worked

Diffed against 2.6.13-git6

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

