Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbTDVOUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTDVOUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:20:47 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63205 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263165AbTDVOUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:20:45 -0400
Date: Tue, 22 Apr 2003 07:32:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <171070000.1051021955@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.c
 om>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It also makes it easy to calculate the overhead of the pte chains: twice
> the amount of pagetable overhead. Ie. with 32-bit pte's it's +8 bytes
> overhead, or +0.2% of RAM overhead per mapped page, using a 4K page. With
> 64-bit ptes on 32-bit platforms (PAE), the overhead is still 8 bytes. On
> 64-bit platforms using 8K pages the overhead is still +0.2% of RAM, in
> additionl to the 0.1% of RAM overhead for the pte itself. The worst-case
> is 64-bit platforms with a 4K pagesize, there the overhead is +0.4% of
> RAM, in addition to the 0.2% overhead caused by the pte itself.

Oh, BTW. You're assuming no sharing of any pages in the above. Look what
happens if 1000 processes share the same page ... 

M.

