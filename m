Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSJOWi4>; Tue, 15 Oct 2002 18:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265075AbSJOWhq>; Tue, 15 Oct 2002 18:37:46 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:23550
	"EHLO mx1.rackable.com") by vger.kernel.org with ESMTP
	id <S265093AbSJOWhK>; Tue, 15 Oct 2002 18:37:10 -0400
Message-ID: <3DAC9B73.9030102@rackable.com>
Date: Tue, 15 Oct 2002 15:49:23 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from illegal contex
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 22:42:53.0791 (UTC) FILETIME=[32ED06F0:01C2749C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Booting from an nfsroot I got this before the system grabbed an ip via 
kernel autoconfig dhcp.  Despite looking really bad it seems to function.

IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c011eef6>] __might_sleep+0x56/0x5d
 [<c0142c7f>] kmalloc+0x4f/0x310
 [<c029c5b2>] vsnprintf+0x2a2/0x420
 [<c0184d1a>] proc_create+0x7a/0xd0
 [<c0184e47>] proc_mkdir+0x17/0x40
 [<c010c0b9>] register_irq_proc+0x69/0xb0
 [<c0110000>] get_cmos_time+0x130/0x2a0
 [<c010be96>] setup_irq+0x166/0x170
 [<c031d6e0>] e100intr+0x0/0x2d0
 [<c010b6a4>] request_irq+0x84/0xa0
 [<c031c6cd>] e100_open+0x10d/0x1d0
 [<c031d6e0>] e100intr+0x0/0x2d0
 [<c010b19a>] handle_IRQ_event+0x3a/0x60
 [<c03d26a0>] dev_open+0x50/0xb0
 [<c03d3e2f>] dev_change_flags+0x4f/0x110
 [<c010511b>] init+0x8b/0x240
 [<c0105090>] init+0x0/0x240
 [<c0107039>] kernel_thread_helper+0x5/0xc

Sending DHCP requests .fix old protocol handler ic_bootp_recv+0x0/0x3a0!
,fix old protocol handler ic_bootp_recv+0x0/0x3a0!
 OK
IP-Config: Got DHCP answer from 10.10.1.5, my address is 10.10.2.122
IP-Config: Complete:


