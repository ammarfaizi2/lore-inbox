Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALNYh>; Fri, 12 Jan 2001 08:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRALNY0>; Fri, 12 Jan 2001 08:24:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129183AbRALNYZ>; Fri, 12 Jan 2001 08:24:25 -0500
Date: Fri, 12 Jan 2001 08:24:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Longair <list-reader@ideaworks3d.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <14942.21680.175176.177588@starfruit.iwks.multi.local>
Message-ID: <Pine.LNX.3.95.1010112082036.8086A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Mark Longair wrote:

> On Thursday 11 January, Richard B. Johnson wrote ("Re: [2.2.18] outgoing connections getting stuck in SYN_SENT"):
> [...]
> > You probably compiled your kernel with "CONFIG_INET_ECN" set.
> > If so, you need to turn it OFF in /proc/sys/net/...something_ecn.
> 
> I don't have an ECN option available in this kernel (2.2.18) - I
> thought it only appeared in 2.3...
> 
> > Many/most/all servers are "not ready for prime time" and will
> > reject packets that have "strange" bits set.
> [...]
> 
> I compiled in the QoS support - could that possibly cause a similar
> effect?  I'm not actually using the QoS tools at the moment, but I
> intend to soon.  I'll post the selected options in my .config if that
> would be helpful.
> 

I guessed wrong. QoS support should not hurt your ability to establish
connections. For kicks, it might be advisable to remove any network
support that you are not using just to see if things improve. It may
be that something is corrupting your packets (before checksumming), so
the intended host rejects them.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
