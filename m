Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129536AbQJ3SIo>; Mon, 30 Oct 2000 13:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbQJ3SIe>; Mon, 30 Oct 2000 13:08:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13316 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129440AbQJ3SI1>; Mon, 30 Oct 2000 13:08:27 -0500
Date: Mon, 30 Oct 2000 13:08:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tigran Aivazian <tigran@veritas.com>, John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <39FDAB1E.89BA3CC1@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001030130654.2540D-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Jeff Garzik wrote:

> Tigran Aivazian wrote:
> > 
> > On Mon, 30 Oct 2000, Jeff Garzik wrote:
> > 
> > > "Richard B. Johnson" wrote:
> > > > Now, I could set up a linked-list of buffers and use vmalloc()
> > > > if the buffers were allocated from non-paged RAM. I don't think
> > > > they are. These buffers must be present during an interrupt.
> > >
> > > Non-paged RAM?  I'm not sure what you mean by that.
> > >
> > > Both kmalloc and vmalloc allocate pages, but neither will allocate pages
> > > that the system will swap out (page out).  [vk]malloc pages are always
> > > around during an interrupt.
> 
> > Jeff, I was going to tell him that but in the previous sentence he was
> > talking about userspace supplied buffers and those are certainly not
> > pinned.
> 
> Well the problem sounds really strange then.  Why are kmalloc/vmalloc
> being talked about at all, if we are dealing with userspace-supplied
> buffers?
> 

No, not user-supplied buffers. Just a fixed kernel allocation large
enough to take an entire image which can be up to and including 2
megabytes.



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
