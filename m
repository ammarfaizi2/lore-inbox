Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQJ3Qzd>; Mon, 30 Oct 2000 11:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQJ3QzX>; Mon, 30 Oct 2000 11:55:23 -0500
Received: from [62.172.234.2] ([62.172.234.2]:14975 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129103AbQJ3QzR>;
	Mon, 30 Oct 2000 11:55:17 -0500
Date: Mon, 30 Oct 2000 16:54:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: root@chaos.analogic.com, John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <39FDA69C.92B090A6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0010301653280.2617-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > Now, I could set up a linked-list of buffers and use vmalloc()
> > if the buffers were allocated from non-paged RAM. I don't think
> > they are. These buffers must be present during an interrupt.
> 
> Non-paged RAM?  I'm not sure what you mean by that.
> 
> Both kmalloc and vmalloc allocate pages, but neither will allocate pages
> that the system will swap out (page out).  [vk]malloc pages are always
> around during an interrupt.
> 

Jeff, I was going to tell him that but in the previous sentence he was
talking about userspace supplied buffers and those are certainly not
pinned.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
