Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVC0SUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVC0SUC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVC0SUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:20:02 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:19163
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261351AbVC0STc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:19:32 -0500
Date: Sun, 27 Mar 2005 10:17:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, akpm@osdl.org,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-Id: <20050327101739.48c843e1.davem@davemloft.net>
In-Reply-To: <20050327085725.A30883@flint.arm.linux.org.uk>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
	<20050325212234.F12715@flint.arm.linux.org.uk>
	<4244C3B7.4020409@yahoo.com.au>
	<20050326113530.A12809@flint.arm.linux.org.uk>
	<424566E0.80001@yahoo.com.au>
	<20050326155254.E12809@flint.arm.linux.org.uk>
	<42462B7A.4080305@yahoo.com.au>
	<20050327085725.A30883@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005 08:57:25 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Unfortunately not - free_pgd_slow doesn't have any knowledge about the
> mm_struct that the pgd was associated with.

You could store the mm pointer in the page struct of the
pgd, we used to that before set_pte_at() existed on
sparc64 and ppc64 for pte level tables.

page->mapping and page->index are basically free game for
tracking information assosciated with page table chunks.
