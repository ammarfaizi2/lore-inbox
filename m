Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVCVJwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVCVJwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVCVJwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:52:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1037 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262594AbVCVJwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:52:42 -0500
Date: Tue, 22 Mar 2005 09:52:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] vmalloc: introduce __vmalloc_area() function
Message-ID: <20050322095232.B14577@flint.arm.linux.org.uk>
Mail-Followup-To: Oleg Nesterov <oleg@tv-sign.ru>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>
References: <422B5263.285A7928@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422B5263.285A7928@tv-sign.ru>; from oleg@tv-sign.ru on Sun, Mar 06, 2005 at 09:56:35PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 09:56:35PM +0300, Oleg Nesterov wrote:
> There are 3 copy-and-paste implementations of __vmalloc() in
> arch/{arm,sparc64,x86_64}/kernel/module.c.

There is actually a similar copy in arch/arm/mm/consistent.c, but at the
time I cleaned it up to be something saner.  With some tweaks (such as
adding a struct vm_region_head which contains the spinlock, as well as
the start/end and list) we essentially end up with a generic memory
region allocator suitable for vmalloc, ioremap, module stuff, and so
forth.

If anyone's interested in that, I'll sort out those tweaks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
