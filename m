Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUIHNJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUIHNJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUIHNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:06:48 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:63495 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267455AbUIHNB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:01:56 -0400
Date: Wed, 8 Sep 2004 14:01:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908140146.A31601@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908125755.GC3106@holomorphy.com>; from wli@holomorphy.com on Wed, Sep 08, 2004 at 05:57:55AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:57:55AM -0700, William Lee Irwin III wrote:
> * Christoph Hellwig <hch@infradead.org> wrote:
> >> And make hardirq.o dependent on some symbols the architectures set.
> >> Else arches that don't use it carry tons of useless baggage around
> >> (and in fact I'm pretty sure it wouldn't even compie for many)
> 
> On Wed, Sep 08, 2004 at 02:45:47PM +0200, Ingo Molnar wrote:
> > it compiles fine on x86, x64, ppc and ppc64. Why do you think it wont
> > compile on others?
> > wrt. unused generic functions - why dont we drop them link-time?
> 
> It may be time for a __weak define to abbreviate __attribute__((weak));
> we seem to use it in enough places.

Personally I'm extremly unhappy with that week model for things like
this.  There's no reason why architectures could implement irq handling
as inlines.  Or in case of s390 not at all.
