Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKAUKK>; Wed, 1 Nov 2000 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQKAUKB>; Wed, 1 Nov 2000 15:10:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10756 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129026AbQKAUJr>; Wed, 1 Nov 2000 15:09:47 -0500
Date: Wed, 1 Nov 2000 15:09:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis Bjorklund <dennisb@cs.chalmers.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.SOL.4.21.0011012010340.19399-100000@muppet17.cs.chalmers.se>
Message-ID: <Pine.LNX.3.95.1001101150538.4511A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Dennis Bjorklund wrote:

> I'm trying to turn of the broadcast flag for a network card. But I
> can't, why??
> 

Your version of `ifconfig` is probably broken (just like mine).
`strace` it and see:
ioctl(5, SIOCGIFFLAGS, 0xbffff620)      = 0
ioctl(5, SIOCSIFFLAGS, 0xbffff620)      = 0
_exit(0)                                = ?

In this case the flags were gotten with SIOCGIFFLAGS, then the
exact same stuff was written back with SIOCSIFFLAGS.


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
