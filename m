Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJPUaV>; Wed, 16 Oct 2002 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSJPUaV>; Wed, 16 Oct 2002 16:30:21 -0400
Received: from wilma1.suth.com ([207.127.128.4]:14609 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S261390AbSJPUaU>;
	Wed, 16 Oct 2002 16:30:20 -0400
Subject: 2.5.43 and the VIA vt8233 IDE controller.
From: Jason Williams <jason_williams@suth.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-WMtWbZXZ/Ku4K9o0Xu5P"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Oct 2002 16:38:18 -0400
Message-Id: <1034800703.12979.12.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WMtWbZXZ/Ku4K9o0Xu5P
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I am suspecting something is amist with the via controller code in
2.5.43, because my promise controller goes through the same routines
just fine.  I started to try to back trace everything to hunt down the
culperate myself, but alas, I couldn't find the cause.  So if anyone can
give me a hand here, I would be very grateful.  What follows is the
bottom snippet of kernel output.  If you require anything further, let
me know I will send it.

Jason




--=-WMtWbZXZ/Ku4K9o0Xu5P
Content-Disposition: attachment; filename=kerneloutput.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=kerneloutput.txt; charset=ISO-8859-1


VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
=A0=A0=A0 ide1: BM-DMA at 0x9008-0x900fUnable to handle kernel NULL pointer=
 dereference at virtual address 00000650
 printing eip:
c024a52b
*pde =3D 00000000
Oops: 0000

CPU:=A0=A0=A0 0
EIP:=A0=A0=A0 0060:[<c024a52b>]=A0=A0=A0 Not tainted
EFLAGS: 00010202
EIP is at ide_iomio_dma+0xbb/0x1c0
eax: 00000000=A0=A0 ebx: c052cbb4=A0=A0 ecx: c03aa274=A0=A0 edx: 00000001
esi: c052cbc4=A0=A0 edi: 00009008=A0=A0 ebp: 00000008=A0=A0 esp: dffcbeb4
ds: 0068=A0=A0 es: 0068=A0=A0 ss: 0068
Process swapper (pid: 1, threadinfo=3Ddffca000 task=3Ddffc8040)
Stack: c0380d6f 00009008 00000008 c052cbc4 c1526000 c052cbb4 c03e7a50 c052c=
bb4
=A0=A0=A0=A0=A0=A0 c024a687 c052cbb4 00009008 00000008 00000089 c04195dd c1=
526000 00009008
=A0=A0=A0=A0=A0=A0 c0418a58 c052cbb4 00009008 00000008 c02488be c052cbb4 00=
009008 00000004
Call Trace:
 [<c024a687>] ide_setup_dma+0x27/0x380
 [<c02488be>] ide_hwif_setup_dma+0x10e/0x150
 [<c0248bce>] do_ide_setup_pci_device+0x16e/0x330
 [<c0248dbb>] ide_setup_pci_device+0x2b/0x80
 [<c02388e8>] via_init_one+0x38/0x40
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c0105641>] kernel_thread_helper+0x5/0x14

Code: 8b 80 50 06 00 00 89 83 4c 06 00 00 c7 04 24 77 0d 38 c0 e8
 <0>Kernel panic: Attempted to kill init!

--=-WMtWbZXZ/Ku4K9o0Xu5P--

