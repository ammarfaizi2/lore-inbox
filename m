Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTFSD17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265705AbTFSD17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:27:59 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:52446
	"EHLO medicaldictation.com") by vger.kernel.org with ESMTP
	id S265704AbTFSD16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:27:58 -0400
Date: Wed, 18 Jun 2003 23:41:59 -0400
From: Chuck Berg <chuck@encinc.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic in ide_dma_intr on KT400
Message-ID: <20030618234159.A25965@timetrax.localdomain>
References: <20030616225319.A18522@timetrax.localdomain> <Pine.SOL.4.30.0306171027410.13723-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.30.0306171027410.13723-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Tue, Jun 17, 2003 at 10:34:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 10:34:48AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 16 Jun 2003, Chuck Berg wrote:
> > I have a machine with a Soyo Dragon motherboard (Via KT400 chipset).
> >
> > With kernels 2.5.69, 2.5.70, and 2.5.71, it panics in ide_dma_intr() while
> > detecting the IDE drives. If I boot with pci=noacpi or acpi=off, two of my
> > drives come up without DMA, rendering the system unusably slow.
> 
> You forgot to compile in VIA IDE support,
> there is no CONFIG_BLK_DEV_VIA82CXXX=y in your 2.5 config.

Thanks...

With that enabled, DMA works. Now (with 2.5.72 and pci=noacpi) the system
crashes with no messages when I read from all my drives at the same time as
heavy network activity. Without pci=noacpi I get the same panic in
ide_dma_intr() while detecting the drives.

Bootup messages and .config:
http://encinc.com/~chuck/kt400/2.5.72-boot.txt
http://encinc.com/~chuck/kt400/config-2.5.72.txt
