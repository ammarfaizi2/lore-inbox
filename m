Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270207AbRHMOHa>; Mon, 13 Aug 2001 10:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270211AbRHMOHT>; Mon, 13 Aug 2001 10:07:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270207AbRHMOHI>; Mon, 13 Aug 2001 10:07:08 -0400
Subject: Re: struct page to 36 (or 64) bit bus address?
To: davem@redhat.com (David S. Miller)
Date: Mon, 13 Aug 2001 15:09:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, sandy@storm.ca, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 13, 2001 06:51:04 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WIPL-0007UX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Actually its pretty trivial to resolve that I think. We already follow
>    precisely the right procedure for some other scsi events. So 
>    
>    	scsi_retry_command(SCpnt);
>    
>    would map to setting the error and returning.
> 
> To make sure we're on the same wave length, are you suggesting
> this is the kind of thing we'd call in a callback from the PCI
> DMA support layer?

Well that would be an ugly layer violation, but how about

	scsi_retry_command_waitq(SCpnt, &dma_waitq)

?
