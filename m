Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJQNFU>; Thu, 17 Oct 2002 09:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSJQNFU>; Thu, 17 Oct 2002 09:05:20 -0400
Received: from wilma1.suth.com ([207.127.128.4]:53767 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S261742AbSJQNFT>;
	Thu, 17 Oct 2002 09:05:19 -0400
Subject: Re: 2.5.43 and the VIA vt8233 IDE controller.
From: Jason Williams <jason_williams@suth.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1034800703.12979.12.camel@cermanius.suth.com>
References: <1034800703.12979.12.camel@cermanius.suth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 09:13:29 -0400
Message-Id: <1034860413.19730.91.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small addendum to this post I made yesterday, I took the VIA IDE
controller code out of the kernel and it booted just fine.  And again,
my Promise RAID controller was seen just fine by the kernel, so I am
leaning even more toward a problem in the VIA driver. 

Jason

On Wed, 2002-10-16 at 16:38, Jason Williams wrote:
> I am suspecting something is amist with the via controller code in
> 2.5.43, because my promise controller goes through the same routines
> just fine.  I started to try to back trace everything to hunt down the
> culperate myself, but alas, I couldn't find the cause.  So if anyone can
> give me a hand here, I would be very grateful.  What follows is the
> bottom snippet of kernel output.  If you require anything further, let
> me know I will send it.
> 
> Jason
> 
> 
> 
> 
> ----
> 

> 
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
>     ide1: BM-DMA at 0x9008-0x900fUnable to handle kernel NULL pointer dereference at virtual address 00000650
>  printing eip:
> c024a52b
> *pde = 00000000
> Oops: 0000
> 
> CPU:    0
> EIP:    0060:[<c024a52b>]    Not tainted
> EFLAGS: 00010202
> EIP is at ide_iomio_dma+0xbb/0x1c0
> eax: 00000000   ebx: c052cbb4   ecx: c03aa274   edx: 00000001
> esi: c052cbc4   edi: 00009008   ebp: 00000008   esp: dffcbeb4
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 1, threadinfo=dffca000 task=dffc8040)
> Stack: c0380d6f 00009008 00000008 c052cbc4 c1526000 c052cbb4 c03e7a50 c052cbb4
>        c024a687 c052cbb4 00009008 00000008 00000089 c04195dd c1526000 00009008
>        c0418a58 c052cbb4 00009008 00000008 c02488be c052cbb4 00009008 00000004
> Call Trace:
>  [<c024a687>] ide_setup_dma+0x27/0x380
>  [<c02488be>] ide_hwif_setup_dma+0x10e/0x150
>  [<c0248bce>] do_ide_setup_pci_device+0x16e/0x330
>  [<c0248dbb>] ide_setup_pci_device+0x2b/0x80
>  [<c02388e8>] via_init_one+0x38/0x40
>  [<c010507a>] init+0x3a/0x160
>  [<c0105040>] init+0x0/0x160
>  [<c0105641>] kernel_thread_helper+0x5/0x14
> 
> Code: 8b 80 50 06 00 00 89 83 4c 06 00 00 c7 04 24 77 0d 38 c0 e8
>  <0>Kernel panic: Attempted to kill init!


