Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131598AbQKAUzE>; Wed, 1 Nov 2000 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131602AbQKAUyy>; Wed, 1 Nov 2000 15:54:54 -0500
Received: from animal.cs.chalmers.se ([129.16.225.30]:26602 "EHLO
	animal.cs.chalmers.se") by vger.kernel.org with ESMTP
	id <S131599AbQKAUym>; Wed, 1 Nov 2000 15:54:42 -0500
Date: Wed, 1 Nov 2000 21:54:30 +0100 (MET)
From: Dennis Bjorklund <dennisb@cs.chalmers.se>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.LNX.3.95.1001101150538.4511A-100000@chaos.analogic.com>
Message-ID: <Pine.SOL.4.21.0011012143200.20182-100000@muppet17.cs.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Richard B. Johnson wrote:

> > I'm trying to turn of the broadcast flag for a network card. But I
> > can't, why??
> 
> Your version of `ifconfig` is probably broken (just like mine).
> `strace` it and see:
> ioctl(5, SIOCGIFFLAGS, 0xbffff620)      = 0
> ioctl(5, SIOCSIFFLAGS, 0xbffff620)      = 0
> 
> In this case the flags were gotten with SIOCGIFFLAGS, then the
> exact same stuff was written back with SIOCSIFFLAGS.

IFF_BROADCAST is bit number 1 (that is 0x2). So in this case it indicates
that the broadcast bit is not set before and not set after. But why do I
see BROADCAST listed when i do "ifconfig eth1" then. This bit should be
set.

Right now I'm a bit confused. There is something strange going on here
that I don't understand. 

/Dennis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
