Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281634AbRKMO3p>; Tue, 13 Nov 2001 09:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKMO3f>; Tue, 13 Nov 2001 09:29:35 -0500
Received: from mustard.heime.net ([194.234.65.222]:53209 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281635AbRKMO3Q>; Tue, 13 Nov 2001 09:29:16 -0500
Date: Tue, 13 Nov 2001 15:29:13 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
cc: <lars.nakkerud@compaq.com>
Subject: Tuning Linux for high-speed disk subsystems
Message-ID: <Pine.LNX.4.30.0111131519440.933-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After some testing at Compaq's lab in Oslo, I've come to the conclusion
that Linux cannot scale higher than about 30-40MB/sec in or out of a
hardware or software RAID-0 set with several stripe/chunk sizes tried out.
The set is based on 5 18GB 10k disks running SCSI-3 (160MBps) alone on a
32bit/33MHz PCI bus.

After speking to the storage guys here, I was told the problem generally
was that the OS should send the data requests at 256kB block sizes, as the
drives (10k) could handle 100 I/O operations per second, and thereby could
give a total of (256*100)kB/sec per spindle. When using smaller block
sizes, the speed would decrease in a linear fasion.

Does anyone know this stuff good enough to help me how to tune the system?
PS: The CPUs were almost idle during the test. Tested file system was
ext2.

Regards

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


