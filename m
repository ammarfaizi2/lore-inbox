Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbRATSyS>; Sat, 20 Jan 2001 13:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131754AbRATSyI>; Sat, 20 Jan 2001 13:54:08 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:39686 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131721AbRATSx5>;
	Sat, 20 Jan 2001 13:53:57 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101201853.VAA05120@ms2.inr.ac.ru>
Subject: Re: Is sendfile all that sexy?
To: torvalds@transmeta.COM (Linus Torvalds)
Date: Sat, 20 Jan 2001 21:53:42 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <94ach5$mcs$1@penguin.transmeta.com> from "Linus Torvalds" at Jan 20, 1 01:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Actually, as long as there is no "struct page" there _are_ problems.
> This is why the NUMA stuff was brought up - it would require that there
> be a mem_map for the PCI pages.. (to do ref-counting etc).

I see.

Is this strong "no-no-no"? What is obstacle to allow "struct page"
to sit outside of mem_map (in some private table, or as full orphan)?
Only bloat of struct page with reference to some "page_ops" or something
more profound?


> It does work at least on some hardware.  But no, I don't think you can
> depend on bursting (but I don't see why it couldn't work in theory). 

I do not see too, but documents are pretty obscure explaining this.
MRM seems to be prohibited for pci-pci. But my education is still not 
enough even to understand, whether MRM is required to burst
or this is fully orthogonal yet. 8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
