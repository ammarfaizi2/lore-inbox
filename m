Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271392AbUJVPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271392AbUJVPyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbUJVPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:54:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:23532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271392AbUJVPyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:54:17 -0400
Date: Fri, 22 Oct 2004 08:54:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041022085416.P2441@build.pdx.osdl.net>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022103910.GB17526@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041022103910.GB17526@infradead.org>; from hch@infradead.org on Fri, Oct 22, 2004 at 11:39:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> > +make-__sigqueue_alloc-a-general-helper.patch
> > 
> >  posix timer code tweaks
> 
> Any reason it's marked inline now?

First patch was not inline.  Without inline it shaved a few bytes off
of text, but grew data.  Inlined it only shaved bytes from text.

   text    data     bss     dec     hex filename
5083357  947652  648448 6679457  65eba1 vmlinux
5083309  949420  648448 6681177  65f259 vmlinux.__sigqueue
5083341  947652  648448 6679441  65eb91 vmlinux.__sigqueue_inline

thanks,
-chris
