Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbRFGUCd>; Thu, 7 Jun 2001 16:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbRFGUCW>; Thu, 7 Jun 2001 16:02:22 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:30704 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262674AbRFGUCH>;
	Thu, 7 Jun 2001 16:02:07 -0400
Message-ID: <3B1FDD9F.49E55D9B@pcsystems.de>
Date: Thu, 07 Jun 2001 22:01:35 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khalid Aziz <khalid@fc.hp.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FD67D.8DFDAE58@pcsystems.de> <3B1FDB64.1AB850CF@fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz wrote:

> Nico Schottelius wrote:
> >
> > Hi all!
> >
> > The problem is solved, if I disconnect the hp streamer
> > from the bus. I wonder why there is a problem.
> > The aic7880 has two busses:
> >
> > ultra/ ultrawide.
> >
> > The ibm hard disk is connected to the uw port and is terminated.
> > No other uw device is attached.
> >
> > The hp streamer is also lonely on the ultra bus. I have
> > no documentation for that device, so I don't know
> > whether it is terminated nor if it is using parity.
> >
> > Btw, can somebody explain what the parity bit does to me ?
> >
> > Or does anybody have a hp c1536 streamer and can help me ?
>
> Based upon the lspci output you posted earlier, aic7880 has a single
> SCSI bus.

Oh. That could really be a problem.. I though having two different
connectors on the board would make two different buses..
I must have been wrong.

> So you must mean two internal connectors. Both of your devices
> (HD and Tape) do show up on the same bus during scan. Since you have
> connected devices to both connectors on the card, you must terminate
> both devices.

Okay, so far I understood.

> Sounds like you HD might be terminated.

It is.

> You need to terminate tape drive as well.

It seems like it is impossible:

> I do not have a C1536 handy,

the problem is I do have :)

> but if you look at the back of the drive you should see 10 pins aligned
> horizontally.

No. And that's the real problem.
I can see the following:

2 - 1 -0 for the id (every one with two pins), NC (one pin).
Under the device is a small claviar.
I mean a small think, a bank with small switches on it.

reading from left to right:
1 - 2 -3 -  4 -5 -6 -7 -8.
If the switch is up, it is on.

--
| o  |   on
|     |
--

--
|      |   off.
| o  |
--

I hope you understand what I mean to say with thoses ascii figures.

Does anybody know what to do with these
switches ?

Nico

ps: oh, you are from hp, that's the reason why you know so much about this
device ;)


> They should all be labelled on the back panel and most
> likely are (from left to right) - TP, 2, 1, 0, NC. TP is the pair of
> Term Power Enable pins. Place a jumper over the leftmost two pins to
> enable termination on the drive and try again.
>
> --
> Khalid
>
> ====================================================================
> Khalid Aziz                             Linux Development Laboratory
> (970)898-9214                                        Hewlett-Packard
> khalid@fc.hp.com                                    Fort Collins, CO
>
> Disclaimer: I do not speak for HP. These are my personal opinions.

