Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJ2NKu>; Mon, 29 Oct 2001 08:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJ2NKk>; Mon, 29 Oct 2001 08:10:40 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:23755 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S273881AbRJ2NKa>;
	Mon, 29 Oct 2001 08:10:30 -0500
Message-ID: <3BDD5391.6BF30E81@nokia.com>
Date: Mon, 29 Oct 2001 15:03:13 +0200
From: Manel Guerrero Zapata <manel.guerrero-zapata@nokia.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.0 TCP caches ip route
In-Reply-To: <Pine.LNX.4.33L.0110291047040.2963-100000@imladris.surriel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.4.0 (but I thing that this is probably a 2.4.X problem).
If a execute a telnet command to certain address (like 10.0.0.1).
And the routing table says that packets for 10.0.0.1 should be
routed to the device dummy0,
The telnet keeps trying to connect. (till here everything is cool).
And then I change the routing table so now it should
send those packets to the ppp0 (where 10.0.0.1 is), but the
connexion does not get stablished anyway (till I get timeout).

The problem seems to be that the kernel
caches that the device for the connexion should be dummy0.
If then, I cancel the telnet and start it again
now (of course) it stablishes a telnet conexion though the ppp0.

This problem does not occur if I use ping instead of telnet
(probably because ping uses no socket).

Should not be a mechanism that flushes caches when routing
table changes?

If the cached info is attached to the socket structure
probably this flushing thing is not quite feasible, am I wrong?

I know you usually don't expect the device though your tcp
connection goes to change on the fly, but that actually can
happend, and maybe (IMHO) should be supported.

Maybe I'm missing something. (probably ;) )

Regards,

	Manel Guerrero
