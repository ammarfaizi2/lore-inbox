Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290805AbSAaB1B>; Wed, 30 Jan 2002 20:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAaB0w>; Wed, 30 Jan 2002 20:26:52 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9646 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290796AbSAaBYh>; Wed, 30 Jan 2002 20:24:37 -0500
Date: Thu, 31 Jan 2002 02:24:13 +0100
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix rocket port driver
Message-ID: <20020131022413.A1628@averell>
In-Reply-To: <20020131003130.A1413@averell> <20020130201640.A18730@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130201640.A18730@havoc.gtf.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:16:40AM +0100, Jeff Garzik wrote:
> > @@ -2042,6 +2046,10 @@
> >  			PCI_DEVICE_ID_RP8M, i, &bus, &device_fn)) 
> >  			if(register_PCI(count+boards_found, bus, device_fn))
> >  				count++;
> > +		if(!pcibios_find_device(PCI_VENDOR_ID_RP,
> > +			0x8, i, &bus, &device_fn)) 
> > +			if(register_PCI(count+boards_found, bus, device_fn))
> > +				count++;	
> 
> Would it be possible to beg and plead and convince you to convert this
> driver to the new PCI API?

I can do that, but not tonight. 

Linus, Dave, please does that not let stop you from merging my previous
patch anyways until I get to it..

> 
> It hasn't been touched in ages AFAICS, and both 2.4 as well as 2.5 would
> greatly benefit from such a [tested] change.

Comtrol has a newer "beta" driver on their ftp site, but it only adds support
for some new hardware features, but doesn't change much otherwise. 

-Andi

