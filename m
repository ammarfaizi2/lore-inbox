Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUKRUIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUKRUIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUKRUIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:08:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:19604 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbUKRUHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:07:14 -0500
Date: Thu, 18 Nov 2004 12:07:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-ID: <20041118120712.S2357@build.pdx.osdl.net>
References: <20041118105546.Q2357@build.pdx.osdl.net> <Pine.LNX.4.44.0411181932250.4013-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0411181932250.4013-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Nov 18, 2004 at 07:41:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> Check the comment on find_vma in mm/mmap.c:
> /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> but perhaps you thought it returns NULL if addr is not covered by a vma?

Ah, yes, being at top of stack was part of my assumption.  But I see
your point.  I think find_vma_intersection() might make best sense then.

thanks,
-chris
