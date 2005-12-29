Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVL2SZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVL2SZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 13:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVL2SZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 13:25:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59121 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750776AbVL2SZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 13:25:15 -0500
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 10:25:13 -0800
Message-Id: <1135880714.19492.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have any power management features turned on?

I've seen some traces that look like this on buggy intel x86 hardware.
When a small two line function with no loops lasts for 10ms . One of
your traces showed irq_exit() lasting 9ms . It's like the process just
stops.

Daniel

On Thu, 2005-12-29 at 16:08 +0100, kus Kusche Klaus wrote:
> I took some latency traces on our sa1100 (see attachment) running
> 2.6.15-rc7-rt1 with full preemption.
> They look very bad at the first glance, but I cannot interpret them in
> detail.
> 
> Trace 3, 4 and 5 seem to have obvious reasons: FPU emulation,
> Framebuffer console updates, and compression/decompression of flash data
> for jffs2.
> 
> Moreover, if I read these traces correctly, they just disable
> preemption, but still allow interrupts. Is that correct? Can anything be
> done against these latencies, i.e. do they really need to disable
> preemption for such a long time?
> 
> However, traces 1, 2, 6 and 7 are completely mysterious to me.
> Interrupts seem to be blocked for milliseconds, while nothing is going
> on on the system? Moreover, there are console-related function names in
> traces 6 and 7, although I've unconfigured the framebuffer console for
> these runs!
> 
> Many thanks in advance for any help!
> 
> Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-6301
> E-Mail: kus@keba.com
> www.keba.com
> 
> 

