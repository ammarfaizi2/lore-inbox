Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSJXKWI>; Thu, 24 Oct 2002 06:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265377AbSJXKWI>; Thu, 24 Oct 2002 06:22:08 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56002 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265369AbSJXKWH>; Thu, 24 Oct 2002 06:22:07 -0400
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Osamu Tomita <tomita@cinet.co.jp>, Andrey Panin <pazke@orbita1.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021024110927.A2733@ucw.cz>
References: <20021022065028.GA304@pazke.ipt>
	<3DB5706A.9D3915F0@cinet.co.jp>
	<1035374538.4033.40.camel@irongate.swansea.linux.org.uk>
	<3DB6A212.74D592D0@cinet.co.jp>  <20021024110927.A2733@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 11:45:08 +0100
Message-Id: <1035456308.8675.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 10:09, Vojtech Pavlik wrote:
> For system resources you simply could allocate 0x00-0x2f and be done
> without the sparse flag, but if there are any other devices that have
> overlapping resources, which need separate drivers (IDE, sound, network,
> ...) then the sparse ioresource flag is indeed needed. Is it so?

Possibly although this is not an entirely unique problem. The other way
would be (post 2.6) to add a mask. That will also let us properly handle
the PCI/ISA partial decode for example.


