Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVJZUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVJZUOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:14:35 -0400
Received: from fmr21.intel.com ([143.183.121.13]:21959 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964915AbVJZUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:14:35 -0400
Message-Id: <200510262012.j9QKCUg23575@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Adam Litke" <agl@us.ibm.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>, <hugh@veritas.com>,
       "William Irwin" <wli@holomorphy.com>
Subject: RE: RFC: Cleanup / small fixes to hugetlb fault handling
Date: Wed, 26 Oct 2005 13:12:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXZ3A5NQVmMt/EAQKqXci72cdXaSgAh1BlQ
In-Reply-To: <20051026024831.GB17191@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, October 25, 2005 7:49 PM
> - find_lock_huge_page() didn't, in fact, lock the page if it newly
>   allocated one, rather than finding it in the page cache already.  As
>   far as I can tell this is a bug, so the patch corrects it.

add_to_page_cache will lock the page if it was successfully added to the
address space radix tree.  I don't see a bug that you are seeing.

