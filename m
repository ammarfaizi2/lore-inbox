Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292813AbSCZH5B>; Tue, 26 Mar 2002 02:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCZH4l>; Tue, 26 Mar 2002 02:56:41 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:6405 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S292813AbSCZH4e>;
	Tue, 26 Mar 2002 02:56:34 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200203261047.g2QAlXT17258@ibe.miee.ru>
Subject: Re: NE2k driver issue
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 26 Mar 2002 13:47:32 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16d8xu-0000IV-00@the-village.bc.nu> from "Alan Cox" at Feb 19, 2002 12:01:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> > > the time.  This means it is generating interrupts even when you aren't
> > > listening to anything.
> > 
> > But the odd thing is that the soundcard interrupts tentupled the
> > samba throughput.  Which sounds like a driver-handoff-to-ksoftirqd
> > problem. 
> 
> Or an IRQ routing bug
> 
   Okay guys, new data on this issue.
	the kernel 2.4.17 which i used so far had this issue - ie the transfer rate drop
400k -> 20-30k without esd.
	i recently switched to 2.4.19-pre3 and the behaviour reverted:
now it drops 300k -> 50k due to esd active.

	i think both behaviours are broken, cause the 2.4.17 case clearly shows that
ne2k perfectly runs at full speed with _active_ esd.

	ie summarizing we have:
		2.4.17:		esd -> 20k bumps to 400k
		2.4.19p3:	esd -> 300k drops to 50k

regards, Samium Gromoff
