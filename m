Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWEZXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWEZXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWEZXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:37:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23952
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S964827AbWEZXhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:37:19 -0400
Date: Fri, 26 May 2006 16:37:28 -0700 (PDT)
Message-Id: <20060526.163728.13768279.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] fix update_mmu_cache in fremap.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0605262340130.9720@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605261926350.24818@blonde.wat.veritas.com>
	<20060526.131059.27783433.davem@davemloft.net>
	<Pine.LNX.4.64.0605262340130.9720@blonde.wat.veritas.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 26 May 2006 23:43:47 +0100 (BST)

> Sure it's important for not-previously-present mappings, when you're
> installing a present pte.  But the "file pte" being installed by
> install_file_pte is not a real pte - it's a non-present entry (like
> a swap entry), noting what file offset should be mapped there when
> there's a fault (in a non-linear vma where that's not obvious).

My bad, the update_mmu_cache() certainly is erroneous in that
case.

Thanks for the clarification.
