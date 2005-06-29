Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVF2LOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVF2LOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVF2LOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:14:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27871 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262544AbVF2LOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:14:31 -0400
Date: Wed, 29 Jun 2005 13:15:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Message-ID: <20050629111537.GF14589@suse.de>
References: <200506291402.18064.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506291402.18064.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29 2005, Denis Vlasenko wrote:
> So why can't we have kmalloc_auto(size) which does GFP_KERNEL alloc
> if called from non-atomic context and GFP_ATOMIC one otherwise?

Because it's a lot better in generel if we force people to think about
what they are doing wrt memory allocations. You should know if you are
able to block or not, a lot of functions exported require you to have
this knowledge anyways. Adding these auto-detection type functions
encourages bad programming, imho.

-- 
Jens Axboe

