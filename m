Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131602AbQKAVDG>; Wed, 1 Nov 2000 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbQKAVC4>; Wed, 1 Nov 2000 16:02:56 -0500
Received: from animal.cs.chalmers.se ([129.16.225.30]:6896 "EHLO
	animal.cs.chalmers.se") by vger.kernel.org with ESMTP
	id <S131602AbQKAVCp>; Wed, 1 Nov 2000 16:02:45 -0500
Date: Wed, 1 Nov 2000 22:02:38 +0100 (MET)
From: Dennis Bjorklund <dennisb@cs.chalmers.se>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.SOL.4.21.0011012143200.20182-100000@muppet17.cs.chalmers.se>
Message-ID: <Pine.SOL.4.21.0011012200430.20182-100000@muppet17.cs.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Dennis Bjorklund wrote:

> > ioctl(5, SIOCGIFFLAGS, 0xbffff620)      = 0
> > ioctl(5, SIOCSIFFLAGS, 0xbffff620)      = 0
> > 
> > In this case the flags were gotten with SIOCGIFFLAGS, then the
> > exact same stuff was written back with SIOCSIFFLAGS.
> 
> IFF_BROADCAST is bit number 1 (that is 0x2). So in this case it indicates
> that the broadcast bit is not set before and not set after. But why do I
> see BROADCAST listed when i do "ifconfig eth1" then. This bit should be
> set.
> 
> Right now I'm a bit confused. There is something strange going on here
> that I don't understand. 

Forget this comment.

The 0xbffff620 is an adress and nothing else. It should be the same. The
flag is toggled in the struct that the adress points to.

It explains the strace but not why I can't clear the flag..

/Dennis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
