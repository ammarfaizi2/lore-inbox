Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315912AbSEGRZ1>; Tue, 7 May 2002 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315914AbSEGRZV>; Tue, 7 May 2002 13:25:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315912AbSEGRZT>; Tue, 7 May 2002 13:25:19 -0400
Date: Tue, 7 May 2002 10:24:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: benh@kernel.crashing.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <20020507171946.29430@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.44.0205071021290.2509-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
>
> One interesting thing here would be to have some optional link between
> the bus-oriented device tree and the function-oriented tree (ie. devfs
> or simply /dev).

There isn't any 1:1 thing - the device/bus-oriented one should _not_ show
virtual things like partitions etc that have no relevance for a driver,
while /dev (and thus devfs) obviously think that that is the important
part, much more important than how we actually got to the device.

I think we need to have some way of getting a mapping from /dev ->
devicefs, but I don't think that has to be a filesystem thing (it might
even be as simple as just one ioctl or new system call: 'get the "path" of
this device').

There aren't that many people who actually care, I suspect.

		Linus

