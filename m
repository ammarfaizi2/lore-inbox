Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVHEWIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVHEWIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVHEWHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:07:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVHEWGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:06:18 -0400
Date: Fri, 5 Aug 2005 15:05:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X
 trouble.
Message-Id: <20050805150506.703e804f.akpm@osdl.org>
In-Reply-To: <20050805104025.GA14688@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	<20050805104025.GA14688@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> 2.6.13-rc5 seemed to kill a scsi disk (sdb) for me, where 2.6.13-rc4-mm1
> have no problems with the same disk.
> 
> Machine: opteron running a x86-64 kernel, with built-in SATA as well as
> a symbios scsi controller.  Two videocards running independent xservers.
> The sdb disk is on the symbios controller.
> 
> 
> Using 2.6.13-rc5 I suddenly got this in my logs:
> 
> Aug  3 22:06:00 tenkende-august -- MARK --
> Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: ABORT operation started.
> Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: ABORT operation timed-out.
> 
> ...
> This "no additiomnal sense" then repeats for many screenfulls.
> Two sdb partitions got dropped from RAID-1 as they failed, the
> md devices got remoutned read-only.
> 
> I thought the disk had died - it was my oldest so it'd be reasonable.
> Rebooting 2.6.13-rc5 did not bring the disk back - it came up useless again.
> 
> I switched back to 2.6.13-rc4-mm1 at this point for another reason,
> my X display aquired a nasty tendency to go blank for no reason during work,
> something I could fix by changing resolution baqck and forth.  X also tended to get
> stuck for a minute now and then - a problem I haven't seen since early 2.6.
> 
> These troubles disappeared by going back to 2.6.13-rc4-mm1.  Even more interesting,
> the sdb disk seems fine again.  There were no errors as I copied
> all data to another disk, and no errors when I ran a badblocks write-test
> (the nondestructive write test) on it. 
> 
> The two kernels have some config differences.  The 2.6.13-rc5 kernel
> has ACPI+CPUFREQ configured, that the 2.6.13-rc4-mm1 doesn't have.

That's a pretty big difference ;)

> ...
> I can run more tests, but don't know what would be the most interesting.
> rc5 without powermanagement?  rc4-mm1 with it? Or the newest git kernel?
> Or is this the effect of some known problem?

The latest -git kernel (or 2.6.13-rc6 if it's there) with APCI enabled is
the one to test, please.

