Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbTCRSSc>; Tue, 18 Mar 2003 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTCRSSc>; Tue, 18 Mar 2003 13:18:32 -0500
Received: from [64.246.18.23] ([64.246.18.23]:36832 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S262517AbTCRSSa>;
	Tue, 18 Mar 2003 13:18:30 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: <root@chaos.analogic.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Tue, 18 Mar 2003 12:34:11 -0600
Message-ID: <001601c2ed7c$f984e900$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.53.0303171924300.24680@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,
	You might give mgetty a try.  I've been doing the same thing as
you with almost every version of Linux 2.4.x and some of 2.2.x.  I don't
know the differences between agetty and mgetty, but I would like mgetty
could handle your needs.

Steve


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Richard B.
Johnson
Sent: Monday, March 17, 2003 6:34 PM
To: Ed Vance
Cc: Linux kernel
Subject: RE: Linux-2.4.20 modem control

On Mon, 17 Mar 2003, Ed Vance wrote:
[SNIPPED...]

> >
> Hi Richard,
>
> What you are doing looks just fine.
>
> As long as HUPCL is set when the close happens, DTR will drop. There
are
> delays that are enforced in both open and close when a second process
is
> blocked opening a closing port. Of course, that would not be your
case,
> because the open does not occur until the closing process terminates.
In a
> quick look, I didn't see an enforced close-to-open delay for your
case.
> Maybe I missed something. I am looking at 2.4.18 Red Hat -3. I didn't
notice
> a patch to serial.c in the 2.4.19 or 2.4.20 changelog that would
affect
> this. There are some weird calculations that appear to scale the
close_delay
> field value based on HZ.
>
> Which was the last "working" kernel rev that you used?
>
> Did you switch to a faster CPU?
>
> Are you using any "low latency" patches?
>
> Did the HZ value change between the last rev that worked and 2.4.20?
>
> What HZ value are you running with?
>
> Cheers,
> Ed

I'm now using 2.4.20. The previous version was 2.2.18 (yikes)!
I just transferred my old hard disks (SCSI) to a new system and
everything worked fine, so I decided to upgrade to a later more
stable kernel. I use this system to be my own internet provider
and I am, in fact, logged in running a ppp link from home over
the modem at this time. I had to modify `agetty` to make it
work with the new kernel and a faster CPU (1.2 GHz, 330 MHz
front-side bus, Tyan Thunder-II).

The agetty code is attached. It hangs up before it sleeps for
a new connection because when the previous process terminates,
init instantly starts a new instance, the modem never hangs up
even though, possibly the DTR was lowered for that instant.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about
it.


