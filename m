Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTEOJ44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbTEOJ44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:56:56 -0400
Received: from hexagon.stack.nl ([131.155.140.144]:45061 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id S263930AbTEOJ4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:56:55 -0400
Date: Thu, 15 May 2003 12:09:38 +0200 (CEST)
From: Jos Hulzink <josh@toad.stack.nl>
To: mikpe@csd.uu.se
Cc: Rene Rebe <rene.rebe@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: APIC error
In-Reply-To: <16067.22472.306565.803037@gargle.gargle.HOWL>
Message-ID: <20030515120614.R94113@toad.stack.nl>
References: <20030513.213112.184808431.rene.rebe@gmx.net>
 <16066.15561.296849.757291@gargle.gargle.HOWL> <20030514.221858.846957347.rene.rebe@gmx.net>
 <16067.22472.306565.803037@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003 mikpe@csd.uu.se wrote:

> Rene Rebe writes:
>  > HI,
>  >
>  > On: Wed, 14 May 2003 14:55:37 +0200,
>  >     mikpe@csd.uu.se wrote:
>  >
>  > >  > Those errors only seem to happen during high disk-io (SCSI or IDE).
>  > >  > What specific meaning do those errors have? Are they dangerous?
>  > >
>  > > They are defined in Intel's IA32 manual set, volume 3,
>  > > "System Programming Guide", downloadable from developer.intel.com.
>  > >
>  > > These errors mean that APIC bus messages are lost or have checksum errors.
>  > > You don't say which kernel you're using or which chipset, but chances are
>  > > your mobo's APIC bus is noisy.
>  > >
>  > >  > Each CPU survives hours in memtest86 ... And with maxcpus=1 it also
>  > >  > does not seem to happen ... The BIOS is latest.
>  > >
>  > > You can try booting with "noapic", that should let you keep using SMP
>  > > while avoiding your possibly buggy APIC bus.
>  >
>  > Thanks for the anwer I googled for this before the mail but only found
>  > much noise ... I'll triy noapic (I thought this would disable SMP,
>  > too), but I already had to notice that with maxcpus=1 I also get some
>  > few APIC errors.
>  >
>  > Is there drawback in using noapic in SMP mode?
>
> No load balancing of I/O interrupts since they will all be directed to
> CPU 0 only. Unless your dual P5 is servicing a lot of interrupts, I doubt
> it will make a noticeable difference.

On my Dual PII 333, KDE 3.1 runs fine with interrupts mapped to both CPUs,
and performance is horrible when only CPU0 receives the interrupts.

Especially moving the timer interrupt to both CPUs makes difference like
night and day.

Jos
