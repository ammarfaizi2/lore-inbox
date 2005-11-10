Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVKJBzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVKJBzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVKJBzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:55:53 -0500
Received: from ozlabs.org ([203.10.76.45]:35819 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751432AbVKJBzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:55:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.43166.752587.255943@cargo.ozlabs.ibm.com>
Date: Thu, 10 Nov 2005 12:55:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] mm: remove ppc highpte
In-Reply-To: <Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100148410.5814@goblin.wat.veritas.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:

> ppc's HIGHPTE config option was removed in 2.5.28, and nobody seems to
> have wanted it enough to restore it: so remove its traces from pgtable.h
> and pte_alloc_one.  Or supply an alternative patch to config it back?

I'm staggered.  We do want to be able to have pte pages in highmem.
I would rather just have it always enabled if CONFIG_HIGHMEM=y, rather
than putting the config option back.  I think that should just involve
adding __GFP_HIGHMEM to the flags for alloc_pages in pte_alloc_one
unconditionally, no?

Paul.

