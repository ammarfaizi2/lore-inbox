Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQKHTav>; Wed, 8 Nov 2000 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbQKHTac>; Wed, 8 Nov 2000 14:30:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21376 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129220AbQKHTaY>; Wed, 8 Nov 2000 14:30:24 -0500
Date: Wed, 8 Nov 2000 14:29:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marcus Meissner <Marcus.Meissner@caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: tcp/ip connections and downed/removed netdevs
In-Reply-To: <20001108201840.A23731@ns.caldera.de>
Message-ID: <Pine.LNX.3.95.1001108142702.9671A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Marcus Meissner wrote:

> Hi,
> 
> I have a rather strange problem in regard to routing and tcp/ip connections.
> 
> My setup:
> 	- default route to eth0, metric 2
> 	- ppp dialin to static ip (ppp0), is another default route, metric 0
> 
> I open a telnet connection over the ppp0 interface.
> 
> I then down and remove the ppp0 interface (ifconfig -a ppp0 shows 'no such
> device'), the default route over ppp0 is gone.

No. Look in /etc/ppp/ip_up /etc/ppp/ip_down. Read the docs. These control
what gets set/reset when the ppp connection is set up or torn down.

You can configure to do anything you want, including completely
reconfiguring your network when a ppp connection is established.

This is not a kernel affair.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
