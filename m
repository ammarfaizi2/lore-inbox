Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317956AbSFNQd6>; Fri, 14 Jun 2002 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSFNQd5>; Fri, 14 Jun 2002 12:33:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317956AbSFNQd4>; Fri, 14 Jun 2002 12:33:56 -0400
Date: Fri, 14 Jun 2002 09:33:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <petero2@telia.com>
cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <m2lm9n2ary.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.44.0206140929050.2576-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Jun 2002, Peter Osterlund wrote:
>
> It doesn't help unfortunately. The network card is not detected at
> boot and I get the same oops at shutdown as with a vanilla 2.5.21
> kernel.

Actually, the card seems to be detected, but:

	PCI: Device 01:00.0 not available because of resource collisions

Can you enable PCI debugging and send a full log of that? The DEBUG stuff
is sadly a manual diff and a recompile: please manually enable DEBUG in
arch/i386/pci/pci.h and in drivers/pci/*.c (yes, there's not even one
global place, you have to do it individually for each *.c file, ugh).

		Linus

