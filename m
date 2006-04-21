Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWDUWNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWDUWNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWDUWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:13:31 -0400
Received: from canuck.infradead.org ([205.233.218.70]:26587 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932485AbWDUWNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:13:31 -0400
Subject: Re: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Mikael Starvik <mikael.starvik@axis.com>, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604212150270.9101@blonde.wat.veritas.com>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <4448D8BF.9040601@yahoo.com.au>
	 <1145646503.11909.222.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0604212150270.9101@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 23:12:53 +0100
Message-Id: <1145657573.11909.226.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 21:57 +0100, Hugh Dickins wrote:
> 
> } __attribute__((aligned(sizeof(long))));
>         /*
>          * On most architectures that alignment is already the case; but
>          * must be enforced here for CRIS, to let the least signficant bit
>          * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
>          */
> 
> You can often get away with it - I notice we never added the same
> alignment to struct anon_vma, which in theory needed it just as much.
> Some accident of how structures are packed into slabs on CRIS, I suppose.

That sounds very strange to me, but it's harmless enough to add the
explicit alignment.

-- 
dwmw2

