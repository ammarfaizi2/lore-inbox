Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTJSMOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 08:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJSMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 08:14:11 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:32956 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262128AbTJSMN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 08:13:58 -0400
Message-ID: <48236.192.168.9.10.1066565636.squirrel@ncircle.nullnet.fi>
In-Reply-To: <00b801c3955c$7e623100$0514a8c0@HUSH>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>
Date: Sun, 19 Oct 2003 15:13:56 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's the current status of HPT 374 support? Is it working in any kernel
> version?

Unfortunately, in my experience the included kernel driver doesn't work
reliable at all with my hardware either. I have tried all possible
kernel versions up to and including 2.4.23-pre5 without success.

> I know HP provides binaries, but that's no good, I need to use other
> kernel
> builds.

The Highpoint proprietary drivers work fine in my case as well, but
I'm not too happy about the fact that I simply can't access the
SMART stats of my drivers at all for example.

>
> 2.4.20-8 detects the card and provides the devices but data corruptions
> happens all the time. Using the HP drivers everything works fine (note

I have tested the kernel hpt374 drivers with all possible kernel
configurations with and without ACPI/APM, local apic, io-apic and
they don't seem to change anything in my case. I just get the following
error message sooner or later and the whole system hangs.

Sep 26 23:07:42 alderan kernel: blk: queue c0466908, I/O limit 4095Mb
(mask 0xffffffff)
Sep 26 23:07:42 alderan kernel: hde: dma_timer_expiry: dma status == 0x20
Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: blk: queue c0466d5c, I/O limit 4095Mb
(mask 0xffffffff)
Sep 26 23:07:42 alderan kernel: hdg: dma_timer_expiry: dma status == 0x20
Sep 26 23:07:42 alderan kernel: hdg: timeout waiting for DMA
Sep 26 23:07:42 alderan kernel: hdg: timeout waiting for DMA

It might be that my problems are somehow related to the motherboards
I've been using, as the first one is "Epox 8K9A3+ (Via KT400 chipset)"
while the another one is "Epox 4PCA3+ (Intel 875p chipset)". But they
are 100% reproduceble with multiple brands of disk-drives.

Regards,
Tomi Orava








