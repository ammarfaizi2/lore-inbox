Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWA0KYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWA0KYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWA0KYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:24:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16690 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964825AbWA0KYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:24:03 -0500
Date: Fri, 27 Jan 2006 11:26:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127102611.GC4311@suse.de>
References: <43D9C19F.7090707@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D9C19F.7090707@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Pierre Ossman wrote:
> I'm having some problems getting high memory support to work smoothly in
> my driver. The documentation doesn't indicate what I might be doing
> wrong so I'll have to ask here.
> 
> The problem seems to be that kmap & co maps a single page into kernel
> memory. So when I happen to cross page boundaries I start corrupting
> some unrelated parts of the kernel. I would prefer not having to
> consider page boundaries in an already messy PIO loop, so I've been
> trying to find either a routine to map an entire sg entry or some way to
> force the block layer to not give me stuff crossing pages.
> 
> As you can guess I have not found anything that can do what I want, so
> some pointers would be nice.

Honestly, just don't bother if you are doing PIO anyways. Just tell the
block layer that you want io bounced for you instead.

-- 
Jens Axboe

