Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBMWyB>; Tue, 13 Feb 2001 17:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129246AbRBMWxm>; Tue, 13 Feb 2001 17:53:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30889 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129243AbRBMWxc>; Tue, 13 Feb 2001 17:53:32 -0500
Date: Tue, 13 Feb 2001 17:52:48 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.1-ac11  swap problems
Message-ID: <Pine.LNX.4.33.0102131744020.2104-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1-ac10 works fine (I had it up 24 hours before, and am again running
it).

Shortly after boot on 2.4.1-ac11, I get a ration of these:
  kernel: Unused swap offset entry in swap_count 0015fb04
looks like its going through most of the swap space...
Then this comes out:
  kernel: Unused swap offset entry in swap_count 001dd904
  kernel: Unused swap offset entry in swap_dup 001dd904
  kernel: VM: Bad swap entry 001dd904
  kernel: VM: Bad swap entry 001dd904
  kernel: Unused swap offset entry in swap_count 001dd904

after some more messages, the 001dd904 address is repeated again
Eventually, some processes get killed:
  kernel: VM: killing process wmsetbg
  kernel: VM: killing process X

Ver_Linux reports thusly:
Linux badlands.lexington.ibm.com 2.4.1-ac10 #5 Mon Feb 12 10:59:36 EST
2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10q
modutils               2.4.1
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc ipx af_packet netlink_dev
softdog msr cpuid microcode olympic dummy0 usbcore maestro3 soundcore
ac97_codec ipchains eeprom sensors i2c-viapro i2c-core agpgart ipv6 unix

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

