Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUBPAB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUBPAB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:01:57 -0500
Received: from holomorphy.com ([199.26.172.102]:29827 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265251AbUBPAB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:01:56 -0500
Date: Sun, 15 Feb 2004 16:01:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial -critical : BUG()gy behaviour on OOM
Message-ID: <20040216000150.GD631@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	BlaisorBlade <blaisorblade_spam@yahoo.it>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200402151647.39907.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402151647.39907.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 04:47:39PM +0100, BlaisorBlade wrote:
> In short: in vanilla 2.6.3-rc2 (and also 2.6.2-mm1) do_swap_page() can return 
> -ENOMEM while value return values are VM_FAULT_*; invalid return values can 
> result in BUG() being called, so this patch (or a better fix) should go in 
> soon. This patch corrects this by returning VM_FAULT_OOM in that case.
> CC me on replies, please, as I'm not subscribed. Thanks.
> In detail: do_swap_page returns -ENOMEM when memory allocation fails; the 
> return value will in turn be returned by handle_pte_fault and handle_mm_fault 
> to this code in do_page_fault:

Yep. This is bust.
akpm please apply.


-- wli
