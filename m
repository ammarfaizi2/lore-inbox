Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263991AbTKDIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 03:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTKDIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 03:50:26 -0500
Received: from ns.suse.de ([195.135.220.2]:44002 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263991AbTKDIuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 03:50:23 -0500
Date: Tue, 4 Nov 2003 09:49:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031104084929.GH1477@suse.de>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103205234.GA17570@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04 2003, Herbert Xu wrote:
> On Mon, Nov 03, 2003 at 01:25:00PM +0100, Jens Axboe wrote:
> > 
> > I think the best fix would be to simply not allow more than one page
> > that needs to be bounced to a bio. The problem is that the whole bio and
> 
> Here is an alternative solution, what if we simply disregarded high
> pages when doing the recount?  Something like this,

That could work, but it breaks the rule that counts are always accurate.
I'd have to audit some drivers to rule that completely safe, although it
seems harmless. The idea is sound, though.

-- 
Jens Axboe

