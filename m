Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJOCel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 22:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJOCel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 22:34:41 -0400
Received: from firecrest.mail.pas.earthlink.net ([207.217.121.247]:2694 "EHLO
	firecrest.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262108AbTJOCej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 22:34:39 -0400
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: Valdis.Kletnieks@vt.edu, Max Valdez <maxvaldez@yahoo.com>
Subject: Re: nvidia.o on 2.4.22/2.6.0 ??
Date: Tue, 14 Oct 2003 22:33:09 -0400
User-Agent: KMail/1.5.4
References: <1066178010.14217.3.camel@garaged.fis.unam.mx> <200310150125.h9F1PJjO005719@turing-police.cc.vt.edu>
In-Reply-To: <200310150125.h9F1PJjO005719@turing-police.cc.vt.edu>
Cc: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310142233.13426.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9ef49033124a3eb4468422f3012416483f1350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 October 2003 21:25, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 15 Oct 2003 00:33:30 -0000, Max Valdez 
<maxvaldez@yahoo.com>  said:
> > Have anyone made a successful run of X with nvidia (closes
> > source) module ??, I have a TNT2 running on a
> > 2.4.20-gentoo-r7 kernel, but when I try to run X on 2.4.22*
> > or 2.6.0* I alway get an error about my screen and
> > /dev/nvidia0.
>
> 1) Get the 4496 drivers from NVidia, use "--extract-only" to
> get the pieces out. 2) Surf over to http://www.minion.de/nvidia
> and pick up the patch.  Apply it in the
> NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv directory. While
> booted to -test7, 'cp Makefile.kbuild Makefile' and then
> 'make'.
>
> (I posted more detailed directions a while ago, they should be
> in the list archives)
>
> It would certainly help if you were more specific about "get an
> error about my screen and /dev/nvidia0".

What Valdis said.

I have several nvidia cards in some of the machines I support.

Some pointers:

1} 2.4.20 is absolutely rock solid with the 4496 driver. If 
stability is required, I strongly suggest 2.4.20.

2} If you want to play with 2.4.22 or 2.6, then set up multiple 
kernels. That way you can switch between running stably and 
experimenting at boot time. I use GRUB. Note that you'll need to 
compile a version of the nvidia 4496 drivers for each kernel. To 
prevent different versions of the nvidia driver from being 
deleted, do # touch /lib/modules/2.X.Y-whatever/video/nvidia.o 
after compiling each version.

3} Different mobos/chipsets and nvidia GPU combinations seem to be 
more stable than others. My least stable combination of the 
machines I have access to is the nforce chipset with the builtin 
GeForce 2 graphics engine. I don't know if nvidia is responsible 
for this irony or ASUS.

The drivers and patches indicated by Valdis work. On many 
machines, you'll get "badness in pci_subsys_init in search.c" 
messages. It's my opinion that this is something that nVidia 
needs to fix. In 2.6.0-test7-bk3, APIC and ACPI seems reasonably 
solid.

Guy


-- 
Recyle computers. Install Gentoo GNU/Linux.

