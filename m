Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282736AbRLBEjQ>; Sat, 1 Dec 2001 23:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282728AbRLBEjF>; Sat, 1 Dec 2001 23:39:05 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:2317 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S282726AbRLBEiq>;
	Sat, 1 Dec 2001 23:38:46 -0500
Date: Sun, 2 Dec 2001 15:35:53 +1100
From: Anton Blanchard <anton@samba.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.5: PCI scatter gather list change
Message-ID: <20011202153553.B5130@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens,

I got 2.5 booting on ppc64 today and noticed that the behaviour of 
sglists has changed. Before we would get an array of sg->address,
sg->length pairs, we now get sg->page, sg->offset, sg->length triplets
(from blk_rq_map_sg).

I dont care too much either way, but if this change is here to stay I'll
let the non intel maintainers know so they can fix up their pci dma
code.

Anton
