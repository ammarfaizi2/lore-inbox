Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLNN6K>; Thu, 14 Dec 2000 08:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLNN6A>; Thu, 14 Dec 2000 08:58:00 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:17183 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129325AbQLNN55>; Thu, 14 Dec 2000 08:57:57 -0500
Date: Thu, 14 Dec 2000 15:34:53 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Chad Schwartz <cwslist@main.cornernet.com>
cc: Mark Orr <markorr@intersurf.com>, linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
In-Reply-To: <Pine.LNX.4.30.0012130827380.21891-100000@main.cornernet.com>
Message-ID: <Pine.LNX.4.21.0012141529580.2159-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> there are many situations in which a 16550 is KNOWN to be overrunable, all
> of which can occur in your common PPP connection.
> 
> More importantly - if you have 2 16550's talking together (Which is
> EXACTLY what you have, when you hook it to a modem) there are even MORE
> overrun possibilities. (For instance, when you fill the transmitter up to
> 16 bytes - on a uart, and then the receiving side suddenly drops RTS,
> there is *NO* way for that 16550 to stop its transmitter. Once the bytes
> are in its fifo, it HAS TO SEND THEM.)

Indeed. I saw this behaviour some years ago when I was debugging a
controller that went beserk when been talked to at a 115k2 buad rate. 

My modem isn't on 115k2 now, so I don't see the problem often. I'm gonne
setup a second machine with remote kernel debugging, since I'm sick of
rebooting when I want to scan something.

> This is where a 654 or an 854 (I'm only listing startech design chips.
> there are others that would do the job.)  come in handy. They can pause
> their transmitter WITH bytes in their fifo. (Automated hardware/software
> flow control.)

Indeed. Most chips I've seen are 1 16550, or pretend to be. Probably an
issue of cost (At least, I think :))

> I have no idea why the 16550 caught on as the "De facto standard" like it
> did. there are UARTS out there that are more efficient, yet cost only a
> few dollars more to manufacture.

Well.. Why is the i386 the defacto standard ? There architectures that are
a lot better. Reason it is that the some big company used it, and it got
populair.

> (Your common QUAD 16654 chip costs $20 to an end user, nowadays. Your
> common QUAD 16554 costs about $15.)
> 
> Imagine what the 2-UART chips would cost. (or, mass-produced all-in-1
> sets even.)
> 
> Really makes you think.

Indeed.. Why do they save $15 bucks on a modem chipset, and replace it
with a buggy software driven solution... Making things as cheap as
possible, to make sure the're chaper then their compatitor.
 
> Chad



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
