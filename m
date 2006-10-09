Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWJIVEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWJIVEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWJIVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:04:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:43465 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964858AbWJIVEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:04:06 -0400
Subject: Re: [patch 4/5] mm: add vm_insert_pfn helpler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061009140447.13840.20975.sendpatchset@linux.site>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 07:03:05 +1000
Message-Id: <1160427785.7752.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	vma->vm_flags |= VM_PFNMAP;

I wouldn't do that here. I would keep that to the caller (and set it
before setting the PTE along with a wmb maybe to make sure it's visible
before the PTE no ?)

Cheers,
Ben.


