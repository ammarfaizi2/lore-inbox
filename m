Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWHKHy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWHKHy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWHKHyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:54:25 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:39180 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750754AbWHKHyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:54:25 -0400
Date: Fri, 11 Aug 2006 08:54:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] make all archs use early_param
Message-ID: <20060811075416.GA12513@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@muc.de>
References: <1155280728.27719.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155280728.27719.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 05:18:47PM +1000, Rusty Russell wrote:
> To celebrate the 2-year anniversary of the creation of the arch-indep
> early_param() macros and the generic parse_early_param(), this patch
> stops calling it for archs which didn't inserts explicit calls,
> polite FIXMEs and a BUG_ON().

Is there any reason why we can't put the early params in a section
discarded after init time (like ARM does with its early param parsing) ?

early params are using obs_kernel_param - is this no longer obsolete ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
