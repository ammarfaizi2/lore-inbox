Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUDGWzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDGWzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:55:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:41912 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261231AbUDGWzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:55:10 -0400
Subject: Re: [PATCH] shrink core hashes on small systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040405211916.GH6248@waste.org>
References: <20040405204957.GF6248@waste.org>
	 <20040405140223.2f775da4.akpm@osdl.org>  <20040405211916.GH6248@waste.org>
Content-Type: text/plain
Message-Id: <1081378428.1401.71.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 08:53:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yep. I can reword it in terms of pages, if that helps. Boxes with 8k
> pages tend to have larger instruction words and data structures by
> virtue of being RISC/64bit/etc., so I think 1000 pages is a reasonable
> number in either case.

No. For example, the embedded 4xx IBM CPUs can have several page sizes,
and a size like 16k could be useful for embedded applications: We don't
implement support for that in the ppc32 kernel yet, but we may do, it
makes a _lot_ of sense for small embedded configs with no swap, as it
reduces page tables size & pressure on the TLB software load handlers.

Ben.


