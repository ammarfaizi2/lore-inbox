Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbTIRQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTIRQuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:50:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:2503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261803AbTIRQuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:50:21 -0400
Date: Thu, 18 Sep 2003 09:48:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: netpoll/netconsole minor tweaks
Message-ID: <20030918094832.A16499@osdlab.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net> <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 18, 2003 at 01:30:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Mer, 2003-09-17 at 19:24, Chris Wright wrote: 
> >  		/* Give driver a chance to settle */
> > -		jiff = jiffies + 2*HZ;
> > +		jiff = jiffies + 4*HZ;
> >  		while (time_before(jiffies, jiff))
> <pedant>
> should be cpu_relax();
> </pedant>

Hrm, there's many spots that aren't using it.  What's the benefit, less
power consumption?  Is it worth a patch to convert other things over?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
