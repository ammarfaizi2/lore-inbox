Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSJ2AYn>; Mon, 28 Oct 2002 19:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJ2AYn>; Mon, 28 Oct 2002 19:24:43 -0500
Received: from dp.samba.org ([66.70.73.150]:16550 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261740AbSJ2AYb>;
	Mon, 28 Oct 2002 19:24:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: UPDATED: Rusty's Remarkably Unreliable 2.6 List
Date: Tue, 29 Oct 2002 11:30:12 +1100
Message-Id: <20021029003052.A439F2C099@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches which have been submitted to lkml in the last month or so,
are not suitable for post-freeze, and have not been rejected yet:

  http://www.kernel.org/pub/linux/kernel/people/rusty/2.6-not-in-yet/

Ordered from most invasive to least.  (Yay!  I win!).

In the vain hope that Linus will announce a shortlist for consideration,
Rusty.
PS.  Reproduced below.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

================
Rusty's Remarkably Unreliable List of Pending 2.6 Features
[aka. Rusty's Snowball List]

Hi. I'm bitter because my module rewrite didn't get in earlier, so now
I'm spending some effort to ensure that there's a one-stop list of
patches which might go into 2.6, making it easier to review, argue,
and ideally allow Linus to decide what is to be considered for the
freeze.

Entrance criteria:

    * Must have been submitted to lkml in the last month,
    * Hasn't been rejected by the maintainer/Linus,
    * Not appropriate for insertion during stable series (ie. too
      invasive, new feature, breaks userspace)

Key:
A: Author
M: lkml posting describing patch
D: Download URL
S: Size of patch, number of files altered (source/config), number of new files.
X: Impact summary (only parts of patch which alter existing source files, not config/make files)
T: Diffstat of whole patch
N: Random notes

In rough order of invasiveness (number of altered source files):

In-kernel Module Loader and Unified parameter support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
S: 749 kbytes, 246/26 files altered, 22 new
T: Diffstat
X: Summary patch (531k)
N: Requires new modutils

Fbdev Rewrite
A: James Simmons
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/1267.html
D: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
S: 4852 kbytes, 168/29 files altered, 124 new
T: Diffstat
X: Summary patch (182k)

Linux Trace Toolkit (LTT)
A: Karim Yaghmour
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
D: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021026-2.2.bz2
S: 257 kbytes, 67/4 files altered, 9 new
T: Diffstat
X: Summary patch (90k)

statfs64
A: Peter Chubb
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103490436228016&w=2
D: http://marc.theaimsgroup.com/?l=linux-kernel&m=103490436228016&w=2
S: 42 kbytes, 53/0 files altered, 1 new
T: Diffstat
X: Summary patch (32k)

ext2/ext3 ACLs and Extended Attributes
A: Ted Ts'o
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
B: bk://extfs.bkbits.net/extfs-2.5-update
D: http://thunk.org/tytso/linux/extfs-2.5/
S: 247 kbytes, 48/17 files altered, 17 new
T: Diffstat
X: Summary patch (82k)

Kernel Config
A: Roman Zippel
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
D: http://www.xs4all.nl/%7Ezippel/lc/lkc-1.2-2.5.44.diff.bz2
S: 2164 kbytes, 0/3 files altered, 178 new
T: Diffstat
X: Summary patch (7k)

ucLinux Patch (MMU-less support)
A: Greg Ungerer
M: http://lwn.net/Articles/11016/
D: http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc3.patch.gz
S: 2218 kbytes, 25/34 files altered, 429 new
T: Diffstat
X: Summary patch (40k)

Crypto API
A: James Morris
S: 141 kbytes, 21/6 files altered, 14 new
N: In Dave Miller's tree for IPSec support.

Crash Dumping (LKCD)
A: Matt Robinson, LKCD team
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/8552.html
D: http://lkcd.sourceforge.net/download/latest/
S: 18479 kbytes, 18/10 files altered, 10 new
T: Diffstat
X: Summary patch (18k)

POSIX Timer API
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-posix-2.5.44-1.0.patch
S: 66 kbytes, 18/2 files altered, 4 new
T: Diffstat
X: Summary patch (21k)

Hotplug CPU Removal Support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
S: 32 kbytes, 16/0 files altered, 0 new
T: Diffstat
X: Summary patch (29k)

Hires Timers
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103557676007653&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103557677207693&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103558349714128&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-core-2.5.44-1.0.patch http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-i386-2.5.44-1.0.patch http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-hrposix-2.5.44-1.1.patch
S: 132 kbytes, 15/4 files altered, 10 new
T: Diffstat
X: Summary patch (44k)
N: Requires POSIX Timer API patch

epoll System Call
A: Davide Libenze
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6419.html
D: http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.11.diff
S: 47 kbytes, 11/2 files altered, 4 new
T: Diffstat
X: Summary patch (9k)

Device Mapper (LVM2)
A: LVM2 Team
M: http://www.sistina.com/products_lvm.htm
D: http://people.sistina.com/~thornber/patches/2.5-stable/
S: 88 kbytes, 10/5 files altered, 9 new
T: Diffstat
X: Summary patch (6k)
N: In -ac kernels

EVMS
A: EVMS Team
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0109.html
D: http://evms.sourceforge.net/patches/2.5.44/
S: 1101 kbytes, 7/10 files altered, 44 new
T: Diffstat
X: Summary patch (4k)

initramfs
A: Al Viro
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
D: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21
S: 16 kbytes, 5/1 files altered, 2 new
T: Diffstat
X: Summary patch (5k)

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz
S: 17 kbytes, 3/4 files altered, 4 new
T: Diffstat
X: Summary patch (4k)
