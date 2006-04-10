Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDJUVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDJUVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDJUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:21:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13737 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751167AbWDJUVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:21:33 -0400
Date: Mon, 10 Apr 2006 13:20:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Adam Litke <agl@us.ibm.com>, wli@holomorphy.com
Subject: Re: [RFC/PATCH] Shared Page Tables [0/2]
In-Reply-To: <200ED4FEFEB8AA8427120DE7@[10.1.1.4]>
Message-ID: <Pine.LNX.4.64.0604101320100.24029@schroedinger.engr.sgi.com>
References: <1144685588.570.35.camel@wildcat.int.mccr.org>
 <Pine.LNX.4.64.0604101020230.22947@schroedinger.engr.sgi.com>
 <200ED4FEFEB8AA8427120DE7@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Dave McCracken wrote:

> The lock changes to hugetlb are only to support sharing of pmd pages when
> they contain hugetlb pages.  They just substitute the struct page lock for
> the page_table_lock, and are only about 30 lines of code.  Is this really
> worth separating out?

Ia64 does not use pmd pages for huge pages. It relies instead on a 
separate region. I wonder if this works on IA64.

