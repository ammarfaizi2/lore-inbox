Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJ2Njw>; Mon, 29 Oct 2001 08:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJ2Njp>; Mon, 29 Oct 2001 08:39:45 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:28547 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S275110AbRJ2Njk>; Mon, 29 Oct 2001 08:39:40 -0500
Message-ID: <002401c1607f$771eb9e0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Manel Guerrero Zapata" <manel.guerrero-zapata@nokia.com>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0110291047040.2963-100000@imladris.surriel.com> <3BDD5391.6BF30E81@nokia.com>
Subject: Re: 2.4.0 TCP caches ip route
Date: Mon, 29 Oct 2001 14:41:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Manel Guerrero Zapata" <manel.guerrero-zapata@nokia.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Monday, October 29, 2001 2:03 PM
Subject: 2.4.0 TCP caches ip route


> Hi,
>
> I'm using 2.4.0 (but I thing that this is probably a 2.4.X problem).
> If a execute a telnet command to certain address (like 10.0.0.1).
> And the routing table says that packets for 10.0.0.1 should be
> routed to the device dummy0,
> The telnet keeps trying to connect. (till here everything is cool).
> And then I change the routing table so now it should
> send those packets to the ppp0 (where 10.0.0.1 is), but the
> connexion does not get stablished anyway (till I get timeout).
>
> The problem seems to be that the kernel
> caches that the device for the connexion should be dummy0.
> If then, I cancel the telnet and start it again
> now (of course) it stablishes a telnet conexion though the ppp0.
>
> This problem does not occur if I use ping instead of telnet
> (probably because ping uses no socket).
>
> Should not be a mechanism that flushes caches when routing
> table changes?
>
> If the cached info is attached to the socket structure
> probably this flushing thing is not quite feasible, am I wrong?
>
> I know you usually don't expect the device though your tcp
> connection goes to change on the fly, but that actually can
> happend, and maybe (IMHO) should be supported.
>
> Maybe I'm missing something. (probably ;) )

This sounds like a minor problem. I do think that if you already have an
established connection it would work just as you want it to do, but as you
describe it you don't have an established TCP connection. What I mean is
that you won't exactly loose your connection if you don't even have one at
the first place!

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


