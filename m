Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSAASQl>; Tue, 1 Jan 2002 13:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282799AbSAASQU>; Tue, 1 Jan 2002 13:16:20 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:31506 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S282845AbSAASQO>; Tue, 1 Jan 2002 13:16:14 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Harald Holzer" <harald.holzer@eunet.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Tue, 1 Jan 2002 10:15:59 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBMEAHEFAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16KOTk-0005F3-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because much of the memory cannot be used for kernel objects there is an
> imbalance in available resources and its very hard to balance them sanely.

As I understand it, in a Linux / i686 system, there are three zones: DMA
(0 - 2^24-1), low (2^24 - 2^30-1) and high (2^30 and up). And the hardware
(PAE) apparently distinguishes memory addresses above 2^32-1 as well.
Questions:

1. Shouldn't there be *four* zones: (DMA, low, high and PAE)?

2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?

3. On a system without ISA DMA devices, can DMA and low be merged into a
single zone?

4. It's pretty obvious exactly which functions require memory under 2^24 --
ISA DMA. But exactly which functions require memory under 2^30 and which
functions require memory under 2^32? It seems relatively easy to write a
Perl script to truck through the kernel source and figure this out; has
anyone done it? It would seem to me a valuable piece of information -- what
the demands are for the relatively precious areas of memory under 1 GB and
under 4 GB.
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

