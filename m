Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVCYR24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVCYR24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVCYR0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:26:51 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:14502
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261701AbVCYRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:24:24 -0500
Date: Fri, 25 Mar 2005 09:23:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-Id: <20050325092350.629662e0.davem@davemloft.net>
In-Reply-To: <4243A310.1050904@yahoo.com.au>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com>
	<4243A257.8070805@yahoo.com.au>
	<4243A310.1050904@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 16:35:12 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Oh - one other question too. Doing the unmap and page table freeing in
> the same pass will put freed pagecache pages in the same mmu_gather as
> the freed page table pages. This looks like it may be a problem for
> sparc64?

No, that's fine, the code can handle this situation.

