Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270557AbRHITHF>; Thu, 9 Aug 2001 15:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270560AbRHITGz>; Thu, 9 Aug 2001 15:06:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44807 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270557AbRHITGl>; Thu, 9 Aug 2001 15:06:41 -0400
Subject: Re: struct page to 36 (or 64) bit bus address?
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Thu, 9 Aug 2001 20:09:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010809144000.B1575@sventech.com> from "Johannes Erdfelt" at Aug 09, 2001 02:40:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UvAy-0007qI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a 64 bit PCI card which I'd like to do 64 bit DMA with. I have a
> struct page, but I don't see an easy way of determining what the bus
> address for that page is.
> 
> Is there a way to do it at all?

Yes but its not the right way to do it (bttv does it for example). You want 
to be using the pci or kiovec apis (Documentation/DMA-mapping.txt)

Thats important because it may well be an iommu that handles the mapping to
make the stuff visible - not the cpu
