Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSFPE5I>; Sun, 16 Jun 2002 00:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSFPE5H>; Sun, 16 Jun 2002 00:57:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41228 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315921AbSFPE5G>; Sun, 16 Jun 2002 00:57:06 -0400
Date: Sat, 15 Jun 2002 21:57:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Peter Osterlund <petero2@telia.com>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.33.0206100817090.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206152148020.1839-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, Patrick Mochel wrote:
>
> Sorry about the delay. Could you please try this patch and let me know if
> it helps? It attempts to treat cardbus more like PCI, and let the PCI
> helpers do the probing.

Peter, can you just remove this patch from your kernel, I don't know how
to fix it. It does something bad to all the resource allocations. The
child resources don't find the parent any more, and you can see the result
in /proc/iomem and /proc/ioport clearly. The cardbus devices are not seen
as "children" of the cardbus controller any more from a resource
standpoint.

So can you go back to the setup before applying this patch, and do a
debugging run of that version instead?

		Linus


