Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWFGQ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWFGQ6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWFGQ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:58:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51212 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932337AbWFGQ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:58:45 -0400
Date: Wed, 7 Jun 2006 17:58:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
Message-ID: <20060607165837.GE13165@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44869794.9080906@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 11:08:36AM +0200, Pierre Ossman wrote:
> New information. Version 4.2 of the MMC spec changes the wording to this:
> 
> * WRITE_BL_LEN
> Block length for write operations. See READ_BL_LEN for field coding.
> Note that the support for 512B write access is mandatory for all cards.
> 
> Similar wording for READ_BL_LEN, but that isn't of interest to us.

I wonder if all 2GB cards are >= v4.2 of the spec?  If so, we could
do what would appear correct to both the spec and reality, and select
512 byte blocksizes irrespective if they conform to v4.2 or later.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
