Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWIOIHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWIOIHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWIOIHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:07:34 -0400
Received: from mx2.go2.pl ([193.17.41.42]:56010 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751425AbWIOIHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:07:32 -0400
Date: Fri, 15 Sep 2006 10:11:23 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060915081123.GA2572@ff.dom.local>
References: <20060913065010.GA2110@ff.dom.local> <20060914181754.bd963f6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914181754.bd963f6d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 06:17:54PM -0700, Andrew Morton wrote:
> On Wed, 13 Sep 2006 08:50:10 +0200
> Jarek Poplawski <jarkao2@o2.pl> wrote:
> 
> > Hello,
> > 
> > Probably after 2.6.18-rc6-git1 there is this cc warning: 
> > "arch/i386/kernel/mpparse.c:231: warning: comparison is
> > always false due to limited range of data type".
> > Maybe this patch will be helpful.
> > 
> 
> Thanks.   Andi has already queued a similar patch.
> 
> Andi, you might as well scoot that upstream, otherwise we'll get lots of
> emails about it.
...
> > +#if 0xFF >= MAX_MP_BUSSES
> >  	if (m->mpc_busid >= MAX_MP_BUSSES) {

As a matter of fact today I think my patch is wrong.

I don't know how Andi has fixed it, but after rethinking
the question of Dave Jones I see it's fixing the result
instead of the source of a problem (char or not char).

So it's more serious problem just for really serious guys
like you.

Thanks for response,

Jarek P. 
