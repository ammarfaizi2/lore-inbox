Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVBJJJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVBJJJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVBJJJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:09:31 -0500
Received: from colin2.muc.de ([193.149.48.15]:63504 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262062AbVBJJJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:09:06 -0500
Date: 10 Feb 2005 10:09:03 +0100
Date: Thu, 10 Feb 2005 10:09:03 +0100
From: Andi Kleen <ak@muc.de>
To: Pekka Enberg <penberg@gmail.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] relayfs redux, part 4
Message-ID: <20050210090903.GA45994@muc.de>
References: <16906.52160.870346.806462@tut.ibm.com> <84144f02050209233314373462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f02050209233314373462@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Please consider inlining alloc_page_array() and populate_page_array()
> into relay_alloc_rchan_buf() as they're only used once. You'd get rid
> of passing page_count as a pointer this way. If inlining is
> unacceptable, please at least move the n_pages calculation to
> relay_alloc_rchan_buf() to make the API more sane.

Modern gcc (3.3-hammer with unit-at-a-time or 3.4) will do that anyways on 
its own.

-Andi

