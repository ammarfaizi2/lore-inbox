Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310129AbSCABAC>; Thu, 28 Feb 2002 20:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310175AbSCAA4G>; Thu, 28 Feb 2002 19:56:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43536 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310271AbSCAAwk>; Thu, 28 Feb 2002 19:52:40 -0500
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
To: rui.p.m.sousa@clix.pt (Rui Sousa)
Date: Fri, 1 Mar 2002 01:07:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        german@piraos.com (German Gomez Garcia),
        jcm@netcabo.pt (=?ISO-8859-1?Q?Jos=E9?= Carlos Monteiro),
        linux-kernel@vger.kernel.org,
        emu10k1-devel@lists.sourceforge.net (emu10k1-devel),
        steve@math.upatras.gr (Steve Stavropoulos),
        d.bertrand@ieee.org (Daniel Bertrand), dledford@redhat.com
In-Reply-To: <Pine.LNX.4.44.0202282042150.1215-100000@sophia-sousar2.nice.mindspeed.com> from "Rui Sousa" at Feb 28, 2002 08:50:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbWB-0001rm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's true dma_addr_t does change from u32 to u64 and we do thinks like:
> (32 bit pci register) = cpu_to_le32(dma_handle)
> 
> What is the correct way of doing this?
> (32 bit pci register) = cpu_to_le32((u32)dma_handle)

The cast befor ethe cpu_to_ is safe if its 32bit I/O only. Maybe we should
have cpu_to_le_dma_addr_t 8)
