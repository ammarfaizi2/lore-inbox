Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWCBJmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWCBJmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCBJmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:42:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3603 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751193AbWCBJmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:42:00 -0500
Date: Thu, 2 Mar 2006 09:41:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060302094153.GA14017@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk> <44069E3A.4000907@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44069E3A.4000907@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 08:26:50AM +0100, Pierre Ossman wrote:
> Russell King wrote:
> > Okay, I've hit this same problem (but in a slightly different way) with
> > mmci.c.  The way I'm proposing to fix this for mmci is to introduce a
> > new capability which says "clustering is supported by this driver."
> 
> This will decrease performance more than necessary for drivers that can
> do clustering, just not in highmem. So what about another flag that says
> "highmem is supported by this driver"?

I think you're asking Jens that question - I know of no way to tell
the block layer that clustering is fine for normal but not highmem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
