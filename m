Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUAJVot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUAJVot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:44:49 -0500
Received: from waste.org ([209.173.204.2]:15507 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265470AbUAJVom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:44:42 -0500
Date: Sat, 10 Jan 2004 15:44:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.1-tiny1 tree for small systems
Message-ID: <20040110214437.GL18208@waste.org>
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
 - update to 2.6.1
 - add latest netdrvr patchkit (Jeff Garzik)
 - various compile fixes for last release
 - various tweaks to netpoll, netconsole, and kgdb-over-ethernet
 - laptop mode (Bart Samwel via -mm)
 - optional block device layer (Eric Biederman)
 - optional simple boot flag (Zwane Mwaikambo)
 - optional ksyms (Zwane Mwaikambo)
 - optional PCI quirk detection (Zwane Mwaikambo)
 - free early bootstrap code (Zwane Mwaikambo)
 - optional direct IO support
 - optional minimal lockless mempool
 - minor cleanups

Here's a test boot of my development config (console, ide, ext2, and
ipv4) with mem=2m, which is actually only 1664k after accounting for
BIOS memory hole:

Uncompressing Linux... Ok, booting the kernel.
# mount /proc
# cat /proc/meminfo
MemTotal:          916 kB
MemFree:           296 kB
Buffers:            28 kB
Cached:            252 kB
SwapCached:          0 kB
Active:            324 kB
Inactive:           76 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:          916 kB
LowFree:           296 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            316 kB
Slab:                0 kB
Committed_AS:      132 kB
PageTables:         24 kB
VmallocTotal:  1032168 kB
VmallocUsed:         0 kB
VmallocChunk:  1032168 kB
#

The patch can be found at:

 http://selenic.com/tiny/2.6.1-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.1-tiny1-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
