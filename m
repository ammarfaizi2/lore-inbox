Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268869AbTBZTpW>; Wed, 26 Feb 2003 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268876AbTBZTpW>; Wed, 26 Feb 2003 14:45:22 -0500
Received: from mail2.linuxis.net ([64.71.140.142]:48583 "HELO
	moria.linuxis.net") by vger.kernel.org with SMTP id <S268869AbTBZTpU>;
	Wed, 26 Feb 2003 14:45:20 -0500
Date: Wed, 26 Feb 2003 11:40:44 -0800
From: Adam McKenna <adam@flounder.net>
To: linux-kernel@vger.kernel.org
Subject: VM problems in 2.4.20
Message-ID: <20030226194043.GA14293@flounder.net>
Mail-Followup-To: Adam McKenna <adam@flounder.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a VM issue on one of my servers running 2.4.20.

The box reports the following:

adam@foxy:~$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  4041986048 3968524288 73461760        0 619249664 1551077376
Swap: 2001215488 171663360 1829552128
MemTotal:      3947252 kB
MemFree:         71740 kB
MemShared:           0 kB
Buffers:        604736 kB
Cached:        1494600 kB
SwapCached:      20124 kB
Active:        1632528 kB
Inactive:      2006628 kB
HighTotal:     3080176 kB
HighFree:        67324 kB
LowTotal:       867076 kB
LowFree:          4416 kB
SwapTotal:     1954312 kB
SwapFree:      1786672 kB

As you can see there is plenty of memory sitting in buffers/cache.  The
problem is that when our daily cronjobs run, the box starts swapping and the
load goes up to 30.  The cronjobs are just the normal system cronjobs like
updatedb, checksecurity, etc.

I had this problem a while ago with 2.4.6-xfs and 2.4.14-xfs, but this is 
stock 2.4.20 and I was under the impression that the VM was relatively OK by
now.

adam@foxy:~$ grep -i mem /boot/config-2.4.20
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
# Memory Technology Devices (MTD)
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_DEBUG_HIGHMEM is not set

Any suggestions?

Thanks,

--Adam
