Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDFHtG>; Fri, 6 Apr 2001 03:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRDFHs5>; Fri, 6 Apr 2001 03:48:57 -0400
Received: from aeon.tvd.be ([195.162.196.20]:17453 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131348AbRDFHsu>;
	Fri, 6 Apr 2001 03:48:50 -0400
Date: Fri, 6 Apr 2001 09:47:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stefano Coluccini <s.coluccini@caen.it>
cc: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: st corruption with 2.4.3-pre4
In-Reply-To: <NDBBIFIMCKPOADMAJOKMKEPFDAAA.s.coluccini@caen.it>
Message-ID: <Pine.LNX.4.05.10104060945130.1178-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Stefano Coluccini wrote:
> > I'm still waiting for other reports of st/sym53c8xx on PPC under
> > 2.4.x. BTW,
> > does it work on other big-endian platforms, like sparc?
> 
> I don't know if it is the same problem, but ...
> I have a Motorola MVME5100 (PowerPC 750 based CPU) with a mezzanine PCI
> based on the sym53c875 chip. I'm using the 2_5 kernel from fmslabs and the
> first time I have downloaded the kernel all works fine, while in a
> successive update the sym53c8xx driver was changed and my board don't work
> anymore. The driver hangs on downloading the SCSI scripts.
> I'm not a SCSI driver expert, so I've solved the problem installing the old
> version of the driver.
> Tom Rini says to me that it happened when he have merged some updates from
> the 2_4 tree, so I think my problem is related to the latest updates to the
> driver.

This is a different problem. You have to do the equivalent of what
process_bridge_ranges()/pci_process_OF_bridge_ranges() (the function got
renamed recently) does for your machine. Else PCI memory space won't work.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

