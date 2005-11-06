Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVKFXh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVKFXh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVKFXh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:37:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3292
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932367AbVKFXh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:37:56 -0500
Date: Sun, 06 Nov 2005 15:36:06 -0800 (PST)
Message-Id: <20051106.153606.110773756.davem@davemloft.net>
To: akpm@osdl.org
Cc: hugh@veritas.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051106151326.63cf16bd.akpm@osdl.org>
References: <20051106112838.0d524f65.akpm@osdl.org>
	<Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
	<20051106151326.63cf16bd.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 6 Nov 2005 15:13:26 -0800

> I doubt if there's much benefit to pagetable-pages-in-slab, really.

It helps for D-cache coloring, that's mainly why ppc uses them
this way I think.

I would do the same on sparc64 if I didn't have to virtually
map the page tables for the fast TLB miss handlers.
