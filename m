Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265232AbSJWVCF>; Wed, 23 Oct 2002 17:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265231AbSJWVCF>; Wed, 23 Oct 2002 17:02:05 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:6639 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S265232AbSJWVCD>;
	Wed, 23 Oct 2002 17:02:03 -0400
Date: Wed, 23 Oct 2002 23:08:08 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 fs corruption
Message-ID: <20021023210808.GC4138@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021023144620.GB1317@debill.org> <OAEPKDBINGEGKPCJJAJDKEMDHJAA.chris.newland@emorphia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OAEPKDBINGEGKPCJJAJDKEMDHJAA.chris.newland@emorphia.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23 October 2002, at 16:13:52 +0100,
Chris Newland wrote:

> A good way to test if the problem has gone is to try to 'dd' the contents of
> an entire partition into /dev/null. This used to have a 100% lockup rate
> when I had the problem.
> 
> dd if=/dev/hda5 of=/dev/null bs=1048576
> 
As a side note to this thread, I suffered for months similar lockups
with a VIA KT266A based motherboard for my AMD Athlon XP1700+. As it was 
really obvious the problem was hardware (BIOS probably) related, I didn't 
bothered the list.

In my case (Soltek SL-75DRV2), a "dd" as the above didn't locked up the
machin (at least, not always), but chances of locking up increased
dramatically if at the same time I had "xawtv" (or another TV tuner
program for video4linux compatible cards). As a TV station pumps in the
order of several MB/s to the PCI bus, plus another ~ 40 MB/s of
sustained read rates from the IDE ATA100 disk, somehow a bug in the
BIOS/southbridge was more obvious.

Fortunately the motherboard crashed, and I got a replacement from the
same manufacturer, but a newer model, namely a SL-75DRV5 (VIA KT333
based if I remember correctly), with a completely different BIOS version
number. And since then (10+ days) no lockups, even under high stress.

Hope this experience helps others with their (maybe hardware caused)
locks in Linux (when the box hangs, and you have no idea why, you even
end up blaming Linux :).

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
