Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSAASgM>; Tue, 1 Jan 2002 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbSAASgC>; Tue, 1 Jan 2002 13:36:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282902AbSAASfz>; Tue, 1 Jan 2002 13:35:55 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
To: znmeb@aracnet.com (M. Edward Borasky)
Date: Tue, 1 Jan 2002 18:46:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        harald.holzer@eunet.at (Harald Holzer), linux-kernel@vger.kernel.org
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBMEAHEFAA.znmeb@aracnet.com> from "M. Edward Borasky" at Jan 01, 2002 10:15:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LTvs-00016I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Shouldn't there be *four* zones: (DMA, low, high and PAE)?

Probably not. PAE isnt special. With PAE you pay the page table penalties
for all RAM.

> 2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
> zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?

Nope. The limit for directly mapped memory is 2^30.

> 3. On a system without ISA DMA devices, can DMA and low be merged into a
> single zone?

Rarely. PCI vendors are not exactly angels when it comes to implementing all
32bits of a DMA transfer


