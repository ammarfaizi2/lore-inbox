Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129673AbQKYVgr>; Sat, 25 Nov 2000 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131046AbQKYVgh>; Sat, 25 Nov 2000 16:36:37 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:61189 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S129673AbQKYVg2>; Sat, 25 Nov 2000 16:36:28 -0500
Date: Sat, 25 Nov 2000 22:06:20 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <m17l5rx2af.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.96.1001125215413.2103A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > benn compiled into the kernel, and not as a module) always gave the
> > > errors:
> > > 
> > > eth0: Transmit timed out: status 0050  0090 at 134704418/134704432 
> > > eth0: Trying to restart the transmitter...
> > 
> > Known problem. This one might be fixed in current 2.2.18pre. SOme people
> > see it some dont
> 
> I have another data point on this problem.
> I have seen it most with 2.4.0-test9.  But I'll look at 2.2.18pre.
> I can trigger this bug fairly reliably by warm booting, several times
> in a row.  With my linux warm booting directly into linux code triggers this
> one fairly reliably :)  Also putting another nick in seems to help
> trigger it as well.

Ok. I won't use that card anymore, and wont compile this part of code
neither. But I still doesn't know why does my 2.4.0-test11 crash to black:
no console, not keyboard, no logs, nothing... like a cut on the
electricity. 
Just some mins ago I got another interesting thing: (with the eepro100
driver)
I've been logged in trough ssh. Like 5-10 mins before the crash the packet
loss jumped up to around 30% (the network was ok, the other hosts on the
same network came with 0% loss) Then after a while no answare to the ping,
but my ssh worked still, and even I could log in. So it seems so, that
something in the network driver died, and it didn't answare anymore to the
ICMP requests. 
On the console was nothing again. When the guy pressed the ctrl-alt-del,
the normal reboot message came to the ssh terminals, but nothing happened
on the console, or on the computer (no hard drive activity, no leds on the
keyboard)

For the confusion of the services maybe the libc6 could be blamed. But I
yet doesn't understan why the packet loss rise, and why wasn't the console
working.

And a note for Alan: it isn't so simple to hack the Mylex driver from the
2.2.17 into the 2.2.14... I'm currently trying it...


+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
