Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUHNTll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUHNTll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUHNTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:41:16 -0400
Received: from [213.4.129.150] ([213.4.129.150]:62334 "EHLO telesmtp3.mail.isp")
	by vger.kernel.org with ESMTP id S264923AbUHNThe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:37:34 -0400
Subject: Re: 2.6.8: IDE cdrecord problems
From: Emilio =?ISO-8859-1?Q?Jes=FAs?= Gallego Arias 
	<egallego@telefonica.net>
To: linux-kernel@vger.kernel.org
Cc: colin@colino.net, axboe@suse.de
Content-Type: text/plain
Date: Sat, 14 Aug 2004 21:38:16 +0200
Message-Id: <1092512296.5403.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20040814192211.312de2a2 () jack ! colino ! net>

Jack Colino wrote:

> Something quickly took all the memory and swap available, OOM started
> to kill things and the laptop got bogged down so much that I had to 
> reboot.
> Everything is fine with 2.6.8-rc2
> Excerpts of the syslog are attached. I started to burn at about 14:52,
> tried to login remotely at 15:27:47 (but ssh timed out).

Umm, interesting. I've had the same problem and I blamed the drive, but 
I've the same logs:

Aug  8 00:59:00 localhost kernel: oom-killer: gfp_mask=0xd2
Aug  8 00:59:01 localhost kernel: DMA per-cpu:
Aug  8 00:59:01 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Aug  8 00:59:01 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Aug  8 00:59:01 localhost kernel: Normal per-cpu:
Aug  8 00:59:01 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Aug  8 00:59:01 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Aug  8 00:59:01 localhost kernel: HighMem per-cpu: empty
Aug  8 00:59:01 localhost kernel:
Aug  8 00:59:01 localhost kernel: Free pages:        2396kB (0kB HighMem)
Aug  8 00:59:01 localhost kernel: Active:16513 inactive:407 dirty:0 writeback:0 unstable:0 free:599 slab:2859 mapped:16891 pagetables:686
Aug  8 00:59:01 localhost kernel: DMA free:1420kB min:20kB low:40kB high:60kB active:11880kB inactive:104kB present:16384kB
Aug  8 00:59:01 localhost kernel: protections[]: 10 360 360
Aug  8 00:59:03 localhost kernel: Normal free:976kB min:700kB low:1400kB high:2100kB active:54172kB inactive:1524kB present:507840kB
Aug  8 00:59:03 localhost kernel: protections[]: 0 350 350
Aug  8 00:59:03 localhost kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Aug  8 00:59:03 localhost kernel: protections[]: 0 0 0
Aug  8 00:59:03 localhost kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Aug  8 00:59:03 localhost kernel: Normal: 72*4kB 4*8kB 1*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 976kB
Aug  8 00:59:03 localhost kernel: HighMem: empty
Aug  8 00:59:03 localhost kernel: Swap cache: add 50405, delete 50305, find 1397/2028, race 0+0
Aug  8 00:59:03 localhost kernel: Out of Memory: Killed process 3004 (mysqld).

This log repeats for every cd i tried to burn.

Unfortunately I've no blank media until Monday I can go to the shop :) so 
will test a stock kernel soon.

Running:

ellugar:/var/log# uname -a
Linux ellugar 2.6.8-rc4 #48 Fri Aug 13 19:25:22 CEST 2004 i686 GNU/Linux

Debian unstable.

More info and testing on request.
Any changeset to revert?

Please cc me as I'm not subscribed to lkml.

Regards, Emilio


