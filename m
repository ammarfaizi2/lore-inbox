Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbTFQIVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbTFQIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:21:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24467 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264635AbTFQIVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:21:21 -0400
Date: Tue, 17 Jun 2003 10:34:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chuck Berg <chuck@encinc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: panic in ide_dma_intr on KT400
In-Reply-To: <20030616225319.A18522@timetrax.localdomain>
Message-ID: <Pine.SOL.4.30.0306171027410.13723-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jun 2003, Chuck Berg wrote:

> I have a machine with a Soyo Dragon motherboard (Via KT400 chipset).
>
> With kernels 2.5.69, 2.5.70, and 2.5.71, it panics in ide_dma_intr() while
> detecting the IDE drives. If I boot with pci=noacpi or acpi=off, two of my
> drives come up without DMA, rendering the system unusably slow.

You forgot to compile in VIA IDE support,
there is no CONFIG_BLK_DEV_VIA82CXXX=y in your 2.5 config.

--
Bartlomiej

