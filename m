Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTEOIuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTEOIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:50:20 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:48124 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263894AbTEOIuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:50:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16067.22472.306565.803037@gargle.gargle.HOWL>
Date: Thu, 15 May 2003 11:03:04 +0200
From: mikpe@csd.uu.se
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error
In-Reply-To: <20030514.221858.846957347.rene.rebe@gmx.net>
References: <20030513.213112.184808431.rene.rebe@gmx.net>
	<16066.15561.296849.757291@gargle.gargle.HOWL>
	<20030514.221858.846957347.rene.rebe@gmx.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
 > HI,
 > 
 > On: Wed, 14 May 2003 14:55:37 +0200,
 >     mikpe@csd.uu.se wrote:
 > 
 > >  > Those errors only seem to happen during high disk-io (SCSI or IDE).
 > >  > What specific meaning do those errors have? Are they dangerous?
 > > 
 > > They are defined in Intel's IA32 manual set, volume 3,
 > > "System Programming Guide", downloadable from developer.intel.com.
 > > 
 > > These errors mean that APIC bus messages are lost or have checksum errors.
 > > You don't say which kernel you're using or which chipset, but chances are
 > > your mobo's APIC bus is noisy.
 > > 
 > >  > Each CPU survives hours in memtest86 ... And with maxcpus=1 it also
 > >  > does not seem to happen ... The BIOS is latest.
 > > 
 > > You can try booting with "noapic", that should let you keep using SMP
 > > while avoiding your possibly buggy APIC bus.
 > 
 > Thanks for the anwer I googled for this before the mail but only found
 > much noise ... I'll triy noapic (I thought this would disable SMP,
 > too), but I already had to notice that with maxcpus=1 I also get some
 > few APIC errors.
 > 
 > Is there drawback in using noapic in SMP mode?

No load balancing of I/O interrupts since they will all be directed to
CPU 0 only. Unless your dual P5 is servicing a lot of interrupts, I doubt
it will make a noticeable difference.
