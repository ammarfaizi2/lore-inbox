Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264504AbSIVTs2>; Sun, 22 Sep 2002 15:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264506AbSIVTs2>; Sun, 22 Sep 2002 15:48:28 -0400
Received: from pD952AEB4.dip.t-dialin.net ([217.82.174.180]:39115 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S264504AbSIVTs1>; Sun, 22 Sep 2002 15:48:27 -0400
Date: Sun, 22 Sep 2002 13:54:10 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
In-Reply-To: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209221349380.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 21 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> +               else if (HWIF(drive)->pci_dev)
>                         addr = HWIF(drive)->pci_dev->dma_mask;

Maybe

	else if (HWIF(drive) && HWIF(drive)->pci_dev)

You never know ;-)

If drive->hwif is NULL for some insane reason, we'll suck as we did with 
->pci_dev.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

