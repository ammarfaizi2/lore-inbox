Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267994AbRG2Nw2>; Sun, 29 Jul 2001 09:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267998AbRG2NwU>; Sun, 29 Jul 2001 09:52:20 -0400
Received: from mercury.mv.net ([199.125.85.40]:16392 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S267994AbRG2NwH>;
	Sun, 29 Jul 2001 09:52:07 -0400
Message-ID: <000901c11835$809d2480$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: "Riley Williams" <rhw@MemAlpha.CX>, "Steve Snyder" <swsnyder@home.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107290631310.27188-100000@infradead.org>
Subject: Re: What does "Neighbour table overflow" message indicate?
Date: Sun, 29 Jul 2001 09:50:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

We used to get this from an embedded PowerPC processor under 2.2.x when the
hardware to device driver interface got screwed up.

jeff

----- Original Message -----
From: "Riley Williams" <rhw@MemAlpha.CX>
To: "Steve Snyder" <swsnyder@home.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Sent: Sunday, July 29, 2001 1:41 AM
Subject: Re: What does "Neighbour table overflow" message indicate?


> Hi Steve.
>
>  > I just got this sequence of messages in my system log:
>  >
>  > Jul 28 19:47:44 sunburn kernel: Neighbour table overflow.
>  > Jul 28 19:47:44 sunburn last message repeated 9 times
>  > Jul 28 19:47:49 sunburn kernel: NET: 53 messages suppressed.
>  > Jul 28 19:47:49 sunburn kernel: Neighbour table overflow.
>  > Jul 28 19:48:07 sunburn kernel: NET: 21 messages suppressed.
>  > Jul 28 19:48:07 sunburn kernel: Neighbour table overflow.
>  > Jul 28 19:48:09 sunburn last message repeated 3 times
>  > Jul 28 19:48:14 sunburn kernel: NET: 4 messages suppressed.
>  > Jul 28 19:48:14 sunburn kernel: Neighbour table overflow.
>  >
>  > This is on a RedHat v7.1 + SMP kernel v2.4.7 system.  What is
>  > the kernel trying to tell me here?
>  >
>  > Please cc me as I am not a subscriber to this list.
>
> This could be on completely the wrong track, but here's one of the
> entries from the 2.4.5 kernel's Configure.help file (I don't yet have
> 2.4.7 on my system):
>
>  Q> ARP daemon support (EXPERIMENTAL)
>  Q> CONFIG_ARPD
>  Q>   Normally, the kernel maintains an internal cache which maps IP
>  Q>   addresses to hardware addresses on the local network, so that
>  Q>   Ethernet/Token Ring/ etc. frames are sent to the proper address
>  Q>   on the physical networking layer. For small networks having a
>  Q>   few hundred directly connected hosts or less, keeping this
>  Q>   address resolution (ARP) cache inside the kernel works well.
>  Q>
>  Q>   However, maintaining an internal ARP cache does not work well
>  Q>   for very large switched networks, and will use a lot of kernel
>  Q>   memory if TCP/IP connections are made to many machines on the
>  Q>   network.
>  Q>
>  Q>   If you say Y here, the kernel's internal ARP cache will never
>  Q>   grow to more than 256 entries (the oldest entries are expired
>  Q>   in a LIFO manner) and communication will be attempted with the
>  Q>   user space ARP daemon arpd. Arpd then answers the address
>  Q>   resolution request either from its own cache or by asking the
>  Q>   net.
>  Q>
>  Q>   This code is experimental and also obsolete. If you want to
>  Q>   use it, you need to find a version of the daemon arpd on the
>  Q>   net somewhere, and you should also say Y to "Kernel/User
>  Q>   network link driver", below. If unsure, say N.
>
> The text in there looks suspiciously related to your problem to me.
>
> Best wishes from Riley.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

