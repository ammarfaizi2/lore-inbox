Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUBAFXx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBAFXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:23:53 -0500
Received: from waste.org ([209.173.204.2]:208 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265216AbUBAFXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:23:51 -0500
Date: Sat, 31 Jan 2004 23:23:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc3-tiny1 for small systems
Message-ID: <20040201052348.GW21888@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

Latest release includes:
 - update to 2.6.2-rc3
 - add latest netdrvr patchkit (Jeff Garzik)
 - numerous compile warning fixes from last release
 - work for compiling with gcc 3.4
 - smaller, cleaned up inflate code for kernel, initramfs, etc.
 - optional support for file locking
 - optional support for uid16 interfaces
 - enhanced CPU feature selection (Adrian Bunk)
 - selectable vendor support for MTRRs
 - optional TSC timer support
 - optional ramfs-based shmem/tmpfs support
 - minor space-saving cleanups

As always, I'm looking for more ideas for space-savings. Suggestions
in the TCP/IP area are especially useful right now.

Here's a test boot of my development config (console, ide, ext2, and
ipv4) with mem=2m, which is actually only 1664k after accounting for
BIOS memory holes:

Uncompressing Linux... Ok, booting the kernel.
# mount /proc
# cat /proc/meminfo
MemTotal:          980 kB [up from 916k for last release!]
MemFree:           312 kB
Buffers:            32 kB
Cached:            296 kB
SwapCached:          0 kB
Active:            400 kB
Inactive:           48 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:          980 kB
LowFree:           312 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            380 kB
Slab:                0 kB
Committed_AS:      132 kB
PageTables:         24 kB
VmallocTotal:  1032172 kB
VmallocUsed:         0 kB
VmallocChunk:  1032172 kB
#

The patch can be found at:

 http://selenic.com/tiny/2.6.2-rc3-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.2-rc3-tiny1-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
