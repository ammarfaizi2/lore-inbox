Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVINIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVINIvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVINIvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:51:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56778 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965088AbVINIvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:51:03 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: ARCH_FREE_PTE_NR 5350
Date: Wed, 14 Sep 2005 10:50:51 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0509131631140.16498@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509131631140.16498@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141050.51492.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 17:54, Hugh Dickins wrote:

> Partly because all the PTE->PTR typos in include/asm-generic/tlb.h
>
>   #ifdef ARCH_FREE_PTR_NR
>     #define FREE_PTR_NR   ARCH_FREE_PTR_NR
>   #else

Yuck. The initial prototype did something, but a later cleanup broke it :/

> I do think we need to sort this out, but maybe wait until after I've
> done my page_table_lock changes - which do change the picture here
> (the lock is taken lower down), but not solve it (per-cpu mmu_gather
> still needs preemption disabled).

Ok.

-Andi

