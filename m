Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUHJTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUHJTBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267663AbUHJS6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:58:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267678AbUHJSzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:55:14 -0400
Date: Tue, 10 Aug 2004 14:54:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Luesley, William" <william.luesley@amsjv.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Network routing issue
In-Reply-To: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD0@nmex02.nm.dsx.bae.co.uk>
Message-ID: <Pine.LNX.4.53.0408101453250.13579@chaos>
References: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD0@nmex02.nm.dsx.bae.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Luesley, William wrote:

>
> I have two devices setup as follows:
>
>
>           A --------------- B
> 192.168.1.1                 192.168.1.2
>
>
> The machines open a number of TCP and UDP ports with which to communicate.
> In order to help testing, I have been asked to place a third machine between
> these two which will be capable of intercepting and modifying any messages.
> My initial plan was to have a device which could mimic both ends of the
> connection (as I already have code to do this); with each connection being
> on a separate NIC, leading to a setup as shown below:
>
>           A ------------ C  C  ---------- B
> 192.168.1.1    192.168.1.2  192.168.1.1   192.168.1.2
>                     (eth0)  (eth1)
>
> The obvious problem with this is that as C implements both ends of the
> interface, any messages it sends are routed internally, rather than being
> sent to the correct host.
>
> I thought it would be possible to correct this by specifying the host routes
> using the route command, i.e. setting a route to 192.168.1.1 via device eth0
> and to 192.168.1.2 via eth1, therefore stopping the internal routing from
> occurring. Even with these routes setup, the messages are still routed
> internally.
>
>
>
> Can the route somehow be forced?
>
> If not, is there a way to stop the internal routing, preferably without a
> code change to the kernel (if it is a code change - can someone point me
> towards the file)?
>
> Can I use IP Tables, how?
>
> Or, am I on totally the wrong track?
>
>
> Thanks for peoples time spent reading and looking into this.
>
>
>
>
>

`ifconfig lo down` should force your stuff to go through the
ethernet for testing.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


