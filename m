Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbUAMS76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUAMS76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:59:58 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:56518 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265392AbUAMS7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:59:55 -0500
Date: Tue, 13 Jan 2004 18:59:48 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Paul Symons <PaulS@paradigmgeo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops 2.4.24
Message-ID: <20040113185948.GA17867@axis.demon.co.uk>
References: <798DD0DBF172864C8CC752175CF42BA326C8B2@pat.aberdeen.paradigmgeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798DD0DBF172864C8CC752175CF42BA326C8B2@pat.aberdeen.paradigmgeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:44:18AM -0000, Paul Symons wrote:
> I'm having a few problems with 2.4.24. I keep suffering oops's when
> performing intensive operations. 
> 
> Hardware: VIA EPIA 5000 / C3 processor

I've been extensively thrashing one of these recently.  I've compiled
several kernels for it, but all with the "CyrixIII" for VIA Cyrix III
or VIA C3 option.  This sets CONFIG_MCYRIXIII.

Have you tried memset86 on the hardware?

> I am trying to run Gentoo on this hardware, and have had problems from the
> start, with respect to compiling things like Gentoo. The hardware is a
> little bit of an oddity, because i read that it is classed as i686, yet it
> doesn't support the cmov opcode. All my compile optimisations have been at
> best i586 as a result.

I wonder if you are thinking of the Nehemiah (the C3 mark 2) rather
than the Samuel which is on that board.  As far as I'm aware its only
safe to use i386 code and that is what we've been using very
succesfully (with a Debian/stable installation).

> I'm not sure why ksymoops reports it as i686. I had originally tried running
> on 2.6.0, however I kept getting oops's with the via-rhine driver, so I
> thought I'd try with 2.4.24. The only difference with my config between
> 2.6.0 and 2.4.24 was that 2.6.0 was optimised for VIA-C3 processor type,
> while 2.4.24 was optimised for i586.

2.4.23 does have a C3 option.

However that said my attempts to get this board to run 2.4.23 have
failed because the IDE driver refuses to initialise - as if it doesn't
understand the PCI ID, eg under 2.4.19 I get this

VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLP LM20.5, ATA DISK drive

But under 2.4.23 - nothing!  The module loads from the initial ram
disk (I'm 100% sure of this because I've done it by hand from the
initial ram disk shell) but it prints nothing!

I haven't tried 2.4.24 - there didn't appear to be any appropriate
changes in the ChangeLog.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
