Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUCaTPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUCaTPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:15:32 -0500
Received: from supermail.mweb.co.za ([196.2.53.171]:61454 "EHLO
	supermail.mweb.co.za") by vger.kernel.org with ESMTP
	id S262311AbUCaTPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:15:31 -0500
Date: Wed, 31 Mar 2004 21:16:20 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-Id: <20040331211620.19a8f725@bongani>
In-Reply-To: <20040331030921.GA2143@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 05:09:21 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> The xfs warning during truncate will be fixed with a later update
> (Nathan is currently working on it).
> 
> next thing to do is to fixup the merging in mprotect.
> 

I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of my memory was gone, but my swap was never touched. I managed to get only the output of SysRq-M before it hard-locked. For some reason it doesn't swap. I'll try to reproduce.

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty
Mar 31 06:48:12 bongani kernel:
Free pages:        2752kB (0kB HighMem)
Active:27927 inactive:1585 dirty:4 writeback:0 unstable:0 free:688
DMA free:1008kB min:28kB low:56kB high:84kB active:308kB inactive:256kB present:16384kB
Normal free:1744kB min:476kB low:952kB high:1428kB active:111400kB inactive:6084kB present:245696kB
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1008kB
Normal: 162*4kB 17*8kB 4*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1744kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       257000kB
65520 pages of RAM
0 pages of HIGHMEM
1579 reserved pages
19651 pages shared
