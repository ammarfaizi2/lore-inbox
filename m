Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756753AbWKVTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbWKVTwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbWKVTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:52:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:5133 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1756753AbWKVTwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:52:10 -0500
Date: Wed, 22 Nov 2006 19:51:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
       Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org
Subject: Re: NTP time sync
Message-ID: <20061122195153.GC22601@flint.arm.linux.org.uk>
Mail-Followup-To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@kernel.crashing.org>,
	Kim Phillips <kim.phillips@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
	kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
	ralf@linux-mips.org
References: <20061122203633.611acaa8@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122203633.611acaa8@inspiron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:36:33PM +0100, Alessandro Zummo wrote:
> 
> 
>  wrto the in-kernel NTP synchronization,
>  as discussed before [1], my opinion
>  is that it should be done in userland.
> 
>  Keeping it in kernel implies subtle code
>  in each of the supported architectures.
> 
>  So, if the arch maintainers agree, 
>  I would suggest to schedule it for removal.
> 
> [1] http://lkml.org/lkml/2006/3/28/358

Fine, provided there's also a shell tool that can enquire whether the
kernel is sync'd or not.  (Currently the 11-minute update does not
occur when the kernel is desynced from a time source - the RTC itself
might be more accurate in this case.)

Throwing hwclock commands into crontab such that they do not take
note of the kernel's sync status is probably a very bad move in that
respect.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
