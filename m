Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSLFSdU>; Fri, 6 Dec 2002 13:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSLFSdU>; Fri, 6 Dec 2002 13:33:20 -0500
Received: from host194.steeleye.com ([66.206.164.34]:17165 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265154AbSLFSdT>; Fri, 6 Dec 2002 13:33:19 -0500
Message-Id: <200212061840.gB6Ieo803212@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@SteelEye.com, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Fri, 06 Dec 2002 10:31:13 PST." <20021206.103113.98609883.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 12:40:49 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> I have only one request, in terms of naming.  What we're really doing
> is adding a third class of memory, it really isn't consistent and it
> really isn't streaming.  It's inconsistent memory meant to be used for
> "consistent memory things". 

Yes, we've discussed that too...but not come to a conclusion.  The problem is 
really that if you call dma_alloc and pass in the DMA_CONFORMANCE_NON_CONSISTEN
T flag, what you're saying is "This driver implements all the correct cache 
flushes and can cope with inconsistent memory.  Please give me the type of 
memory that's most efficient for the platform I'm running on.".  The driver 
isn't asking give me a specific type of memory, it's telling the platform what 
it's capabilities are.

Any thoughts on naming would be most welcome.

James


