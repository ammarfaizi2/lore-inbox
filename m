Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbTE1K5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbTE1K5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:57:34 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:64012 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264663AbTE1K5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:57:31 -0400
Message-ID: <3ED49A14.2020704@aitel.hist.no>
Date: Wed, 28 May 2003 13:14:28 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm1 bootcrash, possibly IDE or RAID
References: <20030408042239.053e1d23.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.69-mm8 is fine, 2.5.67-mm1 dies before mounting anything read-write.

The early kernel boot is fine, the penguin appear,
a bunch of the usual messages scroll by too fast to read,
and then it hangs.

The kernel is UP, with preempt & devfs.  All filesystems
are ext2. This kernel has no module support.

Root is on raid-1, there are two
ide disks connected to this controller on separate cables:
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]

Here's the decoded crash, written down by hand:
<stuff scrolled off screen>
bio_endio
_end_that_request_first
ide_end_request
ide_dma_intr
ide_intr
ide_dma_intr
handle_IRQ_event
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
<0>Kwrnel Panic fatal exception in interrupt
in interrupt - not syncing

