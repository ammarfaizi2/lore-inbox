Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJ3UEk>; Mon, 30 Oct 2000 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129086AbQJ3UE3>; Mon, 30 Oct 2000 15:04:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24068 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129054AbQJ3UEU>; Mon, 30 Oct 2000 15:04:20 -0500
Date: Mon, 30 Oct 2000 15:03:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Waugh <twaugh@redhat.com>
cc: rread@datarithm.net, Brett Smith <brett.smith@bktech.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing an ISR from user code
In-Reply-To: <20001030191213.V16849@redhat.com>
Message-ID: <Pine.LNX.3.95.1001030150018.4332B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Tim Waugh wrote:

> On Mon, Oct 30, 2000 at 11:06:59AM -0800, rread@datarithm.net wrote:
> 
> > I'm new at this myself, but how about creating a minor number for each
> > ISR?  When the BH runs, it wakes up the processing waiting on the
> > device for that ISR.
> 
> ... which won't get run until after the interrupt is processed, but
> the interrupt won't get processed until it's run.  Nope.
> 
> Tim.
> */
> 

An interrupt will occur at any time. The user-pages may not be in
memory at that time.

I suggest you do your ISR in the driver (or module) where it really
should be done. The ISR pages are always present.

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
