Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUBMTlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbUBMTlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:41:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267195AbUBMTlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:41:37 -0500
Date: Fri, 13 Feb 2004 19:41:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: ml@basmevissen.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shut up about the damn modules already...
Message-ID: <20040213194131.B8188@flint.arm.linux.org.uk>
Mail-Followup-To: Samium Gromoff <deepfire@sic-elvis.zel.ru>,
	ml@basmevissen.nl, linux-kernel@vger.kernel.org
References: <87lln6op6c.wl@canopus.ns.zel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87lln6op6c.wl@canopus.ns.zel.ru>; from deepfire@sic-elvis.zel.ru on Fri, Feb 13, 2004 at 08:38:19PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 08:38:19PM +0300, Samium Gromoff wrote:
> >  In the meantime, your patch needs to go in though because fixing this in               
> >  userspace is not something that will happen on short term.                             
> Wouldn`t this remove the last reason to fix the broken software?

I don't believe there's any code which needs fixing in userspace.  We just
need modprobe.conf to do the right thing when we convert peoples old
modules.conf files.

The original modprobe defaults to:

alias net-pf-10 off

unless net-pf-10 is explicitly aliased to something else (ipv6).  We
therefore just need peoples modprobe.conf files to contain:

install net-pf-10 /bin/true

provided they haven't aliased net-pf-10 to ipv6.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
