Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTDYHpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 03:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTDYHpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 03:45:05 -0400
Received: from news.cistron.nl ([62.216.30.38]:18447 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263259AbTDYHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 03:45:04 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.4.21-rc1-ac1: Filesystem corruption
Date: Fri, 25 Apr 2003 07:57:13 +0000 (UTC)
Organization: Cistron
Message-ID: <b8apop$5ti$1@news.cistron.nl>
References: <20030425073652.GA2089@defiant.crash>
X-Trace: ncc1701.cistron.net 1051257433 6066 62.216.30.38 (25 Apr 2003 07:57:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Lembcke  <es186@fen-net.de> wrote:
>Apr 25 02:19:40 defiant kernel: hdb: dma_timer_expiry: dma status == 0x60
>Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
>Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
>Apr 25 02:19:40 defiant kernel: hdb: (__ide_dma_test_irq) called while not waiting
>Apr 25 02:19:40 defiant kernel: hdb: status timeout: status=0xd0 { Busy }
>Apr 25 02:19:40 defiant kernel:
>Apr 25 02:19:40 defiant kernel: hda: DMA disabled
>Apr 25 02:19:40 defiant kernel: hdb: drive not ready for command
>Apr 25 02:19:41 defiant kernel: ide0: reset: success
>
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y

I also encounterd similar problems on several servers.

Disabling IO_APIC on uni-processor machine "fixed" things for me.
Could you recompile a kernel without IO-APIC?

I've found these problems also in 2.5.xx kernels.

My wild guess is that certain motherboards/bioses don't do what
they are supposed to do. Found problems both on AMD and P4 platforms.

Danny

-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

