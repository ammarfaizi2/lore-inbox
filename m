Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWAWM4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWAWM4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWAWM4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:56:49 -0500
Received: from mx.laposte.net ([81.255.54.11]:36478 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932136AbWAWM4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:56:48 -0500
Message-ID: <4432.192.54.193.25.1138020919.squirrel@rousalka.dyndns.org>
Date: Mon, 23 Jan 2006 13:55:19 +0100 (CET)
Subject: Re: OOM Killer killing whole system
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: kalin@thinrope.net, chase.venters@clientec.com, axboe@suse.de,
       arjan@infradead.org, akpm@osdl.org, James.Bottomley@SteelEye.com,
       a.titov@host.bg, davej@redhat.com, jgarzik@pobox.com
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20060118.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote :
> Just a shot in the dark, but in the last few kernel revisions have you
> experienced any SATA problems with DMA timeouts, in some versions
leading to
> a hang?

Like this for example ?
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951
http://bugzilla.kernel.org/show_bug.cgi?id=5914

Jens Axboe wrote :
> Just a note - you seem to have the raid1 in common with the rest of the
> reporters so far.

This is a sata x86-64 raid1 system too.
With recent git kernels raid goes half-dead at boot, with FS corruption.

I think I also managed to have it OOM a few weeks ago (2.6.15 or
pre-2.6.15) which is quite a feat for a 2-GiB desktop (didn't report it at
the time, possible culprits where either ivtv of massive IO - I
shuffled/processed ~10 GiB of picture data from SATA CDs and then all
around the FS). The memory was unreclaimable, didn't know to check for
slab at the time. (also when I did use ivtv it generated some fat mpeg2
files)
The new corrupting problem is whith kernels without ivtv (I only build it
for kernels which boot fine)

All the kernels are un-tainted (only patches are davej ones and in one
case v4l+ivtv)

Regards,

-- 
Nicolas Mailhot

