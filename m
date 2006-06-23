Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWFWFen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFWFen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 01:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFWFen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 01:34:43 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:28918 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1750822AbWFWFen (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 01:34:43 -0400
Message-Id: <5.1.1.5.2.20060623152731.02656038@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 23 Jun 2006 15:34:41 +1000
To: Erik Mouw <erik@harddisk-recovery.com>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: Measuring tools - top and interrupts
Cc: linux-Kernel@vger.kernel.org
In-Reply-To: <20060622173128.GD14682@harddisk-recovery.com>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
 <20060622162141.GC14682@harddisk-recovery.com>
 <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

We have fixed this problem in the kernel 2.4.19 which has been installed in 
few selected computers of the "Middleware grid"
Sydney University.

Also load average has been calculated for each login user.

Thanks
Sena Seneviratne
Computer Engineering Lab
Sydney University




At 07:31 PM 6/22/2006 +0200, you wrote:
>On Thu, Jun 22, 2006 at 09:58:08AM -0700, Danial Thom wrote:
> > --- Erik Mouw <erik@harddisk-recovery.com> wrote:
> > > 75K packets/s isn't too hard for modern NICs,
> > > especially when using
> > > NAPI.
> >
> > Well thats just a ridiculous answer, so why
> > bother?
> >
> > You polling guys just crack me up. There isn't
> > much less work to be done with polling. The only
> > reason you THINK its less work is because the
> > measuring tools don't work properly. You still
> > have to process the same number of packets when
> > you poll, and you have polls instead of
> > interrupts. Since you can control the # of
> > interrupts with most cards, there is zero
> > advantage to polling, and more negatives.
>
>There certainly is less work to be done with polling. Less IRQs means
>less expensive context switches, which means a lower system load. See
>Documentation/NAPI_HOWTO.txt for information and a link to the Linux
>NAPI paper.
>
> > And 75K pps may not be "much", but its still at
> > least 10% of what the system can handle, so it
> > should measure around a 10% load. 2.4 measures
> > about 12% load. So the only conclusion is that
> > load accounting is broken in 2.6.
>
>Network traffic is usually IO bound, not CPU bound. The load figures
>top shows tell something about the amount of work the CPU has to do,
>not about how busy your PCI bus (or whatever bus the NIC lives on) is.
>
>IIRC the networking layer in 2.6 differs quite a lot from 2.4, so the
>load average figures can be quite misleading.
>
>
>Erik
>
>--
>+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
>| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

