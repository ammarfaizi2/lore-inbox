Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267631AbSLFU5b>; Fri, 6 Dec 2002 15:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbSLFU5b>; Fri, 6 Dec 2002 15:57:31 -0500
Received: from waste.org ([209.173.204.2]:51870 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267632AbSLFU52>;
	Fri, 6 Dec 2002 15:57:28 -0500
Date: Fri, 6 Dec 2002 15:04:45 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@steeleye.com, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206210445.GD5837@waste.org>
References: <davem@redhat.com> <200212061840.gB6Ieo803212@localhost.localdomain> <20021206.104221.103230489.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206.104221.103230489.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 10:42:21AM -0800, David S. Miller wrote:
>    From: James Bottomley <James.Bottomley@steeleye.com>
>    Date: Fri, 06 Dec 2002 12:40:49 -0600
> 
>    Yes, we've discussed that too...but not come to a conclusion.  The problem is 
>    really that if you call dma_alloc and pass in the DMA_CONFORMANCE_NON_CONSISTEN
>    T flag, what you're saying is "This driver implements all the correct cache 
>    flushes and can cope with inconsistent memory.  Please give me the type of 
>    memory that's most efficient for the platform I'm running on.".  The driver 
>    isn't asking give me a specific type of memory, it's telling the platform what 
>    it's capabilities are.
>    
>    Any thoughts on naming would be most welcome.
> 
> How about just making a dma_alloc_$(NEWNAME)(), and consistent ports
> can just alias that to dma_alloc_consistent()?
> 
> The only question is $(NEWNAME).  "inconsistent" might be ok, but it's
> maybe too similar to "consistent" for my taste.

Can we do pci_alloc_consistent -> dma_alloc? Then regardless of what
you name the other one, the consistent version will obviously be prefered.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
