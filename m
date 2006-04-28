Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWD1Okd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWD1Okd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWD1Okd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:40:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8381 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965213AbWD1Okc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:40:32 -0400
Date: Fri, 28 Apr 2006 10:40:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-ID: <20060428144021.GA7061@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060427014141.06b88072.akpm@osdl.org> <pan.2006.04.27.15.47.20.688183@free.fr> <20060427180227.GA1404@in.ibm.com> <20060427232444.GA23934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427232444.GA23934@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 04:24:44PM -0700, Greg KH wrote:
> On Thu, Apr 27, 2006 at 02:02:27PM -0400, Vivek Goyal wrote:
> > On Thu, Apr 27, 2006 at 05:47:25PM +0200, Matthieu CASTET wrote:
> > > Hi Andrew,
> > > 
> > > Le Thu, 27 Apr 2006 01:41:41 -0700, Andrew Morton a ?crit?:
> > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> > > > 
> > > 
> > > 64 bit resources core changes in ioport.h break pnp sysfs interface.
> > > 
> > > A patch like this is needed.
> > > 
> > > Matthieu
> > > 
> > > Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> > > 
> > > --- 1/drivers/pnp/interface.c	2006-01-03 04:21:10.000000000 +0100
> > > +++ 2/drivers/pnp/interface.c	2006-04-14 22:54:45.000000000 +0200
> > > @@ -264,7 +264,7 @@
> > >  			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
> > >  				pnp_printf(buffer," disabled\n");
> > >  			else
> > > -				pnp_printf(buffer," 0x%lx-0x%lx\n",
> > > +				pnp_printf(buffer," 0x%llx-0x%llx\n",
> > >  						pnp_port_start(dev, i),
> > >  						pnp_port_end(dev, i));
> > 
> > I think it would break on ppc64 as u64 is unsigned long. It should be
> > explicitly typecasted to unsigned long long. Same is true for all the
> > instances.
> 
> Does ppc64 use the PnP code?
> 

I had assumed it. Just now did a allmodconfig on ppc64 and came to know
there is no such option as CONFIG_PNP. Sorry for the noise.

Thanks
Vivek 
