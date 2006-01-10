Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWAJPIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWAJPIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWAJPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:08:21 -0500
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:25828 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751108AbWAJPIU convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:08:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problem in booting UML with 2.6.8.1 kernel
Date: Tue, 10 Jan 2006 20:36:18 +0530
Message-ID: <4F36B0A4CDAD6F46A61B2B32C33DC69C019C3039@BLR-EC-MBX03.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem in booting UML with 2.6.8.1 kernel
Thread-Index: AcX5DIbHcB0LHa7sRlSJX0R5kThImAc5eCxg
From: <biswa.nayak@wipro.com>
To: <Linux-Kernel@vger.kernel.org>
Cc: <biswa.nayak@wipro.com>
X-OriginalArrivalTime: 10 Jan 2006 15:08:17.0787 (UTC) FILETIME=[AFD75CB0:01C615F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm trying to run a 2.6.8.1 um kernel on RHEL4.1 host with skas3.
When I start the kernel the boot messages get to "Mounted devfs on /dev"
and then UML is hung. 

I searched the mailing list and found that this was an old issue and by
changing the gcc flag to -O1 from -O2 the problem is solved, but in my
case nothing is happening.

Is there still a bug or did I screw something up? 

I'm starting the UML with:

% ./linux 

The bootlog is as below:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.8.1-1um (biswa@Bang-Automation-TS) (gcc version 3.4.3
20050227 (Red Hat 3.4.3-22.1)) #6 Tue Jan 10 19:35:44 IST 2006
Built 1 zonelists
Kernel command line: root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29176k available
Calibrating delay loop... 1356.59 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/biswa/.uml/eriepm/mconsole
UML Audio Relay (host dsp = /dev/sound/dsp, host mixer =
/dev/sound/mixer)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
PPP generic driver version 2.4.2
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
blkmtd: version $Revision: 1.23 $
blkmtd: error: missing `device' name

NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initializing software serial port version 1
 /dev/ubd/disc0: unknown partition table
Initializing stdio console driver
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev

And after this the UML hangs.

Thanks
Biswa
