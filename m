Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUEETp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUEETp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUEETp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:45:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6410 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264746AbUEETpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:45:55 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: ne2k-pci uncorrectly detecting collisions ?
Date: Wed, 5 May 2004 22:45:39 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040505123532.GA3011@blop.info> <Pine.LNX.4.53.0405050855290.16355@chaos> <20040505131006.GA3412@blop.info>
In-Reply-To: <20040505131006.GA3412@blop.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405052245.39405.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2004 16:10, Lucas Nussbaum wrote:
> On Wed, May 05, 2004 at 09:00:50AM -0400, "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > > I have experienced problem with the ne2k-pci driver. The symptoms were
> > > extremly poor performance with TCP. After some investigations, I
> > > believe it might be caused by problems with detecting collisions.
> >
> > But software doesn't detect collisions. It just records what
> > hardware said it did. It looks like you have a 10 Mb/s card
> > on a 100 Mb/s network. The collisions reported are how the
> > hardware throttles the difference in physical-link speed.
>
> The hub is a 10/100 one, and the 3 RTL8029 are 10 Mbps only.
>
> > It is possible that software didn't initialize a 100 Mb/s
> > device and instead initialized it to 10 Mb/s, but you
> > don't have any evidence of that presented.
>
> No, because RTL8029 are 10 mbps only (they are BNC/RJ45 NICs).
>
> But what I thought was that maybe, they were initialised as full duplex,
> not half duplex. But again, I don't know where I can check that. I added
> some printks and determined that the code used to init them full duplex
> was never used. And there's no way to force them half duplex with this
> driver.

There is a DOS utility which configure duplex settings for RTL8029.

Also check /proc/interrupts and /proc/ioports for IRQ/ioport collisions.
--
vda

