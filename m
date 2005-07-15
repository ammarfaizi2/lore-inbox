Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVGOJDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVGOJDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVGOJDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:03:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263253AbVGOJDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:03:33 -0400
Date: Fri, 15 Jul 2005 10:03:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050715100327.G25428@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org> <20050715094947.E25428@flint.arm.linux.org.uk> <20050715015629.7b0fb13a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050715015629.7b0fb13a.akpm@osdl.org>; from akpm@osdl.org on Fri, Jul 15, 2005 at 01:56:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:56:29AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> > > +uart_handle_sysrq_char-warning-fix.patch
> > > 
> > >  Fix a warning
> > 
> > Andrew, this requires a little more fixing than your simple patch.
> > Several drivers omit 'regs' from the receive handler when sysrq is
> > not enabled.  Hence, this simple fix on its own will cause compile
> > failures.
> 
> Me no understand.  It replaces a three-arg macro with a three-arg static
> inline?

Some serial drivers drop 'regs' from the parent function when sysrq is
disabled.  'regs' is only passed for sysrq support.

(Yes, it's disgusting, but I thought at the time I had the choice of
being lynched by the "as efficient as possible" mob, or...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
