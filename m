Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVL3Gfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVL3Gfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 01:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVL3Gfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 01:35:33 -0500
Received: from general.keba.co.at ([193.154.24.243]:17706 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751193AbVL3Gfc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 01:35:32 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Date: Fri, 30 Dec 2005 07:35:25 +0100
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <AAD6DA242BC63C488511C611BD51F367323308@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYMpTqeYxmA6vcNSVGWvqQKVmOH9wAZaDdQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: <mingo@elte.hu>, "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> On Thu, 2005-12-29 at 16:08 +0100, kus Kusche Klaus wrote:
> > I took some latency traces on our sa1100 (see attachment) running
> > 2.6.15-rc7-rt1 with full preemption.
> > They look very bad at the first glance, but I cannot 
> interpret them in
> > detail.
> > 
> > Trace 3, 4 and 5 seem to have obvious reasons: FPU emulation,
> > Framebuffer console updates, and compression/decompression 
> of flash data
> > for jffs2.
> > 
> > Moreover, if I read these traces correctly, they just disable
> > preemption, but still allow interrupts. Is that correct? 
> Can anything be
> > done against these latencies, i.e. do they really need to disable
> > preemption for such a long time?
> > 
> > However, traces 1, 2, 6 and 7 are completely mysterious to me.
> > Interrupts seem to be blocked for milliseconds, while 
> nothing is going
> > on on the system? Moreover, there are console-related 
> function names in
> > traces 6 and 7, although I've unconfigured the framebuffer 
> console for
> > these runs!
> 
> Do you have any power management features turned on?
> 
> I've seen some traces that look like this on buggy intel x86 hardware.
> When a small two line function with no loops lasts for 10ms . One of
> your traces showed irq_exit() lasting 9ms . It's like the process just
> stops.

No, no power management at all.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
