Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131395AbRAaQNM>; Wed, 31 Jan 2001 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbRAaQND>; Wed, 31 Jan 2001 11:13:03 -0500
Received: from ns.sysgo.de ([213.68.67.98]:17139 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129805AbRAaQMv>;
	Wed, 31 Jan 2001 11:12:51 -0500
Date: Wed, 31 Jan 2001 17:12:47 +0100
Message-Id: <200101311612.RAA02360@rob.devdep.sysgo.de>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.0
In-Reply-To: <01013114393200.01502@rob>
    <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it>
In-Reply-To: <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it>
From: rob@sysgo.de (Robert Kaiser)
Subject: Re: Disk is cheap?
X-Original-Newsgroups: linux.kernel
To: patrizio@dada.it (Patrizio Bruno), linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it>,
	patrizio@dada.it (Patrizio Bruno) writes:
> I built a embedded dvd/cdda/mp3 player based on linux, using a p200mmx
> with 24mb with a bus of 75mhx, but it still takes about 20 seconds to boot,
> I think that an embedded device (for home use) should boot in less than
> 5 seconds, how could be possible with a slow p133? (I've also tried a p133
> on 66mhz of bus and it takes almost 35 seconds to boot)

Usually most of the startup time is spent by the BIOS doing
extensive self-test stuff and for firing up services (http,
inetd, sendmail, ...) that many embedded systems have little use for.

I have a 25MHz 386EX (~2.2 Bogomips) here that boots Linux out of ROM
in roughly 30 seconds. Most of _that_ time however is spent decompressing
the kernel.

> However, first or last old hardware will finish, and who wants to build
> an embedded device should use high cost embedded hardware (high cost for me).

Hmm, since embedded devices are usually built in large scale series,
cost is quite an important factor. Neverthless, even if you leave that
aside, there is the even more important question of size, power consumption
and heat dissipation: Any processor that requires a fan is simply
unacceptable in most embedded designs. (Plus, you don't need
the speed of an 1GHz Athlon to control a washing machine...)
That is the reason why relatively low-performing chips such as
i386EX, AMD Elan SC[45][012]0  are very popular in embedded
devices. These chips are by no means "old hardware" !
Did you know that about 95% of the worldwide microprocessor
production end up in some sort of appliance/embedded system ?

I'm pretty sure these "low-end" processors will not go away as
quickly as you might think. Whether they will be running Linux
in the future will depend on Linux's resource requirements.

Cheers

Rob

----------------------------------------------------------------
Robert Kaiser                     email: rkaiser AT sysgo DOT de
SYSGO RTS GmbH                    http://www.elinos.com
Klein-Winternheim / Germany       http://www.sysgo.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
