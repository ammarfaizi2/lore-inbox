Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWEOS7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEOS7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEOS7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:59:44 -0400
Received: from amdext3.amd.com ([139.95.251.6]:55525 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932440AbWEOS7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:59:43 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Mon, 15 May 2006 09:35:39 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Michael Buesch" <mb@bu3sch.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Add Geode HW RNG driver
Message-ID: <20060515153539.GB22239@cosmic.amd.com>
References: <200605122246.58961.mb@bu3sch.de>
MIME-Version: 1.0
In-Reply-To: <200605122246.58961.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 15 May 2006 15:28:13.0699 (UTC)
 FILETIME=[2E4BCD30:01C67834]
X-WSS-ID: 6876418420010416105-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/06 22:46 +0200, "Michael Buesch" wrote:
> On Friday 12 May 2006 13:05, you wrote:
> > mb@bu3sch.de wrote:
> > > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > > Index: hwrng/drivers/char/hw_random/Kconfig
> > > ===================================================================
> > > --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
> > > +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
> > > @@ -35,3 +35,16 @@
> > >  	  module will be called amd-rng.
> > >  
> > >  	  If unsure, say Y.
> > > +
> > > +config HW_RANDOM_GEODE
> > > +	tristate "AMD Geode HW Random Number Generator support"
> > > +	depends on HW_RANDOM && (X86 || IA64) && PCI
> >                                      ^^^^^^^
> > IA64?
> 
> I have no idea. I neither wrote the driver, nor do I have the device.
> So, drop IA64?

Wow - where did that come from?  Yeah, drop it!

> > > +	default y
> > > +	---help---
> > > +	  This driver provides kernel-side support for the Random Number
> > > +	  Generator hardware found on AMD Geode based motherboards.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called geode-rng.
> > 
> > You need to state which members of the Geode family have this hardware.
> >  e.g., Is it only the Geode LX CPUs?
> 
> Well, no idea. It was not stated in the existing old help text either.

Its just the Geode LX - that help text should be more specific in that
regard.

Regards,
Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

