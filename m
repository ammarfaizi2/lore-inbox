Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVANDug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVANDug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVANDu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:50:28 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:46461 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261883AbVANDtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:49:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EK8Tfwd8BD0QcCcKGEIzHA+S5K2X9C4cJWXioeVgmoYbACDCMZ7Jks0EuWPyv2kznYm8M973u3VmWhwLl1eNngcSu6wIu9NpfeWM69FTQkTlQGEs+ic01+WXb+lsDgEqfV18CHjUPiaI/JEumN2zT3rW+fDRnyTNF2iNq1R7QIY=
Message-ID: <8746466a0501131949cb1731f@mail.gmail.com>
Date: Thu, 13 Jan 2005 20:49:48 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
In-Reply-To: <200501131735.04592.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8746466a050113152636f49d18@mail.gmail.com>
	 <20050113162309.2a125eb1.akpm@osdl.org>
	 <200501131735.04592.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 17:35:04 -0800, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> On Thursday, January 13, 2005 4:23 pm, Andrew Morton wrote:
> > +#if BITS_PER_LONG == 64
> >  return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> > +#else
> > + return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> > +#endif
> 
> I just noticed that the PCI rom code also appears to be mixing other types,
> e.g. it delcares start as loff_t and stuffs a pci_resource_start into it,
> then uses it as the first argument to ioremap.
> 
> Jesse
> 

Looks like the PCI rom code is in a "weird" state and I will just
leave it alone until it is done the "right" way (unless it's not
compiling). I don't believe I'll have to touch the code if it is
corrected....

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
