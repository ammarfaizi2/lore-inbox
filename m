Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKCNGJ>; Fri, 3 Nov 2000 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQKCNF7>; Fri, 3 Nov 2000 08:05:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32005 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129026AbQKCNFp>; Fri, 3 Nov 2000 08:05:45 -0500
Date: Fri, 3 Nov 2000 08:05:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul Marquis <pmarquis@iname.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
In-Reply-To: <3A024665.32AFD93@iname.com>
Message-ID: <Pine.LNX.3.95.1001103075952.24503A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, Paul Marquis wrote:

> It shows that even though select() says a file descriptor is not
> writable, a write() can still succeed.  This code is not used anywhere
> in the real world, or at least my real world :-P.  It just demonstrates
> "the bug".
> 

It demonstrates nothing except bad code. Anybody should know that
such a descriptor can become writable at any instant, simply because
the kernel may be finding room for more unread data.

So, the code sees that, at this instant, it's not writable. Then
it writes to it anyway. Sometimes the fd becomes writable between
the time that it was checked, and the time it was written. So
the write succeeded. So what. It shows nothing but bad code. It
demonstrates no bug whatsover.

There may be a bug. However, this code doesn't demonstrate anything
but bad coding practice.

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
