Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUHPLo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUHPLo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUHPLo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:44:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44966 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267549AbUHPLo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:44:58 -0400
Date: Mon, 16 Aug 2004 12:44:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
In-Reply-To: <20040816104519.GA21628@elte.hu>
Message-ID: <Pine.LNX.4.44.0408161240280.31575-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Ingo Molnar wrote:
> 
> found the unmap_vmas() latency: pages get queued up for TLB flush (and
> subsequent freeing) and the lock-break in unmap_vmas() didnt account for
> this. When there's a preemption request and we do the lock-break it's
> already too late: we first have to free possibly thousands of pages,

Thousands?  Or FREE_PTE_NR 506?  Ah, ia64 has FREE_PTE_NR 2048: thousands.

Hugh

