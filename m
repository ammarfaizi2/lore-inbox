Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTBBMws>; Sun, 2 Feb 2003 07:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTBBMws>; Sun, 2 Feb 2003 07:52:48 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:17935 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265242AbTBBMwr>;
	Sun, 2 Feb 2003 07:52:47 -0500
Date: Sun, 2 Feb 2003 13:57:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Defect (Bug) Report
Message-ID: <20030202125745.GD19346@alpha.home.local>
References: <20030202011223.GC5432@morningstar.nowhere.lie> <1044178961.16853.9.camel@irongate.swansea.linux.org.uk> <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 01:49:11PM +0100, Erik Mouw wrote:
> On Sun, Feb 02, 2003 at 09:42:41AM +0000, Alan Cox wrote:
> > > Any other suggestions, or recommendations to get more info?
> > 
> > Three starting points
> > 
> > 1.  Run memtest86 on the box for a bit. I don't think its bad RAM however
> > 2.  Plug in a PS/2 mouse if the box doesn't have one already. That avoids
> > a hardware flaw on the AMD that we don't current work around in software
> > 3.  Check if 2.4.20 behaves the same way. I think it may fix your short
> > pauses but I don't think its going to fix the hang alas. It would be
> > useful to know however
> 
> What's the current wisdom with dual Athlon boards to get them stable?
> This is my list so far (for Asus A7M266-D):
> 
> - Plug in a PS/2 mouse even though you don't use it. It fixes certain
>   hardware problems.
> - Select "PnP OS = no" in the BIOS so all PCI devices (even the ones
>   behind the PCI-PCI bridge) get properly initialised.
> - Boot Linux with "noapic" to avoid random hangs.

I think it really depends on the motherboard revision. I bought one of the very
first ones, with buggy bios, unusable USB, etc..., but at least I have none of
the 3 problems you cite here. I have no PS/2 mouse plugged, and happily use it
in APIC mode. The 'pnp os' setup doesn't seem to have any effect either. But I
do have other problems, such as a DL2000 card hanging very quickly if plugged
into a 64bit PCI slot, so I use it in a 32bits one.
And it's a pain to say, but although I really like this machine, I wouldn't
recommend it for mission critical applications.

> Exact BIOS revision doesn't seem to matter. Any more suggestions?

Perhaps try to stabilize it with minimal hardware first, then add all
peripherals one by one and adjust the bios for each one.

Good luck,
Willy

