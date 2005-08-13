Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVHMTPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVHMTPR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVHMTPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 15:15:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43538 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932258AbVHMTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 15:15:15 -0400
Date: Sat, 13 Aug 2005 20:15:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuppc-embedded@freescale.com,
       vbordug@ru.mvista.com
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
Message-ID: <20050813201507.A27898@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@freescale.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuppc-embedded@freescale.com, vbordug@ru.mvista.com
References: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net> <20050812204617.C21152@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812204617.C21152@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Aug 12, 2005 at 08:46:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:46:17PM +0100, Russell King wrote:
> On Fri, Aug 12, 2005 at 11:32:57AM -0500, Kumar Gala wrote:
> > The lack of spin_lock_init causes badness in the preempt configuration.
> 
> Please don't - I have a patch in the wings which fixes this properly.
> Unfortunately, its behind a ton of other patches, and I don't want
> to try to find all these fixes in each driver.

Actually, sorry, it's already merged -

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=976ecd12b8144d066a23fe97c6fbfc1ac8470af7

I don't personally run preempt so I don't know what badness you're
seeing.  Can you check whether your kernel has this patch applied,
and if so provide a bug report so the problem can be analysed please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
