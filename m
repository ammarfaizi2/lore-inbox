Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSLFShs>; Fri, 6 Dec 2002 13:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLFShr>; Fri, 6 Dec 2002 13:37:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265543AbSLFShr>;
	Fri, 6 Dec 2002 13:37:47 -0500
Date: Fri, 06 Dec 2002 10:42:21 -0800 (PST)
Message-Id: <20021206.104221.103230489.davem@redhat.com>
To: James.Bottomley@steeleye.com
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212061840.gB6Ieo803212@localhost.localdomain>
References: <davem@redhat.com>
	<200212061840.gB6Ieo803212@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@steeleye.com>
   Date: Fri, 06 Dec 2002 12:40:49 -0600

   Yes, we've discussed that too...but not come to a conclusion.  The problem is 
   really that if you call dma_alloc and pass in the DMA_CONFORMANCE_NON_CONSISTEN
   T flag, what you're saying is "This driver implements all the correct cache 
   flushes and can cope with inconsistent memory.  Please give me the type of 
   memory that's most efficient for the platform I'm running on.".  The driver 
   isn't asking give me a specific type of memory, it's telling the platform what 
   it's capabilities are.
   
   Any thoughts on naming would be most welcome.

How about just making a dma_alloc_$(NEWNAME)(), and consistent ports
can just alias that to dma_alloc_consistent()?

The only question is $(NEWNAME).  "inconsistent" might be ok, but it's
maybe too similar to "consistent" for my taste.

How about dma_alloc_noncoherent().  I like this one, comments?
