Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSKZAaV>; Mon, 25 Nov 2002 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSKZAaV>; Mon, 25 Nov 2002 19:30:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40374 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265819AbSKZAaU>; Mon, 25 Nov 2002 19:30:20 -0500
Date: Mon, 25 Nov 2002 16:30:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.47-mjb3 (scalability / NUMA patchset)
Message-ID: <19270000.1038270642@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been maintaining a patchset for internal use on and off
for a while, and have decided to publish it externally. It's 
based on 2.5.47 partly because I'm slow and boring, but also
because I don't particularly want anything from 49, and there's
some bleeding edge stuff in it I'd rather not cut myself on.

The patchset contains mainly scalability and NUMA stuff, and 
anything else that stops things from irritating me. It's meant 
to be pretty stable, not so much a testing ground for new stuff.
I'd be very interested in feedback from other people running 
large SMP or NUMA boxes.

Next additions will probably be timer fixes, moving NUMA-Q to
subarch, Summit support, and shared pagetables.

http://www.aracnet.com/~fletch/linux/2.5.47/patch-2.5.47-mjb3

kgdb						Various People
	The older version of kgdb, not the shiny new stuff in Andrew's tree.
	Yes, I'm boring and slow.

rcu_stats					Dipankar Sarma
	Gives rcu statistics

dcache_rcu					Dipankar Sarma
	Use read copy update locking for the directory entry cache

noearlyirq					Martin Bligh
	Don't allow irqs on secondary cpus during IO-APIC init until __cpu_up
	Else your machine may go belly up on boot.

i386_topo					Matt Dobson
	Some i386 topology cleanups to make it cache the data.

use_generic_topo				Matt Dobson
	Something to do with tolopology that I forget.

numasched1					Erich Focht
	Numa scheduler general foundation work + pooling

numasched2					Michael Hohnbaum
	Numa scheduler lightweight initial load balancing.

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

early_printk					Dave Hansen et al.
	Allow printk before console_init

frameptr					Martin Bligh
	Disable -fomit_frame_pointer

confighz					Dave Hansen
	Make HZ a config option

mjb3						Martin Bligh
	Add a tag to the makefile

