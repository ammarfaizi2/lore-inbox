Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUDPDoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUDPDoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 23:44:10 -0400
Received: from fmr03.intel.com ([143.183.121.5]:52887 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262113AbUDPDoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 23:44:07 -0400
Message-Id: <200404160343.i3G3h8F13447@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [0/3]
Date: Thu, 15 Apr 2004 20:43:08 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjY+tfELkHgsp2SEmW4mcQ56AAXAAALs6Q
In-Reply-To: <20040416033251.GH12735@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, April 15, 2004 8:33 PM
> To unify even the non-ppc64 archs we already have to allow for the
> hugepage pagetables to have different structure across archs - on i386
> and ppc64 the hugePTEs lie in PMD slots, on sparc64 and sh they lie in
> (normal) PTE slots and on IA64 they lie in the PTE slots of a special
> set of pagetables.  Given that, it seems conceptually logical to me
> that we also not assume the hugepage PTEs have the same layout as
> normal PTEs.  It makes the handle_mm_fault function not the least more
> complicated.

Correction: huge page pte on ia64 has the same format as a normal page pte.


