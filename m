Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUG2Pge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUG2Pge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUG2PSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:18:05 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:4003 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id S267447AbUG2Oje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:39:34 -0400
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
References: <200407281050.24958.m.watts@eris.qinetiq.com>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 29 Jul 2004 09:39:29 -0500
In-Reply-To: <200407281050.24958.m.watts@eris.qinetiq.com>
Message-ID: <ufad62evpwe.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MW" == Mark Watts <m.watts@eris.qinetiq.com> writes:

MW> I have a 3Ware 8506-4LP controller with 4 250GB Maxtor SATA
MW> drives, in a raid-5 configuration (64K blocks) System is: Dual
MW> Opteron 246 (2GHz) 2GB RAM Tyan S2875 motherboard

I have a distantly similar configuration: 3ware 8506-4LP controller, 4
250GB Western Digital SATA drives, RAID5 (with one hot spare, so the
array is only 500GB), running dual 2.8GHz Xeon CPUs on a Supermicro
X5DPEG2 motherboard with 4GB of RAM.  The OS is Fedora Core 2 fully
updated; kernel is 2.6.6-1.435.2.3smp (which is basically 2.6.7rc3
plus security fixes).

IO is just glacial.  Things go well for a time but then everything
slows to a crawl.  The machine has very little load: a mostly inactive
NFS export, mysql running a few queries per second on a very small
database, that kind of thing.  Certainly the entire working set fits
easily into available RAM.

Yet on occasion it can take upwards of a minute just to ssh in.  This
machine took over half of the load from a poor 2GHz Athlon machine
with 1GB of RAM running Red Hat 7.2 and it feels far slower.

It took three seconds to run this:

> cat /proc/meminfo
MemTotal:      4155116 kB
MemFree:        211256 kB
Buffers:       3643760 kB
Cached:         129880 kB
SwapCached:          0 kB
Active:         284676 kB
Inactive:      3527304 kB
HighTotal:      163264 kB
HighFree:         3648 kB
LowTotal:      3991852 kB
LowFree:        207608 kB
SwapTotal:     8385920 kB
SwapFree:      8385920 kB
Dirty:             272 kB
Writeback:           0 kB
Mapped:          53464 kB
Slab:           111260 kB
Committed_AS:   263768 kB
PageTables:       4728 kB
VmallocTotal:   106488 kB
VmallocUsed:      6152 kB
VmallocChunk:    99996 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

I actually have several of these machines and can spare one for
testing.  If anyone has any suggestions, I'm happy to try them out.

MW> P.S. As I write this, I'm doing an sa-learn (spamassassin) over
MW> 14k messages and the system is a little sluggish even though
MW> gkrellm is only showing ~1MB/sec on the 3Ware, so I'm guessing
MW> these are just pants cards in general.

I have used 3ware cards extensively for many years now and have never
known them to be slow like this.  This configuration should easily be
able to saturate the drives (or the bus, whichever comes first).

 - J<
