Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRKRShq>; Sun, 18 Nov 2001 13:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280015AbRKRShg>; Sun, 18 Nov 2001 13:37:36 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:43976 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S280012AbRKRSh0>;
	Sun, 18 Nov 2001 13:37:26 -0500
Date: Sun, 18 Nov 2001 13:37:22 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
cc: John Jasen <jjasen@realityfailure.org>, <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <3BF7F792.8010403@fugmann.dhs.org>
Message-ID: <Pine.SGI.4.31L.02.0111181333410.12354143-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Anders Peter Fugmann wrote:

> Hi again.
>
> One thing i cannot see is "unmaskirq" setting.
> So I would really like to see the output of a plain
> hdparm /dev/hda.

[root@labrat5 /root]# /sbin/hdparm /dev/hda // 2.4.12

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40021632, start = 0

tried it with and without 32bit I/O support, and with/without unmaskirq.

[root@labrat6 linux]# /sbin/hdparm /dev/hda // RH 2.2.19-6.2.1

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40021632, start = 0

> As far as I can see the 2.4.X kernel gives much better throughput,
> but 4-5 hours for compiling the kernel is way too long on a 700Mhz
> celeron. Please try to do a
> $ make dep clean && time make bzImage -j 3
> on both 2.2.19 and 2.4.X kernel and send the time information.
>
> The line
> "PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
> using pci=biosirq." in the dmesg output is strange. Have you tried to do
> what is says?

yep. No effect on performance or error message.

Can't check the BIOS immediately, as the nearest offending beast is 20km
away.

I should have the results of make dep clean && time make bzImage -j 3 in
... a few hours. :(

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

