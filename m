Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCVXKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCVXKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:10:38 -0500
Received: from pop.gmx.net ([213.165.64.20]:64220 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261418AbUCVXKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:10:20 -0500
X-Authenticated: #20450766
Date: Tue, 23 Mar 2004 00:09:16 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <Robert_Hentosh@Dell.com>,
       <fleury@cs.auc.dk>, <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.53.0403221701460.24245@chaos>
Message-ID: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Richard B. Johnson wrote:

> On Mon, 22 Mar 2004, Guennadi Liakhovetski wrote:
>
> >            CPU0 (2nd shot)
> >   0:      36557  37638 +1081 XT-PIC  timer
> >   1:         59     65    +6 XT-PIC  i8042
> >   2:          0      0       XT-PIC  cascade
> >   5:          0      0       XT-PIC  VIA686A
> >   8:          3      3       XT-PIC  rtc
> >   9:          0      0       XT-PIC  acpi, uhci_hcd, uhci_hcd
> >  10:          0      0       XT-PIC  eth0
> >  12:         84     84       XT-PIC  i8042
> >  14:       1910   1918    +8 XT-PIC  ide0
> >  15:          1      1       XT-PIC  ide1
> > NMI:         18     18
> > LOC:      36460  37541 +1081
> > ERR:         36     57   +21
>
> First, you are using the 8259A (XT-PIC). This means you have
> IO-APIC turned off (or it doesn't exist).

I know. I never said there was one. I said, that the local APIC is used
for timer interupts - at least, this is how I interpret

Using local APIC timer interrupts.
calibrating APIC timer ...

Am I missing anything trivial?

> > ide0 + i8042 (keyboard) = 14, whereas errors increased by 21. So, if you
> > are right, than Alan's wrong (or my understanding of his statement), and
> > those spurious interrupts occur not only after real ones, or, one real
> > interrupt can produce several spurious ones.
>
> Neither. They are not related. As previously stated, a spurious
> interrupt occurs when the CPU INT line becomes active, but no
> interrupt controller caused it to happen. It's just that simple.

Yes, I saw this your explanation. Thanks again. But, I am not getting
those errors with local APIC disabled. That's why I thought "local APIC ->
timer -> spurious interrupts." Maybe I am wrong. But I also can't see how
enabling the lapic can cause, e.g., power supply glitches to become
visible. I would be happy and grateful to hear an explanation.

Thanks
Guennadi
---
Guennadi Liakhovetski


