Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVJGPFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVJGPFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVJGPFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:05:35 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:919 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1030301AbVJGPFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:05:34 -0400
Subject: 2.6.14-rc3-rt10 crashes on boot
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-Id: <E1ENtsV-00018l-5z@localhost.localdomain>
Date: Fri, 07 Oct 2005 16:11:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 7 October 2005 Ingo Molnar wrote:
>i got overflows in initramfs's gunzip with certain debug options. I have 
>improved the stack footprint of the worst offenders in -rt11 (see the 
>standalone patch below) - John, does it boot any better?

Ah. I'm using initrd. With CONFIG_LATENCY_TRACE=y my initrd.img is
large, > 3.6MB. Maybe it's time to try initramfs.

BTW I'm having trouble enabling DEBUG_STACKOVERFLOW. I can see
it in arch/i386/Kconfig.debug (and not in arch/x86_64/Kconfig.debug), 
but it doesn't appear in menuconfig no matter what other kernel hacking 
options I enable. If I add it manually to .config it just gets removed 
by `make oldconfig'. Is this an x86_64 issue?

For now I'll assume that there is a stack overflow and try initramfs.

John
