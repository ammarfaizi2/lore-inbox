Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHLDek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHLDek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 23:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWHLDek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 23:34:40 -0400
Received: from ozlabs.org ([203.10.76.45]:12986 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751133AbWHLDej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 23:34:39 -0400
Subject: Re: [PATCH] make all archs use early_param
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
In-Reply-To: <20060811075416.GA12513@flint.arm.linux.org.uk>
References: <1155280728.27719.34.camel@localhost.localdomain>
	 <20060811075416.GA12513@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 13:34:14 +1000
Message-Id: <1155353655.15839.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 08:54 +0100, Russell King wrote:
> On Fri, Aug 11, 2006 at 05:18:47PM +1000, Rusty Russell wrote:
> > To celebrate the 2-year anniversary of the creation of the arch-indep
> > early_param() macros and the generic parse_early_param(), this patch
> > stops calling it for archs which didn't inserts explicit calls,
> > polite FIXMEs and a BUG_ON().
> 
> Is there any reason why we can't put the early params in a section
> discarded after init time (like ARM does with its early param parsing) ?

Good point.  

> early params are using obs_kernel_param - is this no longer obsolete ?

Yes... it was originally for __setup, which was supposed to be replaced
by module_param() everywhere.  It turned out that we never did that
(noone really wants a namespace for core parameters), then also
overloaded that struct to do early_param()...

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

