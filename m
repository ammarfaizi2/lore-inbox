Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVKQPte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVKQPte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVKQPte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:49:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4368 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750982AbVKQPtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:49:33 -0500
Date: Thu, 17 Nov 2005 15:49:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: overlapping resources for platform devices?
Message-ID: <20051117154925.GA26032@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org> <20051116064123.GA31824@kroah.com> <18C975E2-BA90-4595-8C50-63E5CFB9C0A1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18C975E2-BA90-4595-8C50-63E5CFB9C0A1@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:36:38AM -0600, Kumar Gala wrote:
> 
> On Nov 16, 2005, at 12:41 AM, Greg KH wrote:
> 
> >On Tue, Nov 15, 2005 at 05:31:57PM -0600, Kumar Gala wrote:
> >>Guys,
> >>
> >>I was wondering if there was any issue in changing  
> >>platform_device_add to
> >>use insert_resource instead of request_resource.  The reason for this
> >>change is to handle several cases where we have device registers that
> >>overlap that two different drivers are handling.
> >>
> >>The biggest case of this is with ethernet on a number of PowerPC  
> >>based
> >>systems where a subset of the ethernet controllers registers are  
> >>used for
> >>MDIO/PHY bus control.  We currently hack around the limitation by  
> >>having
> >>the MDIO/PHY bus not actually register an memory resource region.
> >>
> >>If the following looks good I'll send a more formal patch.
> >
> >Looks good to me, but Russell knows this code much better than I.
> >
> >thanks,
> >
> >greg k-h
> 
> Russell, any issues?

Haven't managed to look at this yet - busy catching up after illness.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
