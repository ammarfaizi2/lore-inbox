Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbREPA5k>; Tue, 15 May 2001 20:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbREPA5b>; Tue, 15 May 2001 20:57:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:40378 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261742AbREPA5Y>; Tue, 15 May 2001 20:57:24 -0400
Mime-Version: 1.0
Message-Id: <p05100330b7277e2beea6@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
Date: Tue, 15 May 2001 17:56:51 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:18 PM -0700 2001-05-15, Linus Torvalds wrote:
>  > 1 (network domain). I have two network interfaces that I connect to
>>  two different network segments, eth0 & eth1;
>
>So?
>
>Informational. You can always ask what "eth0" and "eth1" are.
>
>There's another side to this: repeatability. A setup should be
>_repeatable_.
>
>This is what we have now. Network devices are called "eth0..N", and nobody
>is complaining about the fact that the numbering is basically random. It
>is _repeatable_ as long as you don't change your hardware setup, and the
>numbering has effectively _nothing_ to do with "location".
>
>You don't say "oh, I have my network card in PCI bus #2, slot #3,
>subfunction #1, so I should do 'ifconfig netp2s3f1'". Right?
>
>The location of the device is _meaningless_.

I *like* eth0..n (I'd like net0..n better). And I *can't* ask what 
eth0 and eth1 are, by the way, but I should be able to (Jeff Garzik 
has proposed an extension to ethtool to help out this lack, but it's 
not in Linux today, and needs concrete implementation anyway).

But that's not my point. I'm *not* proposing that we exchange eth0 
for geographic names. I'm suggesting, though, that the location of 
the device is *not* meaningless, because it's the physically-located 
RJ45 socket (or whatever) that I have to connect a particular cable 
to. Sure, no big deal for systems with a single connection, but it 
becomes a real pain when you've got a dozen, which is a reasonable 
number for some network-infrastructure functions (eg firewalls).

When I ifconfig one of a collection of interfaces, I'm very much 
talking about the specific physical interface connected via a 
specific physical cable to a specific physical switch port.

Bob Glamm  is on the right track with

At 5:35 PM -0500 2001-05-15, Bob Glamm wrote:
>   # start up networking
>   for i in eth0 eth1 eth2; do
>       identify device $i
>       get configuration/config procedure for device $i identity
>       configure $i
>   done

...it's just that right now the connection between eth* and its 
physical identity isn't made.
-- 
/Jonathan Lundell.
