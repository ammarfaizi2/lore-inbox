Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSLCVLs>; Tue, 3 Dec 2002 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSLCVLs>; Tue, 3 Dec 2002 16:11:48 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:61089 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266100AbSLCVLr>; Tue, 3 Dec 2002 16:11:47 -0500
Subject: Re: Widespread hda lost interrupt problem on laptops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Kessel <adam@bostoncoop.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021203203249.GA747@joehill>
References: <20021203203249.GA747@joehill>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 21:53:21 +0000
Message-Id: <1038952401.11439.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 20:32, Adam Kessel wrote:
> When switching from power to battery on the HP OmniBook 500 laptop (and
> many other laptops, apparently) the following appears in syslog:
> 
> kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> kernel: hda: lost interrupt

An interrupt went walkies. That in itself isnt a fatal event. I've seen
that from various boxes. Sometimes it shows up because an I/O was in
progress when the bios decided to suspend on us.

> Sometimes it results in severe hard disk corruption, and usually causes a
> system crash if the error occurred during intensive disk activity (no
> further disk access is possible).  It occurs equally when the drive is
> mounted read-only and/or in runlevel 1.

If you get disk corruption on a read only disk I think it has to be BIOS
side problems. On r/w you shouldnt. (Known exceptions - casio fiva 'lets
come back with the disk in a different configuration and suprise
everyone' and some ibm thinkpads with 20GB 2.5" disks - which
mysteriously goes away if you change disk and was also reported in
windows by some users)

Basically the OB500 is 'WONTFIX' or closer to 'CANTFIX'. I think you'll
need someone with HP BIOS source to pin it down even if the bug turns
out to be in the kernel code.

