Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTH0Kfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTH0Kfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:35:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:4259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263271AbTH0Kfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:35:40 -0400
Date: Wed, 27 Aug 2003 03:38:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: rusty@rustcorp.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030827033836.17310dbc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain>
References: <20030827051853.181C92C0C1@lists.samba.org>
	<Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> But I disagree over move_to/from_swap_cache: nothing should
>  be done there at all.  Once you have mapping,index in struct
>  futex_q, it's irrelevant what tmpfs might be doing to the
>  page->mapping,page->index of the unmapped page.

But move_to_swap_cache() alters a page's ->mapping and ->index when that
page is potentially mapped into user pagetables.



