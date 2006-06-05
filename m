Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750723AbWFEIEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFEIEt (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWFEIEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:04:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750723AbWFEIEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:04:48 -0400
Subject: Re: 2.6.17-rc5-mm3
From: Arjan van de Ven <arjan@infradead.org>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060605011531.0bfe67db@werewolf.auna.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605011531.0bfe67db@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jun 2006 10:04:42 +0200
Message-Id: <1149494682.3111.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 01:15 +0200, J.A. Magallón wrote:
> On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
> > 
> > - Lots of PCI and USB updates
> > 
> > - The various lock validator, stack backtracing and IRQ management problems
> >   are converging, but we're not quite there yet.
> > 
> 
> Got this on boot. Looks like another locking bug in firewire:
> 
> ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 20
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[ec024000-ec0247ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> stopped custom tracer.
> 
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {hardirq-on-W} -> {in-hardirq-R} usage.
> idle/0 [HC1[1]:SC1[0]:HE0:SE0] takes:
>  (hl_irqs_lock){--+.}, at: [<f8835cb9>] highlevel_host_reset+0x11/0x5b [ieee1394]

this one was reported a few days ago and acknowledged by the firewire
people as real.. it seems they haven't sent Andrew a fix yet.
If they don't do that today I'll send a provisional fix

