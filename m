Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTE2QF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTE2QF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:05:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16307
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262341AbTE2QF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:05:26 -0400
Date: Thu, 29 May 2003 18:19:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       m.c.p@wolk-project.de, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529161908.GO1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <200305290000.12116.kernel@kolivas.org> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529135508.GC21673@alpha.home.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:55:08PM +0200, Willy Tarreau wrote:
> So, could the people who report long hangs retry with swap disabled ?
> Can we limit the amount of memory consummed by the cache during such a write ?

the vm should be (i.e. is supposed to be) smart enough not to unmap
anything significant just because of large writes. I'm sure it's not
swapping anything on my desktop during write flood (and certainly not
the mouse pointer) but checking with swapoff is certainly a good hint to
be sure.

Andrea
