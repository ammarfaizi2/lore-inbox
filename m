Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVFGOiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVFGOiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFGOiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:38:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:23508 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261430AbVFGOiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:38:11 -0400
Date: Tue, 7 Jun 2005 16:38:06 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mbind: fix verify_pages pte_page
Message-ID: <20050607143806.GF23831@wotan.suse.de>
References: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506062046590.5000@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 08:48:27PM +0100, Hugh Dickins wrote:
> Strict mbind's check that pages already mapped are on right node has been
> using pte_page without checking if pfn_valid, and without page_table_lock
> to prevent spurious failures when try_to_unmap_one intervenes between the
> pte_present and the pte_page.

Thanks. Looks good.

-Andi
