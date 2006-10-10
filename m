Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWJJE64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWJJE64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 00:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWJJE64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 00:58:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:52688 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964973AbWJJE6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 00:58:55 -0400
Subject: Re: ptrace and pfn mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061010034606.GJ15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442987.32237.34.camel@localhost.localdomain>
	 <20061010022310.GC15822@wotan.suse.de>
	 <1160448466.32237.59.camel@localhost.localdomain>
	 <20061010025821.GE15822@wotan.suse.de>
	 <1160451656.32237.83.camel@localhost.localdomain>
	 <20061010034606.GJ15822@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 14:58:15 +1000
Message-Id: <1160456295.32237.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since we decided it would be better to make a new function or some arch
> specfic hooks rather than switch mm's in the kernel? ;)
> 
> No, I don't know. Your idea might be reasonable, but I really haven't
> thought about it much.

Another option is to take the PTE lock while doing the accesses for that
PFN... might work. We still need a temp kernel buffer but that would
sort-of do the trick.

Ben.


