Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQJ3Sfr>; Mon, 30 Oct 2000 13:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ3Sf1>; Mon, 30 Oct 2000 13:35:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29772 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129042AbQJ3SfU>; Mon, 30 Oct 2000 13:35:20 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Mon, 30 Oct 2000 18:34:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jmerkey@vger.timpanogas.org (Jeff V. Merkey),
        mingo@elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <39FDB623.74C200A7@timpanogas.org> from "Jeff V. Merkey" at Oct 30, 2000 10:55:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qJlo-00077p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> context switches.   profiling Ring 0 Linux vs. NetWare will give me an
> excellent idea of where 
> the optimizations will need to be inserted.  A straight MARS-NWE port to
> kernel would just
> happen, since we would be able to just load in kernel space and run it
> with no code 
> changes.  

There are one bunch of people running Linux on a flat memory space with no
protection although their goal was to make Linux run on mmuless embedded
hardware.

See www.uclinux.org; the uclinux guys started a 2.4 port recently. Basically
the idea is to have a mm-nommu/ directory which implements a mostly compatible
replacement for the mm layer (obviously stuff like mmap dont work without an
mmu and fork is odd), and a set of binary loaders to load flat binaries with
relocations.

That I think is the project that overlaps ..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
