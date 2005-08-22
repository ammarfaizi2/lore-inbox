Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVHVWMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVHVWMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVHVWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57990 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751266AbVHVWLu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KLer/YJwVjP1jL7kxNeEvmSpoOvOeeMWQuH3mH6tUWwXVCV6YE+QLZP6Mfg/TDVHFeBwhxbE82mwMaVR2D23+UWZwKu/GfowEKpE117LlbJ6HLBl0K47KE+DyX6A6jFWbnYc3lS4ZtNtOfAwPTsQ7JTgJ9t/yBBNz+kMQELkjFY=
Message-ID: <5a2cf1f60508220421d0914f8@mail.gmail.com>
Date: Mon, 22 Aug 2005 13:21:20 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cache regresions with 2.6.1x ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am on a Dell Inspiron 8100 laptop with 512 M and 1G disk cache. I
usually have at least 4 big applications running simultaneously: a
Java IDE, firefox, firefox and X. All that under the Gnome desktop.

I've sometimes seen periods where my laptop goes kind of nuts. While
the cpu is still at 0%, the workload goes to 100% (as shown in the
gnome process monitor) (I haven't checked in other means, e.g. top or
/proc info as my machine is unusable).

But with my latest upgrade to 2.6.12 from 2.6.10, the hanging happens
much more often. It lasts for over 30 seconds.

Could this hanging be related to swapping?
Are there any VM regression lately that would make a kernel less
appropriate for desktop use?
How can I investigate that further?

Thanks

> cat /proc/meminfo 
MemTotal:       516220 kB
MemFree:         17720 kB
Buffers:          9412 kB
Cached:          67404 kB
SwapCached:     149584 kB
Active:         423072 kB
Inactive:        37860 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       516220 kB
LowFree:         17720 kB
SwapTotal:      976712 kB
SwapFree:       487432 kB
Dirty:             520 kB
Writeback:           0 kB
Mapped:         405256 kB
Slab:            22600 kB
CommitLimit:   1234820 kB
Committed_AS:  1793068 kB
PageTables:       3564 kB
VmallocTotal:   507896 kB
VmallocUsed:     26472 kB
VmallocChunk:   481268 kB


> fdisk -l /dev/hda

Disk /dev/hda: 60.0 GB, 60011642880 bytes
16 heads, 63 sectors/track, 116280 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1       19376     9765472+   7  HPFS/NTFS
Partition 1 does not end on cylinder boundary.
/dev/hda2           19377      116280    48839616    5  Extended
Partition 2 does not end on cylinder boundary.
/dev/hda5           19377       21314      976720+  82  Linux swap / Solaris
/dev/hda6           21315       29064     3905968+  83  Linux
/dev/hda7           29065       36814     3905968+  83  Linux
/dev/hda8           36815      116280    40050832+  83  Linux
expresso:/home/jerome/Dev/CruiseControl/cruisecontrol#
