Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293396AbSCEPuK>; Tue, 5 Mar 2002 10:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293402AbSCEPuB>; Tue, 5 Mar 2002 10:50:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293396AbSCEPts>;
	Tue, 5 Mar 2002 10:49:48 -0500
Date: Tue, 05 Mar 2002 07:47:22 -0800 (PST)
Message-Id: <20020305.074722.25911127.davem@redhat.com>
To: sp@scali.com
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C84E785.1D102FF9@scali.com>
In-Reply-To: <200203051112.DAA03159@adam.yggdrasil.com>
	<20020305.031636.63129004.davem@redhat.com>
	<3C84E785.1D102FF9@scali.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steffen Persvold <sp@scali.com>
   Date: Tue, 05 Mar 2002 16:43:01 +0100

   "David S. Miller" wrote:
   > Just use pci_alloc_consistent, it never gives you
   > anything larger than 32-bit addresses, please read the
   > documentation :-)
   
   What about memory for streaming mappings

That's a different story.

   I know pci_map_single (and _sg) will
   use bounce buffers on platforms without an IOMMU,

64-bit platforms without IOMMU use HIGHMEM.

   It could for example be solved with a GFP_32BIT flag or something (on IA64 I
   know GFP_DMA is used in pci_alloc_consistent() to get memory below 4GB but that
   can't be used on all platforms).
   
IA64 was broken, it now uses HIGHMEM.
   
Franks a lot,
David S. Miller
davem@redhat.com
