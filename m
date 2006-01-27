Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWA0UQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWA0UQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWA0UQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:16:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58128 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161002AbWA0UQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:16:08 -0500
Date: Fri, 27 Jan 2006 20:16:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127201602.GB2767@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7EA0.7000504@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA7EA0.7000504@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:12:16PM +0100, Pierre Ossman wrote:
> Russell King wrote:
> > > I don't see what the problem is.  A sg entry is a list of struct page
> > > pointers, an offset, and a size.  As such, it can't describe a transfer
> > > which crosses a page because such a structure does not imply that one
> > > struct page follows another struct page.
> 
> If the pages do not strictly follow each other then there is a lot of
> broken code in the kernel. drivers/mmc/mmci.c and drivers/block/ub.c
> being two occurences since both assume they can access the entire entry
> through a single mapping.

Why am I getting duplicates of this message?  Please don't forcefully
send me duplicates - it's a waste of my bandwidth.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
