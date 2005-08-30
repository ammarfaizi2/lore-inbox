Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVH3JhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVH3JhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVH3JhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:37:06 -0400
Received: from styx.suse.cz ([82.119.242.94]:20945 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751318AbVH3JhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:37:05 -0400
Date: Tue, 30 Aug 2005 11:37:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>
Subject: APs from the Kernel Summit run Linux
Message-ID: <20050830093715.GA9781@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The D-Link DWL-G730AP devices from the Kernel Summit run Linux, And it's
likely a GPL violation, too, since sources are nowhere to be found.

They're based on a Marvell Libertas AP-32 (ARM9) design, similar
to the ASUS WL-530g. A bootlog from the ASUS (which has telnet enabled
for some reason, and thus can be logged in) is at the end of the mail.

A firmware image is available from D-Link ([URL removed]) and it seems
to be composed of compressed blocks padded by zeroes. I haven't verified
yet that it's indeed a compressed kernel, cramfs, etc, but it seems
quite likely.

Anyone interested in dissecting it, and pushing D-Link/Marvell to release
the kernel sources? I'd love to get more out of this cute device ...

Linux version 2.4.22-uc0 (root@localhost.localdomain)
	(gcc version 2.95.3 20010315 (release)
	(ColdFire patches - 20010318 from [URL removed])
	(uClinux XIP and shared lib patches from [URL removed]))
	#1369 Wed Aug 18 21:32:58 CDT 2004
Processor: ARM Arm946id(wb) revision 1
Architecture: MV88W85x0
On node 0 totalpages: 4032
zone(0): 0 pages.
zone(1): 4032 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,38400 root=/dev/mtdblock1 ro rootfstype=cramfs
Calibrating delay loop... 87.85 BogoMIPS
Memory: 15MB = 15MB total
Memory: 14616KB available (1045K code, 227K data, 48K init)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x8000c840 (irq = 11) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 2048K size 1024 blocksize
PPP generic driver version 2.4.2
PPP MPPE compression module registered
PPP Deflate Compression module registered
PPP BSD Compression module registered
Marvell Libertas AP-32 flash mapping: 400000 at ffc00000
Marvell Libertas AP-32: Found 1 x16 devices at 0x0 in 16-bit mode
 Amd/Fujitsu Extended Query Table at 0x0040
Marvell Libertas AP-32: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Creating 4 MTD partitions on "Marvell Libertas AP-32":
0x00000000-0x00380000 : "Libertas AP-32 compressed kernel"
0x000a0000-0x00380000 : "Libertas AP-32 romfs root file system"
0x00380000-0x003d0000 : "Libertas AP-32 jffs2 file system"
0x003d0000-0x003e0000 : "Libertas AP-32 manufacture data"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
ip_conntrack version 2.1 (126 buckets, 1008 max) - 320 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_time loading
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
Bridge firewalling registered
VFS: Mounted root (cramfs filesystem) readonly.
Freeing init memory: 48K
name: Libertas AP-32 compressed kernel
name: Libertas AP-32 romfs root file system
name: Libertas AP-32 jffs2 file system
ip_conntrack_pptp.c:init: ip_conntrack_pptp.c: registering helper
ip_conntrack_pptp version 1.9 loaded
ASSERT ip_conntrack_core.c:630 &ip_conntrack_lock not readlocked
ip_nat_pptp version 1.5 loaded
QD initiated
mvWLAN_crypt: registered algorithm 'WEP'
mvWLAN_crypt: registered algorithm 'TKIP'
mvWLAN_hw_init()
mvWLAN: Registered netdevice wlan0
wlan0: enabling hostapd mode
wlan0: Registered netdevice wlan0ap for AP management
wlan0: Registered netdevice wlan0sta for STA use
wlan0: mvWLAN_open
wlan0ap: mvWLAN_open
device LAN entered promiscuous mode
device wlan0 entered promiscuous mode
wlan0: attempt to add interface with same source address.

More details on the WL-530g are available at: [URL removed]

PS. I already tried to send this mail twice, but something ate it. I've
removed the URLs this time, hopefully that was the reason the spam
filter at LKML didn't like it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
