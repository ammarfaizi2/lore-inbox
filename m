Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSKAIp1>; Fri, 1 Nov 2002 03:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSKAIp1>; Fri, 1 Nov 2002 03:45:27 -0500
Received: from dp.samba.org ([66.70.73.150]:38376 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265670AbSKAIpU>;
	Fri, 1 Nov 2002 03:45:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, davej@suse.de
Subject: Rusty's Remarkably Unreliable List of Pending 2.6 Features
Date: Fri, 01 Nov 2002 19:49:58 +1100
Message-Id: <20021101085148.E105A2C06A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm down to 8 undecided features: 6 removed and one I missed earlier.

	http://www.kernel.org/pub/linux/kernel/people/rusty/2.6-not-in-yet
(Reproduced below.)

Removed ("vendor-driven" == "no", for purposes of the freeze)
	Linux Trace Toolkit: "no"
	statfs64: noone seems to be pushing
	ext2/3 ACLs & EA: included
	Crash Dumper: "no"
	Hi-res Timers: "no"
	SCSI and FibreChannel Hotswap: "via. maintainers but probably not"

Added:
	Nanosecond Time Patch

Linus, are you going to appoint [davej] someone [davej] to help you
[davej] hold the freeze?  It'd be nice if someone [davej] else had to
pre-approve or co-approve patches before they went in.

I don't really care who the somebody [davej] is.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Entrance criteria:

    * Must have been submitted to lkml in the last month,
    * Hasn't been rejected by the maintainer/Linus,
    * Not appropriate for insertion during stable series (ie. too invasive, new feature, breaks userspace)

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
S: 841 kbytes, 290/48 files altered, 22 new
T: Diffstat
X: Summary patch (597k)
N: Requires new modutils

Nanosecond Time Patch
A: Andi Kleen
M: http://www.ussg.iu.edu/hypermail/linux/kernel/0210.3/0793.html
D: ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec-2.5.44-2.bz2
S: 194 kbytes, 158/0 files altered, 0 new
T: Diffstat
X: Summary patch (181k)
N: The core of this patch is tiny: putting nanoseconds into filesystems is the bulk of this patch.

Fbdev Rewrite
A: James Simmons
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/1267.html
D: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
S: 2320 kbytes, 131/20 files altered, 40 new
T: Diffstat
X: Summary patch (401k)

ucLinux Patch (MMU-less support)
A: Greg Ungerer
M: http://lwn.net/Articles/11016/
D: http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc1.patch.gz
S: 2202 kbytes, 25/13 files altered, 427 new
T: Diffstat
X: Summary patch (43k)
N: Linus said looks good.

POSIX Timer API
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-posix-2.5.45-1.0.patch
S: 66 kbytes, 18/1 files altered, 4 new
T: Diffstat
X: Summary patch (21k)

Hotplug CPU Removal Support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
S: 32 kbytes, 16/0 files altered, 0 new
T: Diffstat
X: Summary patch (29k)

initramfs
A: Al Viro / Jeff Garzik
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
D: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21
S: 16 kbytes, 5/1 files altered, 2 new
T: Diffstat
X: Summary patch (5k)
N: Linus says he wants it.

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz
S: 18 kbytes, 3/3 files altered, 4 new
T: Diffstat
X: Summary patch (5k)
