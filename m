Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268018AbUHPXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268018AbUHPXDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHPXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:02:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29669 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268015AbUHPXAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:00:46 -0400
Subject: Re: Linux SATA RAID FAQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: ecki-news2004-05@lina.inka.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040816150641.108c66a6.akpm@osdl.org>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
	 <1092315392.21994.52.camel@localhost.localdomain>
	 <20040816150641.108c66a6.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092693508.21069.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 22:58:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 23:06, Andrew Morton wrote:
> I'm sitting on the vendor's driver for these cards.  How does your work
> differ from this?

It uses the IDE layer instead of badly duplicating it in essence.

> hch questioned why we need the driver at all: just put the card in JBOD
> mode and use s/w raid drivers.  But the thing does have an on-board CPU and
> the idea is that by offloading to that, the data transits the bus just a
> single time.  The developers are off doing some comparative benchmarking at
> present.

On my set up raid1 is materially faster using their processor and raid0
is materially faster not. There are also co-existance issues with
Windows dual boot setups. The PCI single copy makes a big difference on
a 32bit/33Mhz plug in card.

Alan



