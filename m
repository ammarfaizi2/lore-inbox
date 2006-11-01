Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752465AbWKAVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbWKAVuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbWKAVuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:50:18 -0500
Received: from www.osadl.org ([213.239.205.134]:62379 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1752465AbWKAVuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:50:16 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 22:51:56 +0100
Message-Id: <1162417916.15900.271.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:07 +0100, Andreas Mohr wrote:
> Hello all,
> 
> on my system I'm having the usual (already known from Con Kolivas
> earlier dynticks patches) problems with missed ticks: I have to generate
> keyboard or mouse interrupts to let my system proceed with booting
> (semi-)properly.
> Once in X11 it's better (due to many IRQs being triggered here, I assume),
> but still not perfect.
> 
> This did "work properly" (for whatever reason) with 2.6.19-rc1-mm* and got
> broken once going to -rc2-mm*, IIRC. -rc4-mm1 is stock version without
> any local patches (for accurate bug reporting).
> 
> x86 UP Athlon 1200, VIA chipset.
> 
> Probably some problem with VIA chipsets and APIC, PIT, ...?
> 
> Would be nice to get this to work properly, anything I should try to debug?

Can you try:

http://tglx.de/projects/hrtimers/2.6.19-rc4-mm1/patch-2.6.19-rc4-mm1-hrt-dyntick1.patch

on top of -mm please? Can you mail me a boot log of that ?

Thanks,

	tglx


