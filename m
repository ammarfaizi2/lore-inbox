Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDJULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDJULy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDJULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:11:54 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:43518 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751161AbWDJULw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:11:52 -0400
Date: Mon, 10 Apr 2006 15:11:26 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Adam Litke <agl@us.ibm.com>, wli@holomorphy.com
Subject: Re: [RFC/PATCH] Shared Page Tables [0/2]
Message-ID: <200ED4FEFEB8AA8427120DE7@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.64.0604101020230.22947@schroedinger.engr.sgi.com>
References: <1144685588.570.35.camel@wildcat.int.mccr.org>
 <Pine.LNX.4.64.0604101020230.22947@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, April 10, 2006 10:22:34 -0700 Christoph Lameter
<clameter@sgi.com> wrote:

>> Here's a new cut of the shared page table patch.  I divided it into
>> two patches.  The first one just fleshes out the
>> pxd_page/pxd_page_kernel macros across the architectures.  The
>> second one is the main patch.
>> (...)
> 
> Could you break out the locking changes to huge pages?

The lock changes to hugetlb are only to support sharing of pmd pages when
they contain hugetlb pages.  They just substitute the struct page lock for
the page_table_lock, and are only about 30 lines of code.  Is this really
worth separating out?

Dave McCracken

