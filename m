Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTIHJkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTIHJkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:40:53 -0400
Received: from [66.155.158.133] ([66.155.158.133]:7296 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S262290AbTIHJks convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:40:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       mathieu.desnoyers@polymtl.ca, mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, kernel 2.4.21-pre5 to 2.4.23-pre3
Date: Mon, 8 Sep 2003 06:40:10 -0400
User-Agent: KMail/1.4.3
References: <200309080933.h889X06U011447@harpo.it.uu.se>
In-Reply-To: <200309080933.h889X06U011447@harpo.it.uu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309080640.10149.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan 2460 Dual Athlon mobo running 2.4.21-ac, and it would reliably 
freeze (i.e., completely lock up with no error messages) under moderate PCI 
load (NFS, SMB, or disk-to-disk transfer).  I tried "noapic" with no 
improvement. I shifted to 2.4.22-ac and the problem went away.

On Monday 08 September 2003 05:33 am, Mikael Pettersson wrote:
> On Sun, 07 Sep 2003 18:37:48 -0400, Mathieu Desnoyers wrote:
> >IRQ problems with APIC enabled on a Neptune chipset, Pentium 90 SMP.
> >
> >Description
> >
> >Since kernel 2.4.21-pre2, IRQ problems are present on my Pentium 90 SMP,
> > wi= th
> >APIC enabled. It works well with 2.4.20 with APIC enabled, or with newer
> >kernels with "noapic" kernel option.
>
> There were a lot of I/O-APIC & MP table parsing changes in 2.4.21
> for clustered apic. Chances are something there broke on your
> ancient BIOS & mobo. I can't immediately see anything obviously
> broken in 2.4.21: you'll have to identify the first pre-patch where
> things broke and then test or revert it piece by piece.
>
> >On kernel 2.4.21-pre2, there is a kernel oops before this, with a
> >"Dereferencing NULL pointer".
>
> You didn't run that through ksymoops and post it, so how is anyone
> supposed to be able to debug it?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
