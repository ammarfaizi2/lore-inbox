Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135852AbRD3Qrb>; Mon, 30 Apr 2001 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135869AbRD3QrX>; Mon, 30 Apr 2001 12:47:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135852AbRD3QrF>; Mon, 30 Apr 2001 12:47:05 -0400
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Mon, 30 Apr 2001 17:46:41 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), davem@redhat.com (David S. Miller),
        jgarzik@mandrakesoft.com (Jeff Garzik), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010429221159.U706@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Apr 29, 2001 10:11:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uGov-0008HN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The point is: The code in that "magic page" that considers the
> tradeoff is KERNEL code, which is designed to care about such
> trade-offs for that machine. Glibc never knows this stuff and
> shouldn't, because it is already bloated.

glibc is bloated because it cares about such stuff and complex standards.
There is no reason to make a mess of the kernel when you can handle more
stuff nicely with the libraries.

Since glibc inlines most memcpy calls you'd need to build an MXT glibc,
which is doable. Uninlining most memcpy calls is a loss on some processors
and often a loss anyway as the copies are so small


