Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUEQLLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUEQLLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUEQLLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:11:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42971 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264983AbUEQLL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:11:29 -0400
Date: Mon, 17 May 2004 13:10:34 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
In-Reply-To: <40A4ED87.20608@pobox.com>
Message-ID: <Pine.GSO.4.58.0405171308580.19405@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
 <20040514150900.GA19315@lists.us.dell.com> <40A4ED87.20608@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004, Jeff Garzik wrote:
> Matt Domsch wrote:
> > On Fri, May 14, 2004 at 03:11:00PM +0200, Geert Uytterhoeven wrote:
> >
> >>I'm trying to install Linux on a SATA disk in a Dell PowerEdge 750, which has
> >>an Intel 82875P chipset with an Intel 6300ESB SATA Storage Controller.
> >
> >
> > [snip]
> >
> >
> >>I looked at ata_piix.c, and apparently the driver decides whether a port is
> >>disabled by checking a bit in PCI config space, so this looks like a BIOS setup
> >>problem to me. But the BIOS has the first SATA port enabled (`AUTO', and it
> >>does see a 80 GB disk there), while the PATA and second SATA ports are marked
> >>`OFF'.
> >
> >
> > Right.  At present you need to enable the second SATA  port in the
> > BIOS.  Disabling it also disables the first port from being
> > recognized by the driver.  It's a figment of the "compatability mode"
> > that the PE750 runs in.  I believe Stuart Hayes sent Jeff a patch to
> > address this, but I can't find it handy...
>
>
> That _should_ have been fixed in the last update to ata_piix.  If you
> could get Stuart to re-test and re-submit that patch if necessary, that
> would be useful.
>
> Geert, two things to try:
> 1) Try the latest kernel

Thanks! I'll try that one...

> 2) Fiddle with BIOS settings until your PATA and SATA devices appear as
> _separate_ devices on the PCI bus.

There's no option in the BIOS for that (at least I didn't find it), only to
disable IDE completely, which upon selection makes the Intel 6300ESB SATA
Storage Controller disappear from the lspci listing.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
