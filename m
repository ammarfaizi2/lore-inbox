Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUIHMmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUIHMmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUIHMmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:42:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61447 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266250AbUIHMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:41:55 -0400
Date: Wed, 8 Sep 2004 13:41:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908134152.A31413@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040908111751.GA11507@elte.hu> <20040908124002.A30883@infradead.org> <20040908114446.GA14286@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908114446.GA14286@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 01:44:46PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 01:44:46PM +0200, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
> > > version that should be replaced with the proper arch-optimized version
> > > ASAP.
> > 
> > I'd suggest not providing it at all then, because that forces arch
> > maintainers to implement it. 
> 
> while generic it's actually correct for the purpose it's being used for
> right now and all architectures should thus compile & work fine.

Well, if it goes into -mm I'd rather see it not commpile first and let
arch maintainers do proper version instead of forgetting it.  And
unless I misread the code it's only used for SMP && PREEMPT anyway, right?

