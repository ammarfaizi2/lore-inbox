Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWJKPn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWJKPn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWJKPn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:43:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:41777 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161086AbWJKPn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:43:57 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,295,1157353200"; 
   d="scan'208"; a="144757034:sNHT1585710056"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>, "linux-mm" <linux-mm@kvack.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <wli@holomorphy.com>
Subject: RE: [RFC] hugetlb: Move hugetlb_get_unmapped_area
Date: Wed, 11 Oct 2006 08:43:38 -0700
Message-ID: <000001c6ed4c$08419150$1680030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbtOcn80lZXPZ+rQS+0EiYuNklUsAAEXwDg
In-Reply-To: <1160573520.9894.27.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Wednesday, October 11, 2006 6:32 AM
> I am trying to do some hugetlb interface cleanups which include
> separation of the hugetlb utility functions (mostly in mm/hugetlb.c)
> from the hugetlbfs interface to huge pages (fs/hugetlbfs/inode.c).
> 
> This patch simply moves hugetlb_get_unmapped_area() (which I'll argue is
> more of a utility function than an interface) to mm/hugetlb.c.  

To me it doesn't look like a clean up.  get_unmapped_area() is one of
file_operations method and it make sense with the current arrangement
that it stays together with .mmap method, which both live in
fs/hugetlbfs/inode.c.

- Ken
