Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUJYV3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUJYV3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUJYV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:26:12 -0400
Received: from fmr03.intel.com ([143.183.121.5]:8174 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S261982AbUJYVZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:25:46 -0400
Message-Id: <200410252122.i9PLMYq08987@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Christoph Lameter" <clameter@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Hugepages demand paging V1 [4/4]: Numa patch
Date: Mon, 25 Oct 2004 14:25:09 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcS4bw5mNHxItXyeQyWZufruVaaz2ACaavdw
In-Reply-To: <20041022194040.GC17038@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:
>> dequeue_huge_page() seems to want a nodemask, not a vma, though I
>> suppose it's not particularly pressing.

On Fri, Oct 22, 2004 at 12:37:13PM -0700, Christoph Lameter wrote:
> How about this variation following __alloc_page:

William Lee Irwin III wrote on Friday, October 22, 2004 12:41 PM
> Looks reasonable. The bit that struck me as quirky was the mpol_* on
> the NULL vma. This pretty much eliminates the hidden dispatch, so I'm
> happy.

The allocate from next best node is orthogonal to hugetlb demand paging.
This should be merged once all the bugs are fixed and later when demand
paging goes in, we can add the mpol_* stuff.

- Ken


