Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVHEVIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVHEVIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVHEVIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:08:10 -0400
Received: from fmr24.intel.com ([143.183.121.16]:14282 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261960AbVHEVG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:06:29 -0400
Message-Id: <200508052105.j75L5jg31470@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: <ak@suse.de>, <christoph@lameter.com>, <dwg@au1.ibm.com>
Subject: RE: [RFC] Demand faulting for large pages
Date: Fri, 5 Aug 2005 14:05:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWZ00XQTpOmHs4TRqi/fjGiR6pjDwALSojw
In-Reply-To: <1123255298.3121.46.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Friday, August 05, 2005 8:22 AM
> Below is a patch to implement demand faulting for huge pages.  The main
> motivation for changing from prefaulting to demand faulting is so that
> huge page allocations can follow the NUMA API.  Currently, huge pages
> are allocated round-robin from all NUMA nodes.   

Do users of hugetlb going to accept the fact that now app will SIGBUS
when there aren't enough free hugetlb pages present at the time of fault?
It's not very nice though, but is that the general consensus?

