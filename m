Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWHUMkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWHUMkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWHUMkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:40:37 -0400
Received: from galaxy.agh.edu.pl ([149.156.96.9]:45492 "EHLO galaxy.agh.edu.pl")
	by vger.kernel.org with ESMTP id S1751860AbWHUMkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:40:36 -0400
Message-ID: <44E9A9C0.6000405@agh.edu.pl>
Date: Mon, 21 Aug 2006 14:40:32 +0200
From: Andrzej Szymanski <szymans@agh.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
References: <44E0A69C.5030103@agh.edu.pl>	<ec19r7$uba$1@news.cistron.nl> <17641.3304.948174.971955@cse.unsw.edu.au>
In-Reply-To: <17641.3304.948174.971955@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Thursday August 17, miquels@cistron.nl wrote:
> 
> Can you report the contents of /proc/meminfo before, during, and after
> the long pause?
> I'm particularly interested in MemTotal, Dirty, and Writeback, but the
> others are of interest too.
> 
> Thanks,
> NeilBrown

I've prepared two logs, from different machines, the first one is on 
software RAID5 (4 ATA disks) with deadline scheduler, the second on a 
single ATA disk with CFQ scheduler. In the first case 10 writer threads 
are sufficient to give large delays, in the second case I've run an 
additional tar thread reading from the disk.

The logs are here:
http://galaxy.agh.edu.pl/~szymans/logs/

Each writer starts with:
Writing 200 MB to stdout without fsync

than reports each write() that lasts > 3s along with pid:
6582 - Delayed 4806 ms.

And finishes with:
Max write delay: 14968 ms.

Andrzej.
