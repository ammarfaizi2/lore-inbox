Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSJYUMG>; Fri, 25 Oct 2002 16:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSJYUMG>; Fri, 25 Oct 2002 16:12:06 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17351 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261587AbSJYUMG>; Fri, 25 Oct 2002 16:12:06 -0400
Subject: Re: [OT]AMD/Intel interrupt latency (jitter) differences?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB99E3D.798B9A5F@compro.net>
References: <3DB99E3D.798B9A5F@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 21:35:52 +0100
Message-Id: <1035578152.13244.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 20:40, Mark Hounschell wrote:
> When we run this program in the emulation on an intel box all is well. When we
> run this in the emulation on an AMD MP 1900+ box the determinism (jitter) is
> very bad. Sometimes as much as 500us. On the Dual Intel 2.2 p4 zeon the
> determinism (jitter) is under 50us. All the other benchmarks we run under the
> emulation tell us that the AMD box is the faster box. It's also cheaper. So I
> guess my question is, are there any known problem with AMD's and interrupt
> latency jitter. I might also add that the only way we get satisfactory numbers,

A lot of the IRQ delivery depends on the APIC. SO for example you'd
probably see horrible numbers on a PIII, but very good on PIV. It also
depends on chipset vagueries. You might also need to check that your PCI
behaviour has no posting errors since the AMD certainly seems to do a
lot more aggressive PCI posting.

Does "noapic" change the jitter ?

