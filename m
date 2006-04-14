Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWDNOt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWDNOt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWDNOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:49:28 -0400
Received: from mtaout3.012.net.il ([84.95.2.7]:57166 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S964980AbWDNOt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:49:28 -0400
Date: Fri, 14 Apr 2006 17:48:30 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
 V2
In-reply-to: <1144961564.4935.24.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Message-id: <20060414144830.GQ10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060413020559.GC24769@pb15.lixom.net>
 <20060413022809.GD24769@pb15.lixom.net>
 <20060413025233.GE24769@pb15.lixom.net>
 <20060413064027.GH10412@granada.merseine.nu>
 <1144925149.4935.14.camel@localhost.localdomain>
 <20060413160712.GG24769@pb15.lixom.net>
 <20060413173121.GJ10412@granada.merseine.nu>
 <1144961564.4935.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 06:52:44AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-13 at 20:31 +0300, Muli Ben-Yehuda wrote:
> > On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:
> > 
> > > Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> > > OF doesn't give the Airport device a logical name. It's probably easier
> > > to implement than walking PCI, but we'd need to maintain a table. My
> > > vote is for PCI walking, I'll give that a shot over the weekend.
> > 
> > Cool! bonus points if you do it in drivers/pci and we can steal it
> > easily for Calgary on x8-64 :-)
> 
> How so ? Anything remotely related to the iommu is totally different...
> Besides, on x86-64, laptops _are_ more common, and thus the problem of
> cardbus cards is much more significant.

What I had in mind is an interface that given a PCI bridge will tell
you what's the most restrictive DMA mask for a device on that bridge,
so that you'll know whether you need to enable the IOMMU for that
bridge. I'll even settle for a function that tells you what's the most
restrictive DMA mask in the system, preiod. There's nothing inherently
arch specific about this.

(and as a side note, the IOMMU we are working on on x86-64 is Calgary,
which is actually roughly the same chipset used in some PPC
machines...)

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

