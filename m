Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTEGJzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbTEGJzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:55:13 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:29968 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263038AbTEGJzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:55:11 -0400
Message-ID: <3EB8DBA0.7020305@aitel.hist.no>
Date: Wed, 07 May 2003 12:10:40 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
References: <20030506232326.7e7237ac.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
light load.

Machine: 2.4GHz Pentium IV UP,
network card: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
video: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

Kernel config details:
UP, no module support, devfs, preempt, console on radeonfb

I got the OOPS this way:
boot normally (with X and network), switch to console
and log in, play nethack on the console until it oopses.
It will oops while in X too, but then there's nothing
visible to write down.

This is what I managed to write down. The first part scrolled
off screen with no scrollback - and no logfiles due to the
"not syncing" part:

<lost information>
ip_local_deliver
ip_local_deliver _finish
ip_recv_finish
ip_recv_finish
nf_hook_slow
ip_rcv_finish
ip_rcv
ip_rcv_finish
netif_receive_sub
process_backlog
net_rx_action
do_softirq
do_IRQ
default_idle
default_idle
common_interrupt
default_idle
default_idle
default_idle
cpu_idle
rest_init
start_kernel
unknown_bootoption
<0>Kernel panic: Fatal exception in interrupt
in interrupt handler - not syncing

Helge Hafting


