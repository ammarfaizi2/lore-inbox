Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVLXVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVLXVVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVLXVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:21:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17613 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750727AbVLXVVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:21:42 -0500
Date: Sat, 24 Dec 2005 22:21:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Clark Williams <williams@redhat.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-rt4 x86 patch
In-Reply-To: <1135100583.3415.16.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0512242221130.29877@yvahk01.tjqt.qr>
References: <1135100583.3415.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I still need the following to compile with PREEMPT_RT on an x86:


Ah. Does that explain the big compile failure in lib/rwsem.c I just 
stumbled over too?


>
>--- ./arch/i386/Kconfig.cpu.orig        2005-12-20 11:26:34.000000000 -0600
>+++ ./arch/i386/Kconfig.cpu     2005-12-20 11:33:23.000000000 -0600
>@@ -229,11 +229,6 @@
>        depends on M386
>        default y
>
>-config RWSEM_XCHGADD_ALGORITHM
>-       bool
>-       depends on !M386
>-       default y
>-
> config GENERIC_CALIBRATE_DELAY
>        bool
>        default y


Jan Engelhardt
-- 
