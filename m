Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSGTTOC>; Sat, 20 Jul 2002 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSGTTOC>; Sat, 20 Jul 2002 15:14:02 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:40946 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317468AbSGTTOB>; Sat, 20 Jul 2002 15:14:01 -0400
Date: Sat, 20 Jul 2002 21:16:59 +0200
From: damsnet@free.fr
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with via-rhine driver and VT6103 chipset
Message-Id: <20020720211659.541d0e7c.damsnet@free.fr>
In-Reply-To: <20020720164321.GA22754@k3.hellgate.ch>
References: <20020720182044.550f2cf0.damsnet@free.fr>
	<20020720164321.GA22754@k3.hellgate.ch>
Reply-To: damsnet@free.fr
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002 18:43:21 +0200
Roger Luethi <rl@hellgate.ch> wrote:

> On Sat, 20 Jul 2002 18:20:44 +0200, damsnet@free.fr wrote:
> > I would like to report a bug, appearing in kernels 2.4.18 
> > to 2.4.19-rc3 (I have not tested with previous ones). 
> > 
> > It concerns the VIA-Rhine (ethernet) driver. I use it with
> > a VT6103 ethernet adaptator, which seems not to be supported
> > by the driver, but almost works.
> > 
> > When I use this driver in 10Mbps mode (not 100Mbps), it resets the
> > ethernet card every few seconds and at the ends I have to reboot, 
> > because the card does not work anymore. These are the messages
> > I see with repetition:
> > 
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
> > [etc, etc, ...]
> 
> Try a recent ac kernel (2.4.19rc1-ac6 or later) or the patch below.
> 
> Roger
> 
> [...]


I tested with 2.4.19-rc2-ac2 and it is effectively far far better.

With previous kernels, it used to reset the card every few (2 or 3) 
megabytes transferred.

With this one, the reset happened only one time in a 600MBytes 
transfer, so it is incomparable.

(and I had to make several tests to eventually see this bug happen)


Thanks a lot for your support.

Damien
