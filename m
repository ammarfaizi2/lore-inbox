Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbQJ3SHe>; Mon, 30 Oct 2000 13:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQJ3SHY>; Mon, 30 Oct 2000 13:07:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12548 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129478AbQJ3SHM>; Mon, 30 Oct 2000 13:07:12 -0500
Date: Mon, 30 Oct 2000 13:06:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <39FDA69C.92B090A6@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001030130325.2540C-100000@chaos.analogic.com>
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
> 	Jeff

Hmm, vmalloc() doesn't seem to have the size limitation. Are you sure
that it's present during an interrupt? I can't page-fault during the
interrupt.



Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
