Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSKVRZj>; Fri, 22 Nov 2002 12:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSKVRZi>; Fri, 22 Nov 2002 12:25:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:1507 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265171AbSKVRZi>;
	Fri, 22 Nov 2002 12:25:38 -0500
Message-ID: <3DDE6A2F.FA805154@digeo.com>
Date: Fri, 22 Nov 2002 09:32:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] Latest -rmap15 stuff against 2.4.20-rc2-ac2
References: <20021121225507.GH20701@stingr.net> <20021122083828.R628@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2002 17:32:31.0820 (UTC) FILETIME=[231040C0:01C2924D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Fri, Nov 22, 2002 at 01:55:07AM +0300, Paul P Komkoff Jr wrote:
> > ChangeSet@1.695.1.6, 2002-11-21 16:42:17-02:00, riel@duckman.distro.conectiva
> >   first stab at fine-tuning arjan's O(1) VM
> [...]
> >   - preferentially deactivate file cache pages, if there are many
> >     of those
> 
> You guys don't know, how much admins have dared to get this
> behavior (back).
> 
> We will make a lot of admins very happy with that.
> 

This is what /proc/sys/vm/swappiness does in 2.5, actually.  It defines
the kernel's preference for pagecache over mapped memory.

Setting it to 100 (percent) makes it treat both types of memory equally.

Setting it to zero makes the kernel very much prefer to reclaim plain
pagecache rather than mapped-into-pagetables memory.
