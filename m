Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVA1I7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVA1I7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVA1I7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:59:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261215AbVA1I7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:59:11 -0500
Date: Fri, 28 Jan 2005 08:58:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
       alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050128085858.B9486@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
	alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050127163444.1bfb673b.davem@davemloft.net>; from davem@davemloft.net on Thu, Jan 27, 2005 at 04:34:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 04:34:44PM -0800, David S. Miller wrote:
> On Fri, 28 Jan 2005 00:17:01 +0000
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Yes.  Someone suggested this evening that there may have been a recent
> > change to do with some IPv6 refcounting which may have caused this
> > problem.  Is that something you can confirm?
> 
> Yep, it would be this change below.  Try backing it out and see
> if that makes your leak go away.

Thanks.  I'll try it, but:

1. Looking at the date of the change it seems unlikely.  The recent
   death occurred with 2.6.10-rc2, booted on 29th November and dying
   on 19th January, which obviously predates this cset.
2. It'll take a couple of days to confirm the behaviour of the dst cache.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
