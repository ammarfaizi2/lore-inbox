Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLYSML>; Mon, 25 Dec 2000 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130250AbQLYSMC>; Mon, 25 Dec 2000 13:12:02 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:16900 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S129906AbQLYSLr>; Mon, 25 Dec 2000 13:11:47 -0500
Date: Mon, 25 Dec 2000 17:40:26 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Manfred <manfred@colorfullife.com>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Netgear FA311
In-Reply-To: <3A477AF3.E76A8083@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0012251730020.804-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2000, Manfred wrote:

> Could you try this setup?
> <<<<<<<<
>  /* Configure the PCI bus bursts and FIFO thresholds. */
>  /* Configure for standard, in-spec Ethernet. */
>  np->tx_config = (1<<28) +       /* Automatic transmit padding */
>              (1<<23) +       /* Excessive collision retry */
>              (6<<20) +     /* Max DMA burst = 128 byte */
>              (8<<8) +        /* fill threshold = 256 byte */
>              8;              /* drain threshold = 256 byte */
>  writel(np->tx_config, ioaddr + TxConfig);
> >>>>>>>>

Hmm, that little change worked a lot better. However thoughput is down to
700kb/s! Transferring files from the other machine to this machine is much
faster - 868kb/s.

In the logs, I only got *one* message from the natsemi driver (and this
happened when sending files from this machine to the other machine. No
problems receiving from the other machine.

Dec 25 17:28:12 tahallah kernel: eth0: Something Wicked happened! 0583.

But I just realised that the other machine I'm using has an 10 megabit
ethernet card (on the hub that one is shown on 10, my machine is shown as
100). I think this explains the throughput problem. When I get another 4
way power socket, I'll put my other machine (which has a 100 megabit card
in it) on the network and see if that makes a difference.

Cheers,
Alex
-- 
Huffapuff!

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
