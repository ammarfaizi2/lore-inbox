Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVF2LYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVF2LYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVF2LYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:24:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8678 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262546AbVF2LYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:24:24 -0400
Date: Wed, 29 Jun 2005 13:25:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Message-ID: <20050629112534.GG14589@suse.de>
References: <200506291402.18064.vda@ilport.com.ua> <20050629111537.GF14589@suse.de> <200506291418.43748.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506291418.43748.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29 2005, Denis Vlasenko wrote:
> On Wednesday 29 June 2005 14:15, Jens Axboe wrote:
> > On Wed, Jun 29 2005, Denis Vlasenko wrote:
> > > So why can't we have kmalloc_auto(size) which does GFP_KERNEL alloc
> > > if called from non-atomic context and GFP_ATOMIC one otherwise?
> > 
> > Because it's a lot better in generel if we force people to think about
> > what they are doing wrt memory allocations. You should know if you are
> > able to block or not, a lot of functions exported require you to have
> > this knowledge anyways. Adding these auto-detection type functions
> > encourages bad programming, imho.
> 
> Those 'bad programming' people can simply use GFP_ATOMIC always, no?
> This would be even worse because kmalloc_auto() will sleep
> if it's allowed, but GFP_ATOMIC would not.

Sure, you can't stop people from doing bad programming. But I don't
think we should aid them along the way.

-- 
Jens Axboe

