Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbRCFQX0>; Tue, 6 Mar 2001 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbRCFQXQ>; Tue, 6 Mar 2001 11:23:16 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:58240 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131004AbRCFQXB>; Tue, 6 Mar 2001 11:23:01 -0500
Message-ID: <3AA50DB7.19C8A583@coplanar.net>
Date: Tue, 06 Mar 2001 11:17:59 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephane GARIN <sgarin@sgarin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre - Kernel Panic: no init found
In-Reply-To: <000e01c0a657$5a359340$4601a8c0@oracle.intranet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane GARIN wrote:

> Hi,
>
> I tried with init=/bin/sh but no success. I download a 2.2.18 Kernel and I
> use patch 2.2.19pre16 but no success too... I don't know why there is this
> error with this 2.2.19 kernel but not with my 2.2.18 kernel. I'm ready to
> send all technical information about my computer (PIII 650 with 256Mb and a
> ABIT BX133-RAID mothercard).

looks like you have a lot of partitions.  maybe the kernel isn't using the
right one
for root filesystem? if using LILO to boot, make sure root= line for your new
kernel is the same as old one.  if using redhat on a large disk, it will set up

the first partition as /boot filesystem, so kernel will mount it ok, but won't
find any programs like init or sh on it.

Let me know how this works out.

>
>
> With Regards,
> Stephane Garin
>
> -----Message d'origine-----
> De : James Stevenson
> Envoyé : samedi 3 mars 2001 18:58
> À : sgarin@sgarin.com
> Objet : Re: 2.2.19pre - Kernel Panic: no init found
>
> Hi
>
> it would mean pass something like
> init=/bin/sh
> not the runlevel you want
>
> In local.linux-kernel-list, you wrote:
> >Hi,
> >
> >I have a kernel panic with the patch 2.2.19pre16 that I test. I use a
> 2.2.18
> >Kernel very well. I used the last patch on this kernel and make my kernel
> >with sames parameters without error message. At the boot, I can see this :
> >
> >..
> >eth0: RealTek RTL8139 Fast Ethernet at 0xa800, IRQ 10, 00:50:fc:0b:60:70
> >eth1: RealTek RTL8139 Fast Ethernet at 0xac00, IRQ 11, 00:50:fc:1f:c1:98
> >Partition check:
> > hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
> >Trying to vfree() noexistent vm area (c00f0000)
> >VFS: Mounted root (ext2 filesystem) readonly.
> >Freeing unused kernel memory: 68k freed
> >Kernel panic: No init found. Try passing init= option to kernel.
> >
> >
> >
> >I tried to start with init=3 but no change. I send this information on this
> >mailing list because I think that could be a bug. Sorry if it is a wrong
> >action of me...
> >

