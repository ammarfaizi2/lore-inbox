Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268302AbRGWREV>; Mon, 23 Jul 2001 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268305AbRGWREB>; Mon, 23 Jul 2001 13:04:01 -0400
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:5578 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S268302AbRGWRD6>; Mon, 23 Jul 2001 13:03:58 -0400
Date: Mon, 23 Jul 2001 18:04:02 +0100 (BST)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
X-X-Sender: <ap1gvl@erdos.shef.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: PCI IDE initialization
Message-ID: <Pine.LNX.4.31.0107231758430.3070-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello

I asked on kernelnewbies - no reply. So, trying here. I'm not subscribed,
so CC would be greatly appreciated.

Somewhere in the background of my mind I am still trying to solve 'nicely'
the problem with my machine - no kernel since 2.0.39 can turn IDE
bus-mastering (IDE DMA) on it on. I have an ugly hack for 2.4.0, which
works, but it's ugly - it should never be run on other machines.

The problem with the newer kernels is that they fail to calculate IDE
dma_base address correctly. So, in my ugly patch I just hard-coded the
values (for ide0 and ide1) obtained from 2.0.39. And I am still hoping for
a nicer solution. My guess (partly supported by studying the sources) is
that 2.0.39 kernel used some BIOS-provided values, whereas 2.2 and 2.4
kernels use some ad hoc knowledge about various chipsets, and my chipset
somehow, although it's a simple Triton PIIX has it differently...

Anyway, for now I would really appreciate if somebody could shed some
light on the PCI IDE initialization path in 2.0(.39) vs 2.2/2.4, if indeed
2.0 reads the value set by BIOS, whereas 2.2/2.4 clears those values (I
tried reading the same address - clean) somewhere during bus
initialization, where in the code does this happen - if my assumption is
right, if not - what could be happening? I am hoping to read those values
somewhere before the bus initialization, preserve them, and allow them to
be used later if everything else fails.

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, Sheffield, U.K.
email: g.liakhovetski@sheffield.ac.uk



