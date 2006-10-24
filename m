Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWJXRnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWJXRnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWJXRnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:43:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:36766 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161117AbWJXRnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:43:18 -0400
Subject: Re: PROBLEM: Oops when doing disk heavy disk I/O
From: Badari Pulavarty <pbadari@gmail.com>
To: Michael Sallaway <michael.sallaway@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9f916e540610240856p263d5s7098e4e2edd0ed25@mail.gmail.com>
References: <9f916e540610240856p263d5s7098e4e2edd0ed25@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 10:43:10 -0700
Message-Id: <1161711790.18096.29.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 01:56 +1000, Michael Sallaway wrote:
> [1.] One line summary of the problem:
> Kernel Oopses when doing I/O to a disk (using dd).
> 
> [2.] Full description of the problem/report:
> When writing to [any] disk (IDE or SCSI), the kernel will Oops after
> short periods of time ranging from 30 seconds to 5-10 minutes.
> Sometimes this is a complete crash (with "Aieee, killing interrupt
> handler!"), sometimes it's just an oops but the system doesn't crash
> comepletely (isn't very usable, though), and sometimes it just gives a
> "general protection fault: 0000 [1] SMP".
> 
> It's worth mentioning that I've managed to set up the entire system
> without incident -- a debian netinstall, downloading new packages,
> changing things, etc. The only reason I discovered this was when
> copying large amounts of data off another machine, and it died
> reproducably after a few gigabytes of data. (I originally thought it
> was an XFS issue, but had the same problem with EXT3, and all other
> combinations I tried - I can now reproduce it by using dd if=/dev/zero
> of=/dev/hda6.)
> 
> Ultimately, I've tried it with different (known good) devices and hard
> drives. The only common things between all failures are the CPU
> (Athlon 64 3200), Motherboard (Asus M2N-E), and RAM (2GB DDR2-533).
> (Memtest x86 shows the memory to be fine.) As such, I'm suspecting
> it's something to do with the motherboard -- It's using an x86_64
> kernel (although it does the same with an i386), on an nforce 570
> motherboard.
> 
> Other things I have tried:
> - SATA, SCSI and IDE drives -- all do the same thing
> - removing *all* drives and cards and devices -- it does it with a
> single IDE drive connected and no PCI cards
> - kernels 2.6.16, 18, 18.1, 19-rc3.

All of these kernels are having the same problem ? Or just noticed
it only in 19-rc3 ?

Thanks,
Badari

