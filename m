Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSI3JQr>; Mon, 30 Sep 2002 05:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbSI3JQr>; Mon, 30 Sep 2002 05:16:47 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:1043 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261984AbSI3JQp>; Mon, 30 Sep 2002 05:16:45 -0400
Date: Mon, 30 Sep 2002 05:20:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: twaugh@redhat.com, <serial24@macrolink.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <E17vkcL-0007OZ-00@alf.amelek.gda.pl>
Message-ID: <Pine.LNX.4.44.0209300515420.24805-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Marek Michalkiewicz wrote:

> What are these issues?  If they are caused by IRQ sharing between
> parallel and serial ports, and parport works fine in polling mode
> (it does for me, I've done quite a lot of printing), I'd suggest
> to use polling for now, and leave IRQ sharing support for later...

Tim would know better there since he removed it, but iirc it had something 
to do with the BARs used, hmm your card has the same PCI id and is serial 
neutered to an extent, what happens if you treat it as if it really does 
have both serial ports there? Does it still work without causing other 
problems so you can safely ignore it? FYI, Interrupt driven works great 
for me.

> The parport_serial / serial link order issue is quite old - is
> everyone using modular kernels (not affected by it) these days?
> Perhaps all of parport_serial should still be CONFIG_EXPERIMENTAL ;)

link order shouldn't affect the decision seeing as it affects all 
parport_serial anyway. You might have to wait it out and see what Tim/Ed 
have to say but i do have patches for both lying about.

Cheers,
	Zwane

-- 
function.linuxpower.ca

