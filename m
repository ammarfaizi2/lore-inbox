Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRKLNYg>; Mon, 12 Nov 2001 08:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKLNY1>; Mon, 12 Nov 2001 08:24:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28034 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S274757AbRKLNYK>; Mon, 12 Nov 2001 08:24:10 -0500
Date: Mon, 12 Nov 2001 08:24:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sureshkumar Kamalanathan <skk@sasken.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how do we block interrupts?
In-Reply-To: <3BEFC649.313D32AF@sasken.com>
Message-ID: <Pine.LNX.3.95.1011112081637.31375A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Sureshkumar Kamalanathan wrote:

> Hi all,
>   I have added a function inside kernel in netif_rx().  I want to block
> all the ethernet interrupts till this function is executed.  
>   How do we block and unblock the interrupts?
>   Thanks in advance,
> 
> Regards,
> Sureshkumar K.


Like line 1002 of ../linux/net/core/dev.c

spin_lock_irqsave(&netdev_fc_lock, flags);
	blocked_code();
spin_unlock_irqrestore(&netdev_fc_lock, flags);



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


