Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270203AbRHMNvj>; Mon, 13 Aug 2001 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270204AbRHMNv3>; Mon, 13 Aug 2001 09:51:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25993 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270203AbRHMNvP>;
	Mon, 13 Aug 2001 09:51:15 -0400
Date: Mon, 13 Aug 2001 06:51:04 -0700 (PDT)
Message-Id: <20010813.065104.70223517.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: sandy@storm.ca, linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15Vtjo-0005ay-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15Vtjo-0005ay-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Sun, 12 Aug 2001 12:49:00 +0100 (BST)

   Actually its pretty trivial to resolve that I think. We already follow
   precisely the right procedure for some other scsi events. So 
   
   	scsi_retry_command(SCpnt);
   
   would map to setting the error and returning.

To make sure we're on the same wave length, are you suggesting
this is the kind of thing we'd call in a callback from the PCI
DMA support layer?

That's the core bit, some callback mechanism.  You need this to let
the drivers get "jump started" when IOMMU mappings become available
once more.

Later,
David S. Miller
davem@redhat.com
