Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbULHR5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbULHR5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbULHR5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:57:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20865 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261292AbULHR5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:57:18 -0500
Date: Wed, 8 Dec 2004 09:57:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Luck, Tony" <tony.luck@intel.com>
cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: Anticipatory prefaulting in the page fault handler V1
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F02844270@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0412080956200.27324@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02844270@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, Luck, Tony wrote:

> >If a fault occurred for page x and is then followed by page
> >x+1 then it may be reasonable to expect another page fault
> >at x+2 in the future.
>
> What if the application had used "madvise(start, len, MADV_RANDOM)"
> to tell the kernel that this isn't "reasonable"?

We could use that as a way to switch of the preallocation. How expensive
is that check?
