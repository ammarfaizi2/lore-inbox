Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423429AbWBBJ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423429AbWBBJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423435AbWBBJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:59:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18956 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423429AbWBBJ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:59:15 -0500
Date: Thu, 2 Feb 2006 09:59:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of MMC_DATA_MULTI?
Message-ID: <20060202095910.GB5034@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43E057DA.7000909@drzeus.cx> <20060201092934.GB27735@flint.arm.linux.org.uk> <43E08148.3060003@drzeus.cx> <20060202093656.GA5034@flint.arm.linux.org.uk> <43E1D5BF.5000807@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D5BF.5000807@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 10:49:51AM +0100, Pierre Ossman wrote:
> Russell King wrote:
> >In short, it's defined to be whatever AT91_MCI_TRTYP_MULTIPLE means in
> >the AT91RM9200 MMC host driver, which appears to be set for any of the
> >multiple block commands.  They currently are doing:
> 
> That's a bit fuzzy and bound to give problems. Why not settle for the 
> first case and change their code to check the block count in the 
> request?

Mainly because I don't know if that's sufficient, and until I get around
to finding and reading the AT91RM9200 data sheet, I won't know if it is.
What I do know is that the addition of that flag provides the exact
information which the driver wants.

> >and using that as a lookup table by command for the value to put into
> >the command register.  I want to eliminate that, and not passing the
> >MULTI flag prevents elimination of this table.
> 
> Seems to be a common theme in the more recent drivers. Don't they teach 
> people proper layering in the schools anymore? :)

>From the evidence to date, it would appear not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
