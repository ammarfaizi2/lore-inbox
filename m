Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbRCADdR>; Wed, 28 Feb 2001 22:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRCADdH>; Wed, 28 Feb 2001 22:33:07 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:11929 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129469AbRCADcy>; Wed, 28 Feb 2001 22:32:54 -0500
Message-ID: <3A9DC1CF.1A302EC9@coplanar.net>
Date: Wed, 28 Feb 2001 22:28:15 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Peter.Havens@Level3.com
Subject: Re: Promise Ultra100 IDE PDC20265 chip problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter.Havens@Level3.com wrote:

> (I am not subscribed to this list, if it is in fact a list. Please CC
any
> replies to me directly - Thanks)
>
> I am attempting to install the new beta release of Red Hat (fisher) on
my
> home computer. It has an Asus A7V motherboard and a Promise Ultra100
IDE
> controller (PDC20265 chip), with two partitions. Windows ME is
installed in
> the first partition. The second one is where I'm attempting to install
Red
> Hat.
>
> In previous releases of the Linux kernel, my hard drive was not seen
at all.
> I could go all the way up to the point in the Red Hat installation
where it
> wanted to do disk geometry, and then said that I didn't have any mass
media
> device. Searching through various mail archives lead me to believe the

> culprit was the PDC20265 controller chip and the fact that it was too
new to
> be recognized.
>
> In the new kernel 2.4.0 (and thereby the fisher release of Red Hat), I
now
> see the error below printed out to the console when booting from the
Red Hat
> installation floppy. After the error is printed out, my computer
hangs. I
> apologize in advance if this is not a Linux kernel issue, and
appreciate any
> help that can be provided.
>
> --Pete
>
> [snip]
>
> PDC 20265: chipset revision 2
> PDC 20265: not 100% native mode: will probe irqs later
>
> [snip]
>
> Partition Check:
> hde: [PTBL] [1826/255/63] hde1 hde2 < hde5hde: dma_intr: status=0x51 {

> DriveReady SeekComplete Error }
> hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=32885055,
sector=0
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>
> [last repeats 3-4 times]
>
> hde: DMA disabled
>

this looks like a sign that the kernel you're using is configured to try
to use

harddisk DMA right at boot.  That *could* cause problems in rare cases.
SectorIdNotFound looks like a bad sector on the harddisk though.
looks like you can't get into linux at all... try scandisk from windows
on Thorough setting (have to format linux partition as fat32 first).



