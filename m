Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJYUdT>; Fri, 25 Oct 2002 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJYUdT>; Fri, 25 Oct 2002 16:33:19 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:1803 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S261571AbSJYUdR>; Fri, 25 Oct 2002 16:33:17 -0400
Message-ID: <3DB9ACF0.A7DBA5C4@compro.net>
Date: Fri, 25 Oct 2002 16:43:28 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT]AMD/Intel interrupt latency (jitter) differences?
References: <3DB99E3D.798B9A5F@compro.net> <1035578152.13244.44.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-10-25 at 20:40, Mark Hounschell wrote:
> > When we run this program in the emulation on an intel box all is well. When we
> > run this in the emulation on an AMD MP 1900+ box the determinism (jitter) is
> > very bad. Sometimes as much as 500us. On the Dual Intel 2.2 p4 zeon the
> > determinism (jitter) is under 50us. All the other benchmarks we run under the
> > emulation tell us that the AMD box is the faster box. It's also cheaper. So I
> > guess my question is, are there any known problem with AMD's and interrupt
> > latency jitter. I might also add that the only way we get satisfactory numbers,
> 
> A lot of the IRQ delivery depends on the APIC. SO for example you'd
> probably see horrible numbers on a PIII, but very good on PIV. It also
> depends on chipset vagueries. You might also need to check that your PCI
> behaviour has no posting errors since the AMD certainly seems to do a
> lot more aggressive PCI posting.
> 
> Does "noapic" change the jitter ?

Actually if I use noapci then the irq affinity stuff does not work, which in
itself causes
the jitter to be unexceptable. On the AMD, the process and irq affinity appears
to be working
correctly, according to /proc/interrupts, but maybe it's really not??? Thats
what it acts
like. It acts just like if I hadn't set the affinity for the emulation and irq
on the P4,
just not as bad.

Regards
Mark
