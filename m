Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVKUXUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVKUXUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKUXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:20:34 -0500
Received: from ozlabs.org ([203.10.76.45]:13294 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932470AbVKUXUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:20:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.21410.203627.607569@cargo.ozlabs.ibm.com>
Date: Tue, 22 Nov 2005 10:09:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: powerpc ptlock comments
In-Reply-To: <Pine.LNX.4.61.0511212033330.19274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511212033330.19274@goblin.wat.veritas.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:

> Update comments (only) on page_table_lock and mmap_sem in arch/powerpc.

[snip]

>  	/*
> -	 * No need to use ldarx/stdcx here because all who
> -	 * might be updating the pte will hold the
> -	 * page_table_lock
> +	 * No need to use ldarx/stdcx here
>  	 */

If you're going to remove the because clause you might as well remove
the whole comment.  What you have left is either redundant or
mystifying (according to the depth of knowledge of the reader).  And
in fact I don't think I could now say why we don't need an atomic
update sequence there, so I would appreciate something that updates
the "because" part.

Paul.
