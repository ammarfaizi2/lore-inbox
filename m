Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271662AbRHQOWm>; Fri, 17 Aug 2001 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271666AbRHQOWd>; Fri, 17 Aug 2001 10:22:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1294 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271662AbRHQOWW>; Fri, 17 Aug 2001 10:22:22 -0400
Subject: Re: broken memory chip -> software fix?
To: david.madore@ens.fr (David Madore)
Date: Fri, 17 Aug 2001 15:25:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010817161505.A25194@clipper.ens.fr> from "David Madore" at Aug 17, 2001 04:15:05 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XkYl-0007OT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a broken bit in my memory - at address 0x04d5ae38 if you want
> to know the details (bit 29 of the double word there sometimes reads
> as 1 when it was written as 0, in particular if bit 15 is at 1).  I
> discovered this by observing a one-bit corruption of some files, and
> diagnosed it by running memtest86.
> 
> Now that I know the address, is there a way I can prevent Linux from
> using that region of memory in any way?  The simplest and cleanest

Yep. The mem= option can exclude stuff. Alternatively you can
patch arch/i386/kernel/mm/init.c:mem_init() to skip that page. 
