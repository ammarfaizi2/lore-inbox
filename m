Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUDDWzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbUDDWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:55:44 -0400
Received: from ozlabs.org ([203.10.76.45]:14824 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262890AbUDDWzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:55:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16496.36001.210779.472061@cargo.ozlabs.ibm.com>
Date: Mon, 5 Apr 2004 08:30:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-aa1 arch updates
In-Reply-To: <20040404154924.GD2164@dualathlon.random>
References: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
	<20040404154924.GD2164@dualathlon.random>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> I'm unsure about the arch/ppc/mm/pgtable.c part, I mean, ppc is being
> tested heavily, how can it be necessary if nobody ever got an oops yet? 
> OTOH your patch certainly cannot hurt and it might be needed after all.
> Maybe I should apply it after all, it'd be nice to get a comment on this
> bit from ppc people who knows tlb.c better to be sure.

We definitely need page->mapping and page->index set on pte and pmd
pages, both on ppc and ppc64.  Otherwise the flush_tlb_* functions
won't work properly.  Hugh's patch looks good to me (at least as far
as the ppc/ppc64 bits are concerned).

Paul.
