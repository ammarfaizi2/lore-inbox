Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTIDTdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTIDTdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:33:17 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:21721 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265223AbTIDTdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:33:15 -0400
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309041112530.6676-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309041112530.6676-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062703855.22550.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 20:30:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 19:24, Linus Torvalds wrote:
>    interfaces. The interfaces aren't well specified enough to write a PCI
>    disk driver, of course, but they _are_ good enough to do discovery and 
>    a lot of things.

To be fair - for the hardware extant at the time - they were. Our 
drivers/ide/pci/generic.c is exactly that. Also beyond the PCI code the
vendors managed to create a standard that actually basically works and
is back compatible. Bits of it are rather Lovecraftian but it works. 
ide/pci/generic.c will drive almost any IDE controller today in BIOS
tuned mode including basic IDE DMA.

>    Intel _could_ make a "PCI disk controller interface definition", and it 
>    will work. The way USB does actually work, and UHCI was actually a fair 
>    standard, even if it left _way_ too much to software.

UHCI, OHCI, their reuse for firewire and other stuff are all great
examples. VGA is another example which alas fell apart as cards changed
over time. Its always struck me as bizarre that graphics card vendors
can create a chip that can texture a billion triangles a second but
can't manage to agree on a hardware interface where I load height,
width, depth and refresh rate and it sets it up for me.

I grant I2O proved that you can make that control layer too complicated.
Even then it wasn't the hardware interface that was the problem, it was
the glue on top. People still use the i2o hw interface for many things.

I'm hopeful now the world is effectively down to two scsi vendors
(Adaptec and LSI) we can at least begin to see a reduction in the number
of permutations of scsi insanity.

