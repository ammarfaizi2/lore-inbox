Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSGSP34>; Fri, 19 Jul 2002 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSGSP34>; Fri, 19 Jul 2002 11:29:56 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:18163 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316797AbSGSP3z>; Fri, 19 Jul 2002 11:29:55 -0400
Date: Fri, 19 Jul 2002 11:32:58 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: William D Waddington <csbwaddington@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [never mind] kiobufs and highmem
Message-ID: <20020719113258.B12183@redhat.com>
References: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com>; from csbwaddington@att.net on Fri, Jul 19, 2002 at 08:00:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 08:00:00AM -0700, William D Waddington wrote:
> Looks like three (?) options: go back to copying to a kernel DMA
> buffer for all cases (swell for performance), split the code path into
> map_user and copy_user branches (not that fond of spaghetti),
> or - in the highmem case - copy to a local buffer and populate the
> kiobuf with those pages and feed that to pci_map_sg().

Or use the PCI-DMA API function pci_map_single() that's documented in 
Documentation/DMA-mapping.txt to get a 64 bit pointer?  Don't forget to 
do a pci_set_dma_mask too, but that's mentioned in DMA-mapping.txt.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
