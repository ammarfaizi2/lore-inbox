Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUCLMqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUCLMqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:46:54 -0500
Received: from holomorphy.com ([207.189.100.168]:22533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262079AbUCLMqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:46:52 -0500
Date: Fri, 12 Mar 2004 04:46:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312124638.GR655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com> <20040312122127.GQ30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312122127.GQ30940@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:21:27PM +0100, Andrea Arcangeli wrote:
> you missed the fact mremap doesn't work, that's the fundamental reason
> for the vma tracking, so you can use vm_pgoff.
> if you take Hugh's anonmm, mremap will be attaching a persistent dynamic
> overhead to the vma it touches. Currently it does in form of pte_chains,
> that can be converted to other means of overhead, but I simply don't
> like it.
> I like all vmas to be symmetric to each other, without special hacks to
> handle mremap right.
> We have the vm_pgoff to handle mremap and I simply use that.

Absolute guarantees are nice but this characterization is too extreme.
The case where mremap() creates rmap_chains is so rare I never ever saw
it happen in 6 months of regular practical use and testing. Their
creation could be triggered only by remap_file_pages().


-- wli
