Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVD0Ru5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVD0Ru5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVD0RtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:49:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63899 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261852AbVD0Rrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:47:40 -0400
Subject: Re: any way to find out kernel memory usage?
From: Robert Love <rml@novell.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <426FCF7B.5020806@nortel.com>
References: <426FBFED.9090409@nortel.com> <426FC0FE.2090900@oktetlabs.ru>
	 <426FC46C.4070306@nortel.com> <1114622438.10836.8.camel@betsy>
	 <426FCF7B.5020806@nortel.com>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 13:47:15 -0400
Message-Id: <1114624035.10836.19.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 11:44 -0600, Chris Friesen wrote:

> Okay, so can I get the total amount of memory used by the kernel based 
> on meminfo output?  (Slab + VmallocUsed) maybe?

I don't think that will include page tables, unless the architecture
allocates page tables from slab (some might, especially recently).

And it won't have memory that didn't come from slab, e.g.
get_free_pages() or anything else right off the buddy allocator.

There is no easy way to do this.  To do it right, we'd need fine-grained
accounting.

	Robert Love


