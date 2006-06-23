Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752004AbWFWTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbWFWTzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbWFWTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:55:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17166 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752004AbWFWTzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:55:46 -0400
Date: Fri, 23 Jun 2006 20:55:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Franck <vagabon.xyz@gmail.com>
Cc: franck.bui-huu@innova-card.com, Mel Gorman <mel@skynet.ie>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-ID: <20060623195531.GB3812@flint.arm.linux.org.uk>
Mail-Followup-To: Franck <vagabon.xyz@gmail.com>,
	franck.bui-huu@innova-card.com, Mel Gorman <mel@skynet.ie>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com> <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie> <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com> <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com> <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com> <449C054F.7010109@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C054F.7010109@innova-card.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 05:14:23PM +0200, Franck Bui-Huu wrote:
> Franck Bui-Huu wrote:
> > -	free_area_init_node(0, NODE_DATA(0), zones_size,
> > -			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> 
> I'm wondering why using "__pa(PAGE_OFFSET) >> PAGE_SHIFT" to compute the start
> of memory. That should always result in 0, shouldn't it ?

No.  There are platforms where memory starts at about 3GB physical,
so __pa(PAGE_OFFSET) = 0xc0000000, which most definitely isn't zero
when shifted right by PAGE_SHIFT.

The world is not a PC.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
