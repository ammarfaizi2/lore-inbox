Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTLEOWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTLEOWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:22:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:16393 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264137AbTLEOWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:22:44 -0500
Date: Fri, 5 Dec 2003 14:22:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, pinotj@club-internet.fr,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031205142238.A26578@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
	pinotj@club-internet.fr, manfred@colorfullife.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org> <Pine.LNX.4.58.0312041050050.6638@home.osdl.org> <20031204212110.GB567@frodo> <20031205071455.A19514@infradead.org> <20031205203425.B2091516@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031205203425.B2091516@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Fri, Dec 05, 2003 at 08:34:25PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 08:34:25PM +1100, Nathan Scott wrote:
> You might be mixing up pb_pages and pb_addr there?  pb_addr is
> always a pointer.  We need to distinguish whether it was slab
> alloc'd or whether it points into page cache pages, so we know
> whether to page_cache_release the pages or kfree the pointer
> when we're done with the pagebuf.
> 
> The pb_page_array works just as you describe, with a prealloc'd
> array of page pointers, and pb_pages either points to the array
> of to a larger kmalloc'd array as necessary.

Indeed.  I'm not remembering the code as good as I hoped to :)

Sorry for the noise.

