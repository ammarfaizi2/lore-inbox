Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423005AbWJSFET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423005AbWJSFET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWJSFET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:04:19 -0400
Received: from ozlabs.org ([203.10.76.45]:3714 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1423005AbWJSFES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:04:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
Date: Thu, 19 Oct 2006 15:03:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> Here is patch to add some printk to try to figure out what is going on. 
> Run with this and send me the console output leading up to the failure.

Here...  Thanks for your help on this.  I'll poke a bit further.

Linux version 2.6.19-rc2-test (paulus@drongo) (gcc version 4.1.2 20060928 (prerelease) (Debian 4.1.1-15)) #37 SMP Thu Oct 19 14:05:18 EST 2006
[boot]0012 Setup Arch
No ramdisk, default root is /dev/sda2
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 7168 bytes
Zone PFN ranges:
  DMA             0 ->   524288
  Normal     524288 ->   524288
early_node_map[3] active PFN ranges
    1:        0 ->    32768
    0:    32768 ->   278528
    1:   278528 ->   524288
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 513760
Kernel command line: root=/dev/sdc3
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 2046852k/2097152k available (5512k kernel code, 65056k reserved, 2204k data, 554k bss, 256k init)
Get cache descritor
__cache_alloc
__cache_alloc_node 0
fallback_alloc
__cache_alloc_node 0
__cache_alloc_node 1
kernel BUG in __cache_alloc_node at /home/paulus/kernel/powerpc/mm/slab.c:3185!
