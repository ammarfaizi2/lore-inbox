Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCGWuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCGWuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWCGWuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:50:37 -0500
Received: from grouper.library.colostate.edu ([129.82.28.139]:34576 "EHLO
	Grouper.Library.ColoState.EDU") by vger.kernel.org with ESMTP
	id S1750791AbWCGWug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:50:36 -0500
Message-ID: <440E0E25.80300@library.colostate.edu>
Date: Tue, 07 Mar 2006 15:50:13 -0700
From: Eric Hokanson <ehokanso@library.colostate.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Module loading errors on Alpha arch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2006 22:50:32.0117 (UTC) FILETIME=[89EC4650:01C64239]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently given a Compaq AlphaServer ES40 to play with and decided 
to throw a Linux distro on it.  I chose CentOS 4.2 and managed to get it 
installed and running.  Seems to run great and I am impressed with its 
speed but I am having problems loading a couple modules.  When I try to 
start the firewall and load iptables I get:

Feb  2 16:05:56 alphacrow kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb  2 16:05:56 alphacrow kernel: Could not allocate 60 bytes percpu data
Feb  2 16:05:56 alphacrow modprobe: WARNING: Error inserting ip_conntrack
(/lib/modules/2.6.9-22.0.2.ECsmp/kernel/net/ipv4/netfilter/ip_conntrack.ko):
Cannot allocate memory
Feb  2 16:05:56 alphacrow kernel: ipt_state: Unknown symbol ip_conntrack_untracked
Feb  2 16:05:56 alphacrow kernel: ipt_state: Unknown symbol need_ip_conntrack
Feb  2 16:05:56 alphacrow modprobe: FATAL: Error inserting ipt_state
(/lib/modules/2.6.9-22.0.2.ECsmp/kernel/net/ipv4/netfilter/ipt_state.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
Feb  2 16:05:56 alphacrow iptables:  failed

I get a similar message with the ipv6 module:
Mar  1 16:06:15 alphacrow kernel: Could not allocate 8 bytes percpu data
Mar  1 16:06:15 alphacrow modprobe: FATAL: Error inserting ipv6 (/lib/modules/2.6.15.4/kernel/net/ipv6/ipv6.ko): Cannot allocate memory

As you can see I have tried both the CentOS kernel and building my own 2.6.15.4 kernel.  Any ideas on how to
solve this problem would be great.

cpu                     : Alpha
cpu model               : EV67
cpu variation           : 7
cpu revision            : 0
cpu serial number       : AY00607688
system type             : Tsunami
system variation        : Clipper
system revision         : 0
system serial number    : 4051DPSZ1111
cycle frequency [Hz]    : 666666666
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 1305.32
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer ES40
cpus detected           : 2
cpus active             : 2
cpu active mask         : 0000000000000003
L1 Icache               : 64K, 2-way, 64b line
L1 Dcache               : 64K, 2-way, 64b line
L2 cache                : 8192K, 1-way, 64b line

MemTotal:      3095248 kB
MemFree:       2324784 kB
Buffers:         52592 kB
Cached:         587248 kB
SwapCached:          0 kB
Active:         437152 kB
Inactive:       245064 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      3095248 kB
LowFree:       2324784 kB
SwapTotal:      530128 kB
SwapFree:       530128 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          61320 kB
Slab:            72256 kB
Committed_AS:    52216 kB
PageTables:        904 kB
VmallocTotal:  8388608 kB
VmallocUsed:      5368 kB
VmallocChunk:  8382840 kB


Thanks,
Eric




