Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbRL3WQF>; Sun, 30 Dec 2001 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285402AbRL3WPz>; Sun, 30 Dec 2001 17:15:55 -0500
Received: from net015s.hetnet.nl ([194.151.104.155]:18184 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S285096AbRL3WPo>;
	Sun, 30 Dec 2001 17:15:44 -0500
Message-Id: <5.1.0.14.2.20011230223848.00a2d570@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 30 Dec 2001 23:13:14 +0100
To: kuznet@ms2.inr.ac.ru
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200112301924.WAA24526@ms2.inr.ac.ru>
In-Reply-To: <5.1.0.14.2.20011230174733.00a2fc50@pop.hetnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

At 22:24 30-12-01 +0300, kuznet@ms2.inr.ac.ru wrote:
>                skb->data -= dev->hard_header_len;
>                skb->tail -= dev->hard_header_len;
>+               if (len < dev->hard_header_len)
>+                       skb->nh.raw = skb->data;
>        }

I'll try that. I'm currently rebuilding the kernel, APM is working lousy on my Compaq 12LX302 laptop so I'm recompiling without APIC to see if that makes a change. Anyway, that takes a while, I'll report back on this.

>which is sad. Not that it is wrong (it is wrong by design and not repairable
[snip]
>So, leave this as it is and try to switch to packet socket from SOCK_PACKET.

I would be happy to do this if I knew how. I posted the code I use now and I have to say that I'm not familiar with this socket business at all. When I build it I copy-catted it from other programs (mainly net2kiss), did a tidy up on stuff that seemed to be redundant and tried to make is sensible to me.

I also tried to get some information from the Internet about raw access (for the APRS digipeater I need full control over the received and transmitted AX.25 packets) after I got the first buggy message reports from the 2.1.x kernel because I was first convinced I just did something wrong out of ignorance. The only way I found is using SOCK_PACKET. The only deviation with which I was not too happy was having to use protocol family "ETH_P_AX25" instead of "PF_AX25" but with the latter - which seems to be the correct one if I understood all of this correctly - the transmitted data is echoed back to the receive socket which is not desired at all.

But I'm always in for improvements so if there is another way I'll be happy to swap my code for something better. I guess I have to live with SOCK_PACKET for use on older (2.0.36) kernels?

So I require help for this. I guess when a good alternative is known this will also make it to the AX.25 utilities. I've never seen any other way to do it yet, please educate me.

Kind regards,

Henk.

P.S. Maybe the discussion should now be taken of the lists as this is drifting off-topic now, at least for the linux-kernel list which is already loaded enough as it is...

