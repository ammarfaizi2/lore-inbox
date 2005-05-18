Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVERXvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVERXvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVERXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:51:43 -0400
Received: from colin.muc.de ([193.149.48.1]:46343 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262415AbVERXvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:51:32 -0400
Date: 19 May 2005 01:51:28 +0200
Date: Thu, 19 May 2005 01:51:28 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with 2.6.12 and ioremap/iounmap
Message-ID: <20050518235128.GA45952@muc.de>
References: <20050518224353.GL2596@hygelac> <m1zmusyuyq.fsf@muc.de> <20050518233425.GB8962@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518233425.GB8962@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 06:34:25PM -0500, Terence Ripperda wrote:
> > > perhaps iounmap should be calling ioremap_change_attr rather than
> > 
> > What is ioremap_change_attr? 
> 
> a static function in ioremap.c that is called by __ioremap. it's a
> wrapper function around change_page_attr. I only see it in the x86_64
> architecture, not i386.

Oh yes, indeed. I forgot that I wrote it :) Calling global_flush_tlb
in iounmap is indeed a very good idea.

-Andi
