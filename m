Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVAUHBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVAUHBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:01:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:46273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262093AbVAUHBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:01:07 -0500
Date: Thu, 20 Jan 2005 23:00:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
Message-Id: <20050120230016.442e5835.akpm@osdl.org>
In-Reply-To: <20050121065235.GD17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random>
	<20050121054916.GB12647@dualathlon.random>
	<20050120222056.61b8b1c3.akpm@osdl.org>
	<1106289375.5171.7.camel@npiggin-nld.site>
	<20050121065235.GD17050@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Anyway if you leave it off by default I don't mind, with my new code
>  forward ported stright from 2.4 mainline, it's possible for the first
>  time to set it from userspace without having to embed knowledge on the
>  kernel min_kbytes settings at boot time.

Last time we dicsussed this you pointed out that reserving more lowmem from
highmem-capable allocations may actually *help* things.  (Tries to remember
why) By reducing inode/dentry eviction rates?  I asked Martin Bligh if he
could test that on a big NUMA box but iirc the results were inconclusive.

Maybe it just won't make much difference.  Hard to say.

>  The sysctl name had to change to lowmem_reserve_ratio because its
>  semantics are completely different now.

That reminds me.  Documentation/filesystems/proc.txt ;)

I'll cook something up for that.
