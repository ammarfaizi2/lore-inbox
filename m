Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292972AbSBVTn4>; Fri, 22 Feb 2002 14:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292969AbSBVTnr>; Fri, 22 Feb 2002 14:43:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34822 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292974AbSBVTnh>; Fri, 22 Feb 2002 14:43:37 -0500
Subject: Re: is CONFIG_PACKET_MMAP always a win?
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Fri, 22 Feb 2002 19:57:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dank@kegel.com (Dan Kegel),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        zab@zabbo.net (Zach Brown)
In-Reply-To: <20020222190431.A16926@kushida.apsleyroad.org> from "Jamie Lokier" at Feb 22, 2002 07:04:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eLoz-0002vD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can process them in the ring buffer. If you can't keep up then you
> > are screwed any way you look at it 8)
> 
> That still doesn't avoid copying: af_packet copies the whole packet (if
> you want the whole packet) from the original skbuff to the ring buffer.

I'd make a handwaved claim that the first copy of the packet from a DMA
receiving source is free. Its certainly pretty close to free because the
overhead of sucking it into L1 cache will dominate and you need to do that
anyway.

Zero copy is sometimes a false friend.
