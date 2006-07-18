Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWGRT3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGRT3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWGRT3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:29:34 -0400
Received: from betty.vergenet.net ([64.85.198.114]:48768 "EHLO
	betty.vergenet.net") by vger.kernel.org with ESMTP id S932367AbWGRT3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:29:32 -0400
Date: Tue, 18 Jul 2006 15:15:00 -0400
From: Horms <horms@verge.net.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Chris Zankel <chris@zankel.net>,
       Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>, discuss@x86-64.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-ID: <20060718191456.GF20141@verge.net.au>
References: <200607172126_MC3-1-C544-E35A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607172126_MC3-1-C544-E35A@compuserve.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:22:17PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <31687.FP.7244@verge.net.au>
> 
> On Mon, 17 Jul 2006 12:17:20 -0400, Horms wrote:
> 
> > This patch is part of an effort to unify the panic_on_oops behaviour
> > across all architectures that implement it.
> > 
> > It was pointed out to me by Andi Kleen that if an oops has occured
> > in interrupt context, then calling sleep() in the oops path will only cause
> > a panic, and that it would be really better for it not to be in the path at
> > all. 
> 
> i386 already checks in_interrupt() and panics immediately:

Very good point. I guess that needs to be moved to after
panic_on_oops() if the change that Andi suggests works out.

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

