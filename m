Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262051AbTCRAXj>; Mon, 17 Mar 2003 19:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCRAXj>; Mon, 17 Mar 2003 19:23:39 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:17680
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262043AbTCRAXh>; Mon, 17 Mar 2003 19:23:37 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DE9@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Mon, 17 Mar 2003 16:34:25 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 4:34 PM, Richard B. Johnson wrote:
> 
> On Mon, 17 Mar 2003, Ed Vance wrote:
> [SNIPPED...]
> 
> > >
> > Hi Richard,
> >
> > What you are doing looks just fine.
> >
> > As long as HUPCL is set when the close happens, DTR will 
> > drop. There are delays that are enforced in both open and 
> > close when a second process is blocked opening a closing 
> > port. Of course, that would not be your case, because the 
> > open does not occur until the closing process terminates. 
> > In a quick look, I didn't see an enforced close-to-open 
> > delay for your case. Maybe I missed something. I am 
> > looking at 2.4.18 Red Hat -3. I didn't notice a patch to 
> > serial.c in the 2.4.19 or 2.4.20 changelog that would 
> > affect this. There are some weird calculations that 
> > appear to scale the close_delay field value based on HZ.
> >
> > Which was the last "working" kernel rev that you used?
> >
> > Did you switch to a faster CPU?
> >
> > Are you using any "low latency" patches?
> >
> > Did the HZ value change between the last rev that worked 
> > and 2.4.20?
> >
> > What HZ value are you running with?
> >
> > Cheers,
> > Ed
> 
> I'm now using 2.4.20. The previous version was 2.2.18 (yikes)!
> I just transferred my old hard disks (SCSI) to a new system and
> everything worked fine, so I decided to upgrade to a later more
> stable kernel. I use this system to be my own internet provider
> and I am, in fact, logged in running a ppp link from home over
> the modem at this time. I had to modify `agetty` to make it
> work with the new kernel and a faster CPU (1.2 GHz, 330 MHz
> front-side bus, Tyan Thunder-II).
> 
> The agetty code is attached. It hangs up before it sleeps for
> a new connection because when the previous process terminates,
> init instantly starts a new instance, the modem never hangs up
> even though, possibly the DTR was lowered for that instant.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? 
> Think about it.
> 
Hi,

Yep. 2.2.18 was a good one.
I'll look at it.

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
