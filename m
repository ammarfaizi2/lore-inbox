Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKLPvM>; Sun, 12 Nov 2000 10:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129987AbQKLPvD>; Sun, 12 Nov 2000 10:51:03 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:4615 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129234AbQKLPuw>;
	Sun, 12 Nov 2000 10:50:52 -0500
Message-Id: <200011120139.eAC1d2E30929@sleipnir.valparaiso.cl>
To: root@chaos.analogic.com
cc: Andrea Arcangeli <andrea@suse.de>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue] 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Fri, 10 Nov 2000 15:07:46 CDT." <Pine.LNX.3.95.1001110150021.5941A-100000@chaos.analogic.com> 
Date: Sat, 11 Nov 2000 22:39:02 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:
> On Fri, 10 Nov 2000, Andrea Arcangeli wrote:

[...]

> > Ok. So please now show a tcpdump trace during the `sendmail -q` so we
> > can see what's going wrong in the TCP connection to the smtp server:
> >
> > 	tcpdump port smtp

> I tried to send Jeff a 45 Megabyte file. It is still in the queue.

[...]

> It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> sendmail spawns a child to send the file data, it crashes.  That's
> why the file never gets sent!

In my experience, if you try to send large messages over unreliable
networks (we sometimes see 50 or more % losses due to chronical link
overload downstream) the connection breaks up and the messages take a long
time to get out of the door. No, not just Linux; our SunOS/Solaris/Linux
mail servers have all shown the same behaviour. Makes sense: Unless the
message is sent and ACKed, it stays put. SMTP has no "resume message" AFAIK...
This could also be an explanation for this phenomemnon.
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
