Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSEINPC>; Thu, 9 May 2002 09:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSEINPB>; Thu, 9 May 2002 09:15:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33801 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310769AbSEINPA>; Thu, 9 May 2002 09:15:00 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: andre@linux-ide.org (Andre Hedrick)
Date: Thu, 9 May 2002 14:32:09 +0100 (BST)
Cc: ltd@cisco.com (Lincoln Dale), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10205082055530.924-100000@master.linux-ide.org> from "Andre Hedrick" at May 08, 2002 09:16:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175o1h-0003jl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are right on the money!
> There is about 35-40% throughput killjoy "copy-from-kernel-to-userspace".
> It is easy to demo if you have a bus analizer and can do accounting on the
> data io less the command block overhead.
> 
> CR3's are your friend, not ...

You should be able to verify that by using large O_DIRECT I/O's. The
block layer itself may well be part of the overhead. With the scsi layer,
the block->scsi handling code is definitely a bottleneck to performance
