Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUFRVoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUFRVoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUFRVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:37:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52741 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263020AbUFRVU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:20:27 -0400
Date: Fri, 18 Jun 2004 22:20:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, tony@atomide.com,
       David Brownell <david-b@pacbell.net>, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040618222014.D17516@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, tony@atomide.com,
	David Brownell <david-b@pacbell.net>, joshua@joshuawise.com
References: <1087582845.1752.107.camel@mulgrave> <20040618193544.48b88771.spyro@f2s.com> <1087584769.2134.119.camel@mulgrave> <40D340FB.3080309@hp.com> <1087589651.8210.288.camel@gaston> <1087590286.2135.161.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1087590286.2135.161.camel@mulgrave>; from James.Bottomley@steeleye.com on Fri, Jun 18, 2004 at 03:24:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 03:24:45PM -0500, James Bottomley wrote:
> On Fri, 2004-06-18 at 15:14, Benjamin Herrenschmidt wrote:
> > I wanted to do just that a while ago, and ended up doing things a bit
> > differently, but still, I agree that would help. The thing is, you
> > can do that in your platform code. just use the platform data pointer
> > in struct device to stuff a ptr to the structure with your "ops"
> 
> Yes, we do this on parisc too.  We actually have a hidden method pointer
> (per platform) and cache the iommu (we have more than one) accessors in
> platform_data.

Except that platform_data already has multiple other uses, especially for
platform devices.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
